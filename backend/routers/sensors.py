from fastapi import APIRouter, HTTPException
from services.firebase_service import get_sensor_data

router = APIRouter()

@router.get("/sensors")
def fetch_sensors():
    try:
        return get_sensor_data()
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
