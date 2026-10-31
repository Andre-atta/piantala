/**
 * opb_quota_manager.ts
 *
 * Gestisce la quota giornaliera di contribuzioni per utente verso OpenPlantBook.
 *
 * La collection Firestore usata è `_quotas/{uid}` — root-level, con
 * security rules "allow read, write: if false" (solo Admin SDK può scriverla).
 * In questo modo il client non può azzerare il proprio contatore.
 *
 * Struttura documento `_quotas/{uid}`:
 *   {
 *     date:  string,  // 'YYYY-MM-DD' — data corrente
 *     count: number,  // contribuzioni nella data corrente
 *   }
 */

import * as admin from "firebase-admin";
import { HttpsError } from "firebase-functions/v2/https";

// ── Limite giornaliero (create + update combinati) ────────────────────────────
export const DAILY_LIMIT = 5;

// ── Helpers ───────────────────────────────────────────────────────────────────

function todayString(): string {
  return new Date().toISOString().slice(0, 10); // 'YYYY-MM-DD'
}

/**
 * Verifica che l'utente non abbia superato la quota giornaliera, poi incrementa
 * il contatore atomicamente.
 *
 * Lancia HttpsError('resource-exhausted') se la quota è esaurita.
 * Usa una transazione Firestore per evitare race condition tra invocazioni parallele.
 */
export async function checkAndIncrementQuota(uid: string): Promise<void> {
  const db = admin.firestore();
  const ref = db.collection("_quotas").doc(uid);
  const today = todayString();

  await db.runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    const data = snap.exists ? (snap.data() as { date: string; count: number }) : null;

    // Se il documento non esiste o la data è diversa da oggi, resetta il contatore.
    if (!data || data.date !== today) {
      tx.set(ref, { date: today, count: 1 });
      return;
    }

    if (data.count >= DAILY_LIMIT) {
      throw new HttpsError(
        "resource-exhausted",
        // Messaggio generico — non esporre il limite numerico al client.
        "Hai raggiunto il numero massimo di contribuzioni per oggi. Riprova domani.",
      );
    }

    tx.update(ref, { count: admin.firestore.FieldValue.increment(1) });
  });
}
