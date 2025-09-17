# backend/app/utils/file_handler.py
import json
import os
from pathlib import Path

class FileHandler:
    RESULTS_FILE = "quiz_results.txt"
    
    @staticmethod
    def _ensure_file_exists():
        """Ensure that RESULTS_FILE exists with proper content"""
        file_path = Path(FileHandler.RESULTS_FILE)
        
        # If file doesn't exist or is empty, create it with empty array
        if not file_path.exists() or file_path.stat().st_size == 0:
            try:
                with open(FileHandler.RESULTS_FILE, 'w') as f:
                    json.dump([], f)
                print(f"Created {FileHandler.RESULTS_FILE} with empty array")
            except Exception as e:
                print(f"Error creating {FileHandler.RESULTS_FILE}: {e}")
    
    @staticmethod
    def save_progress(data: dict):
        try:
            FileHandler._ensure_file_exists()
            
            with open(FileHandler.RESULTS_FILE, 'w') as f:
                json.dump(data, f, indent=2)
            print(f"Progress saved successfully to {FileHandler.RESULTS_FILE}")
            return True
        except Exception as e:
            print(f"Error saving progress: {e}")
            return False
    
    @staticmethod
    def load_progress():
        try:
            FileHandler._ensure_file_exists()
            
            with open(FileHandler.RESULTS_FILE, 'r') as f:
                return json.load(f)
        except Exception as e:
            print(f"Error loading progress: {e}")
        return None

    @staticmethod
    def file_exists_and_has_content():
        """Check if the results file exists and has content"""
        try:
            file_path = Path(FileHandler.RESULTS_FILE)
            return file_path.exists() and file_path.is_file() and file_path.stat().st_size > 0
        except Exception as e:
            print(f"Error checking file existence: {e}")
            return False