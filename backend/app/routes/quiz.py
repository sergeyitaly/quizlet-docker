# backend/app/routes/quiz.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..models.database import get_db
from sqlalchemy import text
from ..models.schemas import *
from ..services.quiz_service import quiz_service
from typing import List, Dict, Any
import datetime

router = APIRouter(prefix="/api/quiz", tags=["quiz"])


@router.post("/submit", response_model=Dict[str, Any])
async def submit_quiz(
    submission_data: Dict[str, Any] = None, 
    db: Session = Depends(get_db)
):
    try:
        if submission_data and "quiz_data" in submission_data:
            quiz_data = submission_data["quiz_data"]
            submission = QuizSubmission(**quiz_data)
        else:
            submission = QuizSubmission(**submission_data)
            submission.total_questions = len(submission.answers)
            submission.timestamp = datetime.datetime.now()
        
        if not submission_data:
            raise HTTPException(status_code=400, detail="No quiz data provided")
        if not hasattr(submission, "duration_seconds"):
            submission.duration_seconds = 0

        result = quiz_service.submit_quiz(db, submission)
        return result
        
    except Exception as e:
        raise HTTPException(status_code=422, detail=f"Error processing submission: {str(e)}")
    
@router.get("/categories")
async def get_categories(db: Session = Depends(get_db)):
    try:
        categories = quiz_service.get_categories(db) 
        return categories
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error fetching categories: {str(e)}")

@router.get("/questions")
async def get_questions(
    categories: str,  
    limit: int = 10,
    db: Session = Depends(get_db)
):
    try:
        category_list = []
        for cat_str in categories.split(','):
            if ':' in cat_str:
                cat, subcat = cat_str.split(':', 1)
                category_list.append({
                    "category": cat.strip(), 
                    "subcategory": subcat.strip()
                })
        
        questions = quiz_service.get_questions(db, category_list, limit)
        return questions
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error fetching questions: {str(e)}")
    
@router.get("/history")
async def get_quiz_history(db: Session = Depends(get_db)):
    try:
        result_proxy = db.execute(text("SELECT * FROM quiz_results ORDER BY timestamp DESC"))
        
        columns = result_proxy.keys()
        results = [dict(zip(columns, row)) for row in result_proxy.fetchall()]
        
        history = []
        for result in results:
            categories_data = [{
                "category": result.get('category', 'Unknown'),
                "subcategory": result.get('subcategory', 'Unknown')
            }]
            
            history.append({
                "id": result['id'],
                "categories": categories_data,
                "total_questions": result['total_questions'],
                "correct_answers": result['score'],
                "percentage": float(result['percentage']),
                "timestamp": result['timestamp'].isoformat() if hasattr(result['timestamp'], 'isoformat') else str(result['timestamp']),
                "duration_seconds": result.get('duration_seconds', 0)
            })
        
        return history
    except Exception as e:
        print(f"Error fetching quiz history: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Error fetching quiz history: {str(e)}")

@router.get("/history/exists")
async def check_quiz_history_exists(db: Session = Depends(get_db)):
    try:
        result = db.execute(text("SELECT COUNT(*) as count FROM quiz_results"))
        count = result.scalar()  # Get the count value
        
        return {"exists": count > 0}
    except Exception as e:
        print(f"Error checking quiz history existence: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Error checking quiz history: {str(e)}")