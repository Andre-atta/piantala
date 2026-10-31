/**
 * opb_token_manager.ts
 *
 * Gestisce il token OAuth2 per le chiamate di scrittura a OpenPlantBook
 * (POST /api/v1/plant/create e PATCH /api/v1/plant/update).
 *
 * Le letture (search, detail) continuano a usare l'API-key statica —
 * questo modulo è usato SOLO per le callable di scrittura.
 *
 * Caratteristiche:
 *  - Cache in memoria per tutta la vita dell'istanza Function (warm start).
 *  - Buffer di 60 s prima della scadenza per evitare race condition.
 *  - Anti-stampede: più invocazioni concorrenti con cache scaduta condividono
 *    la stessa Promise di fetch, invece di richiedere token separati.
 *  - Retry singolo su 401: invalida la cache e richiede un nuovo token.
 */

import fetch from "node-fetch";
import { HttpsError } from "firebase-functions/v2/https";

// ── Token URL OpenPlantBook (trailing slash obbligatorio — evita redirect 301) ──
const OPB_TOKEN_URL = "https://open.plantbook.io/api/v1/token/";

// ── Buffer prima della scadenza del token (ms) ────────────────────────────────
const EXPIRY_BUFFER_MS = 60_000; // 60 secondi

interface CachedToken {
  accessToken: string;
  expiresAt: number; // Unix timestamp in ms
}

// Cache in memoria — condivisa tra le invocazioni sulla stessa istanza calda.
let _cache: CachedToken | null = null;

// Anti-stampede: Promise in corso (se non null, riusiamo questa invece di
// avviarne una seconda in parallelo sulla stessa istanza).
let _pendingRequest: Promise<string> | null = null;

/**
 * Ottiene un access token valido. Usa la cache se disponibile e non scaduta.
 * Se la cache è scaduta e non c'è già una richiesta in corso, ne avvia una nuova.
 */
export async function getAccessToken(
  clientId: string,
  clientSecret: string,
): Promise<string> {
  const now = Date.now();

  // Cache valida: ritorna subito.
  if (_cache && _cache.expiresAt > now + EXPIRY_BUFFER_MS) {
    return _cache.accessToken;
  }

  // Richiesta già in corso: riusa la stessa Promise (anti-stampede).
  if (_pendingRequest) {
    return _pendingRequest;
  }

  // Avvia nuova richiesta.
  _pendingRequest = _fetchToken(clientId, clientSecret).finally(() => {
    _pendingRequest = null;
  });

  return _pendingRequest;
}

/**
 * Invalida la cache e forza il refresh al prossimo getAccessToken().
 */
export function invalidateCache(): void {
  _cache = null;
}

/**
 * Chiama la callable fn con un token valido.
 * Se fn lancia un errore con status 401, invalida la cache e riprova una volta.
 * Se il secondo tentativo restituisce ancora 401, lancia HttpsError.
 */
export async function withAutoRefresh<T>(
  clientId: string,
  clientSecret: string,
  fn: (token: string) => Promise<T>,
): Promise<T> {
  const token = await getAccessToken(clientId, clientSecret);

  try {
    return await fn(token);
  } catch (e: any) {
    // Controlla sia il campo status (fetch Response) sia il codice HTTP raw.
    const is401 = e?.status === 401 || e?.response?.status === 401;
    if (!is401) throw e;

    // Invalida cache e richiede un nuovo token (una sola volta).
    invalidateCache();
    const freshToken = await getAccessToken(clientId, clientSecret);
    return fn(freshToken);
  }
}

// ── Implementazione interna ───────────────────────────────────────────────────

async function _fetchToken(
  clientId: string,
  clientSecret: string,
): Promise<string> {
  const body = new URLSearchParams({
    grant_type: "client_credentials",
    client_id: clientId,
    client_secret: clientSecret,
  });

  let response: Awaited<ReturnType<typeof fetch>>;
  try {
    response = await fetch(OPB_TOKEN_URL, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: body.toString(),
    });
  } catch (err) {
    console.error("[opb_token_manager] Errore di rete durante il fetch del token:", err);
    throw new HttpsError("internal", "Impossibile contattare OpenPlantBook per l'autenticazione.");
  }

  if (!response.ok) {
    console.error(`[opb_token_manager] Token request failed: ${response.status} ${response.statusText}`);
    if (response.status === 400 || response.status === 401) {
      throw new HttpsError(
        "unauthenticated",
        `OpenPlantBook ha rifiutato le credenziali OAuth2 (HTTP ${response.status}).`,
      );
    }
    throw new HttpsError("internal", `Errore OpenPlantBook token endpoint: ${response.status}`);
  }

  const data = (await response.json()) as {
    access_token: string;
    expires_in: number;
    token_type: string;
  };

  if (!data.access_token) {
    throw new HttpsError("internal", "OpenPlantBook ha risposto senza access_token.");
  }

  const now = Date.now();
  _cache = {
    accessToken: data.access_token,
    expiresAt: now + data.expires_in * 1_000,
  };

  console.log(
    `[opb_token_manager] Token ottenuto. Scadenza: ${new Date(_cache.expiresAt).toISOString()}`,
  );

  return _cache.accessToken;
}
