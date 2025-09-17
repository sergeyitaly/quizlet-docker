# backend/app/services/quiz_service.py
from sqlalchemy.orm import Session
from ..models.database import Question, QuizResult
from ..models.schemas import QuizSubmission
import datetime
from collections import defaultdict
from typing import List, Dict, Any

class QuizService:
    @staticmethod
    def get_questions(db: Session, categories: List[Dict[str, str]], limit: int = 10):
        """Get questions from multiple categories"""
        all_questions = []
        
        for cat in categories:
            if isinstance(cat, dict):
                category_name = cat.get('category')
                subcategory_name = cat.get('subcategory')
            else:
                category_name = getattr(cat, 'category', None)
                subcategory_name = getattr(cat, 'subcategory', None)
            
            if category_name and subcategory_name:
                questions = db.query(Question).filter(
                    Question.category == category_name,
                    Question.subcategory == subcategory_name
                ).limit(limit).all()
                all_questions.extend(questions)
        
        return all_questions
    
    @staticmethod
    def submit_quiz(db: Session, submission: QuizSubmission):
        all_questions = []
        for cat in submission.categories:
            if isinstance(cat, dict):
                category_name = cat.get('category')
                subcategory_name = cat.get('subcategory')
            else:
                category_name = getattr(cat, 'category', None)
                subcategory_name = getattr(cat, 'subcategory', None)
            
            if category_name and subcategory_name:
                questions = db.query(Question).filter(
                    Question.category == category_name,
                    Question.subcategory == subcategory_name
                ).all()
                all_questions.extend(questions)
        
        correct_count = 0
        answer_details = []
        
        for answer in submission.answers:
            question = next((q for q in all_questions if q.id == answer.question_id), None)
            is_correct = question and question.correct_answer == answer.selected_answer
            if is_correct:
                correct_count += 1
            
            answer_details.append({
                "question_id": answer.question_id,
                "selected_answer": answer.selected_answer,
                "question_text": answer.question_text,
                "correct_answer": answer.correct_answer,
                "is_correct": is_correct
            })
        
        percentage = (correct_count / len(submission.answers)) * 100 if submission.answers else 0

        for cat in submission.categories:
            if isinstance(cat, dict):
                category_name = cat.get('category')
                subcategory_name = cat.get('subcategory')
            else:
                category_name = getattr(cat, 'category', None)
                subcategory_name = getattr(cat, 'subcategory', None)
            
            if category_name and subcategory_name:
                db_result = QuizResult(
                    user_name="anonymous",
                    category=category_name,
                    subcategory=subcategory_name,
                    total_questions=len(submission.answers),
                    score=correct_count,  
                    percentage=percentage,
                    timestamp=datetime.datetime.now(),
                    duration_seconds=submission.duration_seconds or 0
                    
                )
                db.add(db_result)
        
        db.commit()
        
        return {
            "categories": submission.categories,
            "total_questions": len(submission.answers),
            "correct_answers": correct_count,  
            "percentage": percentage,
            "duration_seconds": submission.duration_seconds or 0,   # ✅ return it too
            "answer_details": answer_details
        }

    @staticmethod
    def get_categories(db: Session):
        categories = db.query(Question.category, Question.subcategory).distinct().all()
        
        # Group by category
        category_dict = defaultdict(list)
        for cat, sub in categories:
            category_dict[cat].append(sub)

        return [
            {
                "id": idx + 1,
                "name": category,
                "subcategories": subcategories
            }
            for idx, (category, subcategories) in enumerate(category_dict.items())
        ]

quiz_service = QuizService()