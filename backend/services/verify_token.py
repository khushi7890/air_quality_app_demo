from firebase_admin import auth

def verify_firebase_token(id_token: str):
    decoded = auth.verify_id_token(id_token)  # raises if invalid
    return decoded
