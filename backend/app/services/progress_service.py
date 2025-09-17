# backend/app/services/progress_service.py
from sqlalchemy.orm import Session
from ..models.database import QuizResult
from ..utils.file_handler import FileHandler
import json

class ProgressService:
    @staticmethod
    def get_progress(db: Session):
        results = db.query(QuizResult).all()
        
        overall = {
            "total_quizzes": len(results),
            "total_questions": sum(r.total_questions for r in results),
            "total_correct": sum(r.score for r in results),  
            "overall_percentage": (sum(r.score for r in results) / 
                                 sum(r.total_questions for r in results) * 100) if results else 0
        }
        
        category_progress = {}
        for result in results:
            key = f"{result.category}_{result.subcategory}"
            if key not in category_progress:
                category_progress[key] = {
                    "category": result.category,
                    "subcategory": result.subcategory,
                    "total_quizzes": 0,
                    "total_questions": 0,
                    "total_correct": 0
                }
            
            category_progress[key]["total_quizzes"] += 1
            category_progress[key]["total_questions"] += result.total_questions
            category_progress[key]["total_correct"] += result.score  
        
        # Calculate percentages
        for key in category_progress:
            cat_data = category_progress[key]
            cat_data["percentage"] = (cat_data["total_correct"] / cat_data["total_questions"] * 100 
                                    if cat_data["total_questions"] > 0 else 0)
        
        # Save to file
        FileHandler.save_progress({
            "overall": overall,
            "categories": category_progress
        })
        
        return {
            "overall_progress": overall,
            "category_progress": category_progress
        }

progress_service = ProgressService()