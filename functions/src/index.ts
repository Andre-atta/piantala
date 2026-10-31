import { onCall, HttpsError } from "firebase-functions/v2/https";
import { defineSecret } from "firebase-functions/params";
import * as admin from "firebase-admin";
import fetch from "node-fetch";

import { withAutoRefresh } from "./opb_token_manager";
import { checkAndIncrementQuota } from "./opb_quota_manager";

admin.initializeApp();

// ── Secrets ───────────────────────────────────────────────────────────────────

// Usato dalle callable di LETTURA esistenti (search / detail).
const openPlantBookApiKey = defineSecret("OPENPLANTBOOK_API_KEY");

// Usati dalle callable di SCRITTURA (contribute / update).
// Richiedono OAuth2 Client Credentials (scope: read write).
const openPlantBookClientId = defineSecret("OPENPLANTBOOK_CLIENT_ID");
const openPlantBookClientSecret = defineSecret("OPENPLANTBOOK_CLIENT_SECRET");

// ── Base URL ──────────────────────────────────────────────────────────────────
const OPB_BASE = "https://open.plantbook.io";

// ── Header builder ────────────────────────────────────────────────────────────

/**
 * Costruisce gli header HTTP per l'API OpenPlantBook.
 *
 * - 'read'  → Authorization: Token <api-key>  (letture — invariate rispetto all'esistente)
 * - 'write' → Authorization: Bearer <oauth2-access-token>  (scritture)
 *
 * NON mescolare i due tipi: Token non funziona su create/update, Bearer non
 * è necessario su search/detail.
 */
function buildReadHeaders(apiKey: string): Record<string, string> {
  return {
    "Authorization": `Token ${apiKey}`,
    "Accept": "application/json",
  };
}

function buildWriteHeaders(accessToken: string): Record<string, string> {
  return {
    "Authorization": `Bearer ${accessToken}`,
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
}

// ── Callable di LETTURA (invariate) ───────────────────────────────────────────

/**
 * Cerca piante nell'API di OpenPlantBook.
 * Usa l'API-key statica (Token auth) — non richiede OAuth2.
 */
export const searchSpecies = onCall(
  {
    region: "europe-west1",
    enforceAppCheck: true,
    secrets: [openPlantBookApiKey],
  },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "Devi effettuare l'accesso per cercare piante.");
    }

    const { query } = request.data;
    if (!query || typeof query !== "string" || query.trim().length < 3) {
      throw new HttpsError("invalid-argument", "La query deve avere almeno 3 caratteri.");
    }

    const apiKey = openPlantBookApiKey.value();
    const url = `${OPB_BASE}/api/v1/plant/search?alias=${encodeURIComponent(query)}&limit=20`;

    try {
      const response = await fetch(url, {
        method: "GET",
        headers: buildReadHeaders(apiKey),
      });

      if (!response.ok) {
        if (response.status === 429) {
          throw new HttpsError("resource-exhausted", "Rate limit OpenPlantBook superato.");
        }
        throw new HttpsError("internal", `Errore OpenPlantBook: ${response.status} ${response.statusText}`);
      }

      const data = await response.json() as any;

      const normalized = {
        count: data.count,
        next: data.next,
        previous: data.previous,
        results: (data.results || []).map((p: any) => ({
          pid: p.pid,
          scientific_name: p.display_pid ?? p.pid,
          common_name: p.alias ?? p.display_pid ?? p.pid,
          category: p.category ?? null,
          default_image: p.image_url
            ? { thumbnail: p.image_url, small_url: p.image_url }
            : null,
        })),
      };
      return normalized;
    } catch (error) {
      console.error("Errore durante searchSpecies:", error);
      if (error instanceof HttpsError) throw error;
      throw new HttpsError("internal", "Impossibile comunicare con OpenPlantBook API.");
    }
  },
);

/**
 * Ottiene il dettaglio completo di una pianta da OpenPlantBook.
 * Usa l'API-key statica (Token auth) — non richiede OAuth2.
 */
