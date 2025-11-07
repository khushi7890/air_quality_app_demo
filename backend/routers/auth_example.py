from fastapi import APIRouter, HTTPException, Header
from services.verify_token import verify_firebase_token

router = APIRouter()

@router.get("/secure/ping")
def secure_ping(authorization: str = Header(None)):
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing Bearer token")
    id_token = authorization.split(" ", 1)[1]
    claims = verify_firebase_token(id_token)
    return {"ok": True, "uid": claims.get("uid")}
