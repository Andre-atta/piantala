import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { after, before, test } from 'node:test';
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} from '@firebase/rules-unit-testing';
import { doc, getDoc, setDoc } from 'firebase/firestore';
import { getBytes, ref, uploadBytes } from 'firebase/storage';

const readRules = (path) =>
  readFileSync(new URL(path, import.meta.url), 'utf8');

let testEnv;

before(async () => {
  testEnv = await initializeTestEnvironment({
    projectId: 'demo-piantala-rules',
    firestore: { rules: readRules('../../../firestore.rules') },
    storage: { rules: readRules('../../../storage.rules') },
  });
});

after(async () => {
  await testEnv?.cleanup();
});

test('Firestore authorizes only user documents and denies quota access', async () => {
  const owner = testEnv.authenticatedContext('owner').firestore();
  const other = testEnv.authenticatedContext('other').firestore();
  const userDocument = doc(owner, 'users/owner/plants/plant-1');

  await assertSucceeds(setDoc(userDocument, { customName: 'Felce' }));
  await assertSucceeds(getDoc(userDocument));
  await assertFails(getDoc(doc(other, 'users/owner/plants/plant-1')));
  await assertFails(
    setDoc(doc(other, 'users/owner/plants/plant-1'), { customName: 'No' }),
  );
  await assertFails(getDoc(doc(owner, '_quotas/owner')));
  await assertFails(
    setDoc(doc(owner, '_quotas/owner'), { date: '2026-11-10', count: 1 }),
  );
});

test('Storage restricts access and validates image size and MIME type', async () => {
  const owner = testEnv.authenticatedContext('owner').storage();
  const other = testEnv.authenticatedContext('other').storage();
  const unauthenticated = testEnv.unauthenticatedContext().storage();
  const path = 'users/owner/plants/plant-1/1.jpg';
  const image = new Uint8Array([0xff, 0xd8, 0xff]);

  await assertSucceeds(
    uploadBytes(ref(owner, path), image, { contentType: 'image/jpeg' }),
  );
  await assertFails(getBytes(ref(other, path)));
  await assertFails(getBytes(ref(unauthenticated, path)));
  await assertFails(
    uploadBytes(
      ref(owner, 'users/owner/plants/plant-1/large.jpg'),
      new Uint8Array(5 * 1024 * 1024 + 1),
      { contentType: 'image/jpeg' },
    ),
  );
  await assertFails(
    uploadBytes(
      ref(owner, 'users/owner/plants/plant-1/document.pdf'),
      new Uint8Array([0x25, 0x50, 0x44, 0x46]),
      { contentType: 'application/pdf' },
    ),
  );
});
