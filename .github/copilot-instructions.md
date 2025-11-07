## Goal
Help an AI coding agent quickly understand and work in this mono-repo: Flutter frontend, FastAPI backend, and Firebase/Cloud Functions integration.

## Top-level overview
- Tech stack: Flutter (frontend), FastAPI (backend Python), Firestore + Firebase Admin, and Firebase Cloud Functions (Node example + Python scaffold).
- Layout: `frontend/` (Flutter app), `backend/` (FastAPI + services), `cloud/` (firebase.json, `functions/` samples).

## Key integration points (read these files first)
- `backend/services/firebase_service.py` — initializes Firebase Admin using `backend/serviceAccountKey.json`. Note: this file clears `GOOGLE_APPLICATION_CREDENTIALS` and asserts the local key exists.
- `backend/routers/sensors.py` — exposes `GET /sensors` which returns documents from Firestore `sensors` collection via `get_sensor_data()`.
- `backend/routers/auth_example.py` + `backend/services/verify_token.py` — example of protecting endpoints by verifying Firebase ID tokens (Header `Authorization: Bearer <id_token>`).
- `frontend/lib/main.dart` — app entry, constructs `Repository` with `ServiceFastAPI(baseUrl: "http://127.0.0.1:8000")` and `ServiceFirestore` (commented). Update baseUrl to `http://10.0.2.2:8000` for Android emulator.
- `frontend/lib/models/sensor_data.dart` — canonical SensorModel JSON mapping (fields: deviceId, AQI, location, timestamp).
- `cloud/functions/index.js` — example Firestore trigger that enriches `sensors/{sensorId}` writes with external data (shows merge pattern).

## Local developer workflows (concrete commands)
All commands use PowerShell on Windows (adjust for macOS/Linux as needed):

- Backend (FastAPI)
  - cd to backend
  - python -m venv .venv
  - .\.venv\Scripts\Activate
  - pip install -r requirements.txt
  - uvicorn main:app --reload
  - Local base URL: http://127.0.0.1:8000

- Frontend (Flutter)
  - cd frontend
  - flutter pub get
  - flutter run -d <device-id>
  - Note: Android emulator -> use host IP `10.0.2.2` to reach backend on the host (replace 127.0.0.1 in code).

- Cloud functions (node sample)
  - cd cloud/functions
  - npm install
  - firebase deploy --only functions

## Project-specific conventions & gotchas
- The backend expects `backend/serviceAccountKey.json` to exist and uses it directly; do not rely on external GOOGLE_APPLICATION_CREDENTIALS unless you change `firebase_service.py`.
- Firestore collection name: `sensors` — backend reads this collection and cloud function triggers are set on it.
- Frontend uses a small Repository abstraction (`frontend/lib/data/repository.dart`) that composes `ServiceFastAPI` and `ServiceFirestore`. Follow that pattern when adding new data sources.
- Code comment: Flutter project must be snake_case (this repo uses `air_quality_app_demo`).

## Useful examples for the agent
- To fetch sensor docs: GET http://127.0.0.1:8000/sensors (from host). From emulator, http://10.0.2.2:8000/sensors.
- To call a protected endpoint: send header `Authorization: Bearer <id_token>` to `/secure/ping` (see `backend/routers/auth_example.py`).
- Firestore enrich pattern (see `cloud/functions/index.js`): call external API, then `change.after.ref.set({ external: ext }, { merge: true })` to attach enrichments.

## What to avoid / security notes
- `backend/serviceAccountKey.json` is sensitive — in real deployments do NOT commit it. This repo contains a local key for demo only. If you modify how credentials are loaded, update `firebase_service.py` and tests.

## When editing or adding features
- For new server endpoints: add router under `backend/routers`, expose via `app.include_router(...)` in `backend/main.py`.
- For new Firestore-backed features: prefer adding a small service wrapper in `backend/services/` and call it from routers.
- For UI changes follow the existing pattern: models in `frontend/lib/models`, services in `frontend/lib/data`, screens in `frontend/lib/screens`.

## Where to look next (quick map)
- Backend: `backend/main.py`, `backend/routers/*`, `backend/services/*`.
- Frontend: `frontend/lib/main.dart`, `frontend/lib/data/*`, `frontend/lib/models/*`, `frontend/lib/screens/*`.
- Cloud: `cloud/functions/index.js`, `cloud/firebase.json`.

## Final note
If any part of the infra (Firebase project id, service account placement, or emulator device ids) is different on your machine, update the small number of literal values above and run the matching local command sequence.

If you want, I can now (1) expand this to include quick code pointers for common edits (add sensor field, add secure endpoint) or (2) create CI steps for flutter analyze and backend linting. Which would you prefer?
