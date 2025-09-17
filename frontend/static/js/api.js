class API {
    static baseURL = 'http://localhost:8000';
    
    static async handleResponse(response) {
        if (!response.ok) {
            let errorData;
            try {
                errorData = await response.json();
                console.error('Server error details:', errorData);
            } catch (e) {
                console.error('Server error status:', response.status, response.statusText);
                errorData = { status: response.status, message: response.statusText };
            }
            
            const error = new Error(response.statusText);
            error.response = response;
            error.data = errorData;
            throw error;
        }
        return response.json();
    }
    
    static async getCategories() {
        const response = await fetch(`${this.baseURL}/api/quiz/categories`);
        return this.handleResponse(response);
    }

    static async getQuestions(categories) {
        // Convert categories to query string format: "category1:subcat1,category2:subcat2"
        const categoryString = categories.map(cat => 
            `${encodeURIComponent(cat.category)}:${encodeURIComponent(cat.subcategory)}`
        ).join(',');
        
        const response = await fetch(
            `${this.baseURL}/api/quiz/questions?categories=${categoryString}&limit=20`
        );
        
        return this.handleResponse(response);
    }

    static async submitQuiz(submission) {
        console.log('Submitting quiz data:', JSON.stringify(submission, null, 2));
        
        const response = await fetch(`${this.baseURL}/api/quiz/submit`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(submission),
        });
        
        return this.handleResponse(response);
    }

    static async getProgress() {
        const response = await fetch(`${this.baseURL}/api/progress/`);
        return this.handleResponse(response);
    }

    static async saveResultsToFile(results) {
        const response = await fetch(`${this.baseURL}/api/quiz/save-results`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(results),
        });
        
        return this.handleResponse(response);
    }
    static async getQuizHistory() {
            const response = await fetch(`${this.baseURL}/api/quiz/history`);
            return this.handleResponse(response);
        }
    static async checkQuizHistoryExists() {
        const response = await fetch(`${this.baseURL}/api/quiz/history/exists`);
        return this.handleResponse(response);
    }

    async checkQuizHistory() {
        try {
            const historyExists = await API.checkQuizHistoryExists();
            this.hasQuizHistory = historyExists.exists; 
        } catch (error) {
            console.error('Error checking quiz history:', error);
            this.hasQuizHistory = false;
        }
    }

        
}