export const getSpeciesDetail = onCall(
  {
    region: "europe-west1",
    enforceAppCheck: true,
    secrets: [openPlantBookApiKey],
  },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "Devi effettuare l'accesso per vedere i dettagli della pianta.");
    }

    const { pid } = request.data;
    if (!pid || typeof pid !== "string") {
      throw new HttpsError("invalid-argument", "Il PID della specie è obbligatorio e deve essere una stringa.");
    }

    const apiKey = openPlantBookApiKey.value();
    const url = `${OPB_BASE}/api/v1/plant/detail/${encodeURIComponent(pid)}/?include=care`;

    try {
      const response = await fetch(url, {
        method: "GET",
        headers: buildReadHeaders(apiKey),
      });

      if (!response.ok) {
        if (response.status === 429) throw new HttpsError("resource-exhausted", "Rate limit OpenPlantBook superato.");
        if (response.status === 404) throw new HttpsError("not-found", "Specie non trovata su OpenPlantBook.");
        throw new HttpsError("internal", `Errore OpenPlantBook: ${response.status} ${response.statusText}`);
      }

      const data = await response.json() as any;

      const commonNameIt = (data.common_names || []).find((n: any) => n.language_code === "it")?.name;
      const commonNameEn = (data.common_names || []).find((n: any) => n.language_code === "en")?.name;
      const care = data.care_instructions || data.care || {};

      return {
        pid: data.pid,
        scientific_name: data.display_pid ?? data.pid,
        common_name: commonNameIt ?? commonNameEn ?? data.alias ?? data.display_pid,
        category: data.category ?? null,
        origin: data.origin ?? null,
        care_soil: care.soil ?? data.soil ?? null,
        care_fertilization: care.fertilization ?? data.fertilization ?? null,
        care_pruning: care.pruning ?? data.pruning ?? null,
        image_url: data.image_url ?? null,
        default_image: data.image_url
          ? { thumbnail: data.image_url, small_url: data.image_url, regular_url: data.image_url }
          : null,
        max_light_mmol: data.max_light_mmol ?? null,
        min_light_mmol: data.min_light_mmol ?? null,
        max_light_lux: data.max_light_lux ?? null,
        min_light_lux: data.min_light_lux ?? null,
        max_temp: data.max_temp ?? null,
        min_temp: data.min_temp ?? null,
        max_env_humid: data.max_env_humid ?? null,
        min_env_humid: data.min_env_humid ?? null,
        max_soil_moist: data.max_soil_moist ?? null,
        min_soil_moist: data.min_soil_moist ?? null,
        max_soil_ec: data.max_soil_ec ?? null,
        min_soil_ec: data.min_soil_ec ?? null,
      };
    } catch (error) {
      console.error("Errore durante getSpeciesDetail:", error);
      if (error instanceof HttpsError) throw error;
      throw new HttpsError("internal", "Impossibile comunicare con OpenPlantBook API.");
    }
  },
);

// ── Callable di SCRITTURA (nuove) ─────────────────────────────────────────────

/**
 * Contribuisce una nuova specie al profilo OpenPlantBook condiviso dell'app.
 *
 * Semantica:
 *  - La specie viene inserita nel profilo OpenPlantBook dell'account le cui
 *    credenziali stanno in Secret Manager (NON nel database pubblico).
 *  - Tutti i contributi confluiscono nello stesso account OPB.
 *  - 201 → { success: true, pid: string }
 *  - 409 → { alreadyExists: true }  (non è un errore — usare updateSpecies)
 *  - 400 → { validationError: { field: string, message: string } }
 *  - 429 → { rateLimited: true }
 */
export const contributeSpecies = onCall(
  {
    region: "europe-west1",
    enforceAppCheck: true,
    secrets: [openPlantBookApiKey, openPlantBookClientId, openPlantBookClientSecret],
  },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "Devi effettuare l'accesso per contribuire.");
    }

    const uid = request.auth.uid;
    const payload = request.data as Record<string, unknown>;

    // Sanity check: display_pid obbligatorio (la validazione dettagliata è lato client)
    if (!payload.display_pid || typeof payload.display_pid !== "string") {
      throw new HttpsError("invalid-argument", "Il campo display_pid è obbligatorio.");
    }

    // Rimuove campi che il server ignora o gestisce lui (pid, user, common_names)
    const { pid: _pid, user: _user, common_names: _cn, ...safePayload } = payload as any;

    // Verifica e incrementa la quota giornaliera (Admin SDK → non scrivibile dal client)
    await checkAndIncrementQuota(uid);

    const clientId = openPlantBookClientId.value();
    const clientSecret = openPlantBookClientSecret.value();

    return withAutoRefresh(clientId, clientSecret, async (token) => {
      const response = await fetch(`${OPB_BASE}/api/v1/plant/create`, {
        method: "POST",
        headers: buildWriteHeaders(token),
        body: JSON.stringify(safePayload),
      });

      if (response.status === 201) {
        const data = await response.json() as any;
        return { success: true, pid: data.pid };
      }

      if (response.status === 409) {
        // Non è un errore — la specie esiste già. Il client può proporre un update.
        return { alreadyExists: true };
      }

      if (response.status === 429) {
        // Rate limit OPB — il client riproverà via PendingOperationCollection (backoff)
        return { rateLimited: true };
      }

      if (response.status === 400) {
        const body = await response.json() as any;
        // drf-standardized-errors format: { type, errors: [{ code, detail, attr }] }
        const firstError = body?.errors?.[0];
        return {
          validationError: {
            field: firstError?.attr ?? "unknown",
            message: firstError?.detail ?? "Dati non validi.",
          },
        };
      }

      const text = await response.text().catch(() => "");
      console.error(`[contributeSpecies] Risposta inattesa ${response.status}: ${text}`);
      throw new HttpsError("internal", `Errore OpenPlantBook: ${response.status}`);
    });
  },
);

/**
 * Aggiorna (o clona+aggiorna) una specie nel profilo OpenPlantBook condiviso.
 *
 * Se il pid si riferisce a una pianta pubblica, OPB la clona nel profilo e applica
 * le modifiche alla copia. La pianta pubblica originale NON viene modificata.
 *
 * Richiede almeno un attributo oltre al pid (altrimenti OPB ritorna 400).
 * Solo PATCH è supportato (non PUT).
 */
export const updateSpecies = onCall(
  {
    region: "europe-west1",
    enforceAppCheck: true,
    secrets: [openPlantBookApiKey, openPlantBookClientId, openPlantBookClientSecret],
  },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "Devi effettuare l'accesso per aggiornare una specie.");
    }

    const uid = request.auth.uid;
    const { pid, ...partialPayload } = request.data as { pid: string; [key: string]: unknown };

    if (!pid || typeof pid !== "string") {
      throw new HttpsError("invalid-argument", "Il campo pid è obbligatorio.");
    }

    if (Object.keys(partialPayload).length === 0) {
      throw new HttpsError(
        "invalid-argument",
        "Fornire almeno un attributo oltre al pid.",
      );
    }

    // Verifica e incrementa la quota giornaliera
    await checkAndIncrementQuota(uid);

    const clientId = openPlantBookClientId.value();
    const clientSecret = openPlantBookClientSecret.value();

    return withAutoRefresh(clientId, clientSecret, async (token) => {
      const response = await fetch(`${OPB_BASE}/api/v1/plant/update`, {
        method: "PATCH",
        headers: buildWriteHeaders(token),
        body: JSON.stringify({ pid, ...partialPayload }),
      });

      if (response.status === 200) {
        const data = await response.json() as any;
        return { success: true, pid: data.pid };
      }

      if (response.status === 429) {
        return { rateLimited: true };
      }

      if (response.status === 400) {
        const body = await response.json() as any;
        const firstError = body?.errors?.[0];
        return {
          validationError: {
            field: firstError?.attr ?? "unknown",
            message: firstError?.detail ?? "Dati non validi.",
          },
        };
      }

      if (response.status === 404) {
        throw new HttpsError("not-found", "Specie non trovata su OpenPlantBook.");
      }

      // 405 non dovrebbe mai arrivare dal client Flutter (usiamo sempre PATCH),
      // ma lo logghiamo come errore interno se accade.
      if (response.status === 405) {
        console.error("[updateSpecies] 405 Method Not Allowed — assicurarsi di usare PATCH.");
        throw new HttpsError("internal", "Metodo HTTP non supportato da OpenPlantBook (usa PATCH).");
      }

      const text = await response.text().catch(() => "");
      console.error(`[updateSpecies] Risposta inattesa ${response.status}: ${text}`);
      throw new HttpsError("internal", `Errore OpenPlantBook: ${response.status}`);
    });
  },
);
