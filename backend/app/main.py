from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from .models.database import init_db, engine, Base
from .routes import quiz, progress
from fastapi import Body
from .utils.file_handler import FileHandler 
import time
import sqlalchemy.exc
from sqlalchemy import text

app = FastAPI(title="Quizlet API", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:3000", 
        "http://127.0.0.1:3000",
        "http://localhost:80",     
        "http://127.0.0.1:80"      
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.on_event("startup")
def on_startup():
    FileHandler._ensure_file_exists()
    
    max_retries = 10
    retry_delay = 2  # seconds
    
    for attempt in range(max_retries):
        try:
            with engine.connect() as conn:
                conn.execute(text("SELECT 1"))
            print("Database connection test successful")
            
            init_db()
            print("Database initialized successfully")
            break
            
        except sqlalchemy.exc.OperationalError as e:
            if attempt < max_retries - 1:
                print(f"Database connection failed (attempt {attempt + 1}/{max_retries}), retrying in {retry_delay}s...")
                time.sleep(retry_delay)
                retry_delay *= 1.5
            else:
                print(f"Failed to connect to database after {max_retries} attempts: {e}")
        except Exception as e:
            print(f"Error initializing database: {e}")

app.include_router(quiz.router)
app.include_router(progress.router)

@app.post("/api/quiz/save-results")
async def save_quiz_results(results: dict = Body(...)):
    try:
        FileHandler.save_progress(results)
        return {"status": "success", "message": "Results saved successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to save results: {e}")

@app.get("/health")
async def health_check():
    try:
        with engine.connect() as conn:
            conn.execute(text("SELECT 1"))
        return {"status": "healthy", "database": "connected"}
    except Exception as e:
        return {"status": "degraded", "database": "disconnected", "error": str(e)}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)