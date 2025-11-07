import os

# 🚫 Force-clear any old Firebase credential path
os.environ.pop("GOOGLE_APPLICATION_CREDENTIALS", None)
print("🧹 Cleaned GOOGLE_APPLICATION_CREDENTIALS")

import firebase_admin
from firebase_admin import credentials, firestore

# Absolute path to service account key
SERVICE_ACCOUNT_PATH = os.path.join(
    os.path.dirname(__file__), "..", "serviceAccountKey.json"
)
SERVICE_ACCOUNT_PATH = os.path.abspath(SERVICE_ACCOUNT_PATH)

# ✅ DEBUG ASSERTION
assert os.path.exists(SERVICE_ACCOUNT_PATH), f"Service account file not found at: {SERVICE_ACCOUNT_PATH}"
print(f"✅ Firebase loading credentials from: {SERVICE_ACCOUNT_PATH}")


# Initialize Firebase // check if initialized so this only happens once
if not firebase_admin._apps:
    print("🧠 About to initialize Firebase manually...")

    cred = credentials.Certificate(SERVICE_ACCOUNT_PATH)
    print("✅ Firebase manually initialized")

    firebase_admin.initialize_app(cred)

# Create a Firestore client
db = firestore.client()

def get_sensor_data():
    """Return list of sensor documents as dictionaries."""
    docs = db.collection("sensors").stream() # Use this client to get a stream of sensor data
    return [d.to_dict() for d in docs] # store in a dictionary and return
