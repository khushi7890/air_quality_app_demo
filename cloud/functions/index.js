const functions = require('firebase-functions');
const admin = require('firebase-admin');
const fetch = (...args) => import('node-fetch').then(({default: fetch}) => fetch(...args));

admin.initializeApp();
const db = admin.firestore();

// Example: React to writes in sensors/{sensorId} and enrich with external API data
exports.enrichSensorFromExternal = functions.firestore
  .document('sensors/{sensorId}')
  .onWrite(async (change, context) => {
    const after = change.after.exists ? change.after.data() : null;
    if (!after) return null;

    try {
      // Example external call (replace with your Tellus API)
      // const res = await fetch('https://api.example.com/pollutants?device=' + after.deviceId);
      // const ext = await res.json();
      const ext = { source: 'demo-function', pm10: 12.3 };

      await change.after.ref.set({ external: ext }, { merge: true });
      return true;
    } catch (e) {
      console.error('Function error', e);
      return false;
    }
  });
