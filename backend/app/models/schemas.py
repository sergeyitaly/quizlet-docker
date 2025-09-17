from pydantic import BaseModel
from typing import List, Optional, Dict, Any
from datetime import datetime

class QuestionBase(BaseModel):
    category: str
    subcategory: str
    question_text: str
    option_a: str
    option_b: str
    option_c: str
    option_d: str
    correct_answer: str
    difficulty_level: int 

class QuestionCreate(QuestionBase):
    pass

class QuestionResponse(QuestionBase):
    id: int
    
    class Config:
        from_attributes = True

class FrontendQuestionResponse(BaseModel):
    id: int
    category: str
    subcategory: str
    question_text: str
    options: List[str]
    correct_answer: str
    difficulty: str
    
    class Config:
        from_attributes = True

class CategorySelection(BaseModel):
    category: str
    subcategory: str

class AnswerDetail(BaseModel):
    question_id: int
    selected_answer: str
    question_text: str
    correct_answer: str

class QuizSubmission(BaseModel):
    categories: List[CategorySelection]
    total_questions: int
    answers: List[AnswerDetail]
    timestamp: Optional[datetime] = None
    duration_seconds: Optional[int] = 0
    
class QuizDataWrapper(BaseModel):
    quiz_data: QuizSubmission

class QuizResult(BaseModel):
    categories: List[CategorySelection]
    total_questions: int
    correct_answers: int
    percentage: float
    timestamp: Optional[datetime] = None

class ProgressResponse(BaseModel):
    overall_progress: dict
    category_progress: dict