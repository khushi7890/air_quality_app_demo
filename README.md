# air_quality_app demo — Full-Stack Scaffold

This is a **starter scaffold** for a multi-layer architecture using **Flutter + Dart** (UI, ViewModel, Repository, Service), **FastAPI** (backend), and **Firebase + Firestore** (cloud layer) with a **sample Cloud Function**.

> Note: Flutter project folders must be snake_case with no spaces.
We therefore created the Flutter project as `air_quality_app_demo`.

---

## Structure
```
air_quality_app_demo/
├─ frontend/                  # Flutter app
├─ backend/                   # FastAPI service
└─ cloud/                     # Firebase config + Functions sample
```

---

## Quick Start

### 1) Backend (FastAPI)
```bash
cd backend
python -m venv .venv
# Windows: .venv\Scripts\activate
# macOS/Linux:
source .venv/bin/activate
pip install -r requirements.txt
# Put your Firebase Admin key at backend/serviceAccountKey.json
# (download from Firebase Console -> Project Settings -> Service accounts)
uvicorn main:app --reload
# local base URL: http://127.0.0.1:8000
```

### 2) Cloud (Firebase)
- Install Firebase CLI (one-time): https://firebase.google.com/docs/cli
- Log in and select your project:
```bash
cd cloud
firebase login
firebase use --add
```
- Deploy the sample function (after you have a project selected):
```bash
cd functions
npm install
firebase deploy --only functions
```

### 3) Frontend (Flutter)
```bash
cd frontend
# Option A: If you already have a Firebase project configured for Flutter:
# flutterfire configure
flutter pub get
flutter run -d emulator-5554   # or pick your Android emulator device id
```
> Android emulator accessing local FastAPI: use `http://10.0.2.2:8000` (already set in the code).

---

## Securing FastAPI with Firebase Auth (optional)
- Verify Firebase ID tokens from the app and protect endpoints.
- See `backend/routers/auth_example.py` for a stub you can build out.

---

## Notes
- Replace placeholders (`<your-project-id>`, etc.) in `cloud/firebase.json` as needed.
- The scaffold reads Firestore via Firebase Admin SDK on the backend and also shows how to call external APIs from Cloud Functions.
- The frontend demonstrates View → ViewModel → Repository → Service wiring and a simple list UI.

Happy building! 🚀
