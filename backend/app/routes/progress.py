#backend/app/routes/progress.py


from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from ..models.database import get_db
from ..models.schemas import ProgressResponse
from ..services.progress_service import progress_service

router = APIRouter(prefix="/api/progress", tags=["progress"])

@router.get("/", response_model=ProgressResponse)
def get_progress(db: Session = Depends(get_db)):
    return progress_service.get_progress(db)