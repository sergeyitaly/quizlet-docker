class QuizletApp {
    constructor() {
        this.quizManager = new QuizManager();
        this.progressManager = new ProgressManager();
        this.selectedCategories = [];
        this.questionCount = 10;
        
        this.initializeApp();
    }

    async initializeApp() {
        await this.loadCategories();
        await this.progressManager.loadProgress();
        this.attachEventListeners();
    }

    async loadCategories() {
        try {
            const rawCategories = await API.getCategories();
            console.log('Categories received:', rawCategories);
            const categories = [];
            rawCategories.forEach(cat => {
                cat.subcategories.forEach(sub => {
                    categories.push({
                        category: cat.name,
                        subcategory: sub
                    });
                });
            });

            this.renderCategories(categories);
        } catch (error) {
            console.error('Error loading categories:', error);
        }
    }

    renderCategories(categories) {
        const container = document.getElementById('categories-list');
        container.innerHTML = '';

        const categoriesByMain = {};
        categories.forEach(({ category, subcategory }) => {
            if (!categoriesByMain[category]) {
                categoriesByMain[category] = [];
            }
            categoriesByMain[category].push(subcategory);
        });

        let html = '<div class="category-grid">';
        for (const [mainCat, subCats] of Object.entries(categoriesByMain)) {
            html += `
                <div class="category-card">
                    <h3>${mainCat}</h3>
                    ${subCats.map(subCat => `
                        <button class="subcategory-btn" data-category="${mainCat}" data-subcategory="${subCat}">
                            ${subCat}
                        </button>
                    `).join('')}
                </div>
            `;
        }
        html += '</div>';

        container.innerHTML = html;

        // Attach event listeners to subcategory buttons
        document.querySelectorAll('.subcategory-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const category = e.target.dataset.category;
                const subcategory = e.target.dataset.subcategory;
                
                // Toggle selection
                if (e.target.classList.contains('selected')) {
                    e.target.classList.remove('selected');
                    this.selectedCategories = this.selectedCategories.filter(
                        cat => !(cat.category === category && cat.subcategory === subcategory)
                    );
                } else {
                    e.target.classList.add('selected');
                    this.selectedCategories.push({ category, subcategory });
                }
                
                // Enable/disable start quiz button
                document.getElementById('start-quiz').disabled = this.selectedCategories.length === 0;
            });
        });
    }

    async startQuiz() {
        this.questionCount = parseInt(document.getElementById('question-count').value) || 10;
        
        try {
            // Show loading indicator
            document.getElementById('current-question').innerHTML = '<p>Loading questions...</p>';
            
            const allQuestions = await API.getQuestions(this.selectedCategories);
            console.log('Questions received:', allQuestions);

            if (!allQuestions || allQuestions.length === 0) {
                alert('No questions found for the selected categories.');
                return;
            }

            // Shuffle questions and take the requested number
            const shuffledQuestions = this.shuffleArray([...allQuestions]);
            const selectedQuestions = shuffledQuestions.slice(0, this.questionCount);
            
            this.quizManager.loadQuestions(selectedQuestions);
            
            // Display selected categories in header
            const categoriesHeader = this.selectedCategories.map(
                cat => `${cat.category} - ${cat.subcategory}`
            ).join(', ');
            
            document.getElementById('quiz-title').textContent = 'Multi-Category Quiz';
            document.getElementById('selected-categories').textContent = `Categories: ${categoriesHeader}`;
            
            document.querySelector('.category-selector').style.display = 'none';
            document.querySelector('.quiz-container').style.display = 'block';
            document.querySelector('.results-container').style.display = 'none';
            
            // Show first question
            this.quizManager.showQuestion(0);
        } catch (error) {
            console.error('Error loading questions:', error);
            alert('Error loading questions. Please try again.');
        }
    }

    shuffleArray(array) {
        for (let i = array.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
        return array;
    }

    async submitQuiz() {
        if (!this.selectedCategories || this.selectedCategories.length === 0) {
            alert('Please select at least one category before starting the quiz.');
            return;
        }
        
        const submission = this.quizManager.getSubmission(this.selectedCategories);
        
        if (!submission || !submission.quiz_data || !submission.quiz_data.answers) {
            alert('Error preparing quiz submission. Please try again.');
            return;
        }
        
        if (submission.quiz_data.answers.length === 0) {
            alert('Please answer at least one question before submitting.');
            return;
        }

        try {
            // Show loading state
            document.getElementById('submit-quiz').textContent = 'Submitting...';
            document.getElementById('submit-quiz').disabled = true;
            
            // Try to submit to API first - try different formats
            let result;
            try {
                // First try the format with quiz_data wrapper
                result = await API.submitQuiz(submission);
            } catch (firstError) {
                console.log('First format failed, trying direct answers format');
                // If that fails, try sending just the answers array directly
                result = await API.submitQuiz({
                    categories: this.selectedCategories,
                    answers: submission.quiz_data.answers
                });
            }
            
            // If API returns empty or invalid response, calculate locally
            if (!result || typeof result !== 'object') {
                console.log('API returned empty result, calculating locally');
                this.showLocalResults(submission.quiz_data.answers);
            } else {
                this.showResults(result);
            }
            
            await this.progressManager.loadProgress(); // Refresh progress
        } catch (error) {
            console.error('Error submitting quiz:', error);
            
            // If API fails, calculate results locally
            try {
                console.log('API submission failed, calculating results locally');
                this.showLocalResults(submission.quiz_data.answers);
            } catch (fallbackError) {
                console.error('Local calculation also failed:', fallbackError);
                
                if (error.response && error.response.status === 422) {
                    alert('Validation error: Please check your answers and try again.');
                } else {
                    alert('Error submitting quiz. Please try again.');
                }
            }
        } finally {
            // Reset button state
            document.getElementById('submit-quiz').textContent = 'Submit Quiz';
            document.getElementById('submit-quiz').disabled = false;
        }
    }

    showLocalResults(answers) {
        // Calculate results locally since API might not be working
        const container = document.getElementById('results-details');
        
        let correctAnswers = 0;
        answers.forEach(answer => {
            if (answer.selected_answer === answer.correct_answer) {
                correctAnswers++;
            }
        });
        
        const totalQuestions = answers.length;
        const percentage = totalQuestions > 0 ? (correctAnswers / totalQuestions * 100) : 0;
        
        const categoriesHeader = this.selectedCategories.map(
            cat => `${cat.category} - ${cat.subcategory}`
        ).join(', ');
        
        container.innerHTML = `
            <div class="result-summary">
                <h3>Quiz Results: ${categoriesHeader}</h3>
                <p>Correct Answers: ${correctAnswers}/${totalQuestions}</p>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: ${percentage}%"></div>
                </div>
                <p class="percentage-display">${percentage.toFixed(1)}%</p>
                <p class="local-notice">Results calculated locally</p>
            </div>
        `;

        document.querySelector('.category-selector').style.display = 'none';
        document.querySelector('.quiz-container').style.display = 'none';
        document.querySelector('.results-container').style.display = 'block';
    }

    showQuizHistory() {
            document.querySelector('.category-selector').style.display = 'none';
            document.querySelector('.quiz-container').style.display = 'none';
            document.querySelector('.results-container').style.display = 'none';
            document.querySelector('.quiz-history-container').style.display = 'block';
            
            resultsManager.loadQuizHistory();
        }

    showResults(result) {
        const container = document.getElementById('results-details');
        
        // Handle different response formats
        let correctAnswers, totalQuestions, percentage, categoryText;
        
        if (result && result.correct_answers !== undefined && result.total_questions !== undefined) {
            // Standard format
            correctAnswers = result.correct_answers;
            totalQuestions = result.total_questions;
            percentage = result.percentage || (correctAnswers / totalQuestions * 100);
            categoryText = result.category ? `: ${result.category}` : '';
        } else if (result && result.score !== undefined && result.total !== undefined) {
            // Alternative format
            correctAnswers = result.score;
            totalQuestions = result.total;
            percentage = (correctAnswers / totalQuestions * 100);
            categoryText = '';
        } else if (result && result.quiz_data) {
            // Our custom format
            correctAnswers = result.correct_answers || result.score || 0;
            totalQuestions = result.total_questions || result.total || result.quiz_data.total_questions || 0;
            percentage = result.percentage || (totalQuestions > 0 ? (correctAnswers / totalQuestions * 100) : 0);
            categoryText = result.category || '';
        } else {
            // No valid result data, calculate locally from submission
            this.showLocalResults(this.quizManager.getSubmission(this.selectedCategories));
            return;
        }
        
        container.innerHTML = `
            <div class="result-summary">
                <h3>Quiz Results${categoryText}</h3>
                <p>Correct Answers: ${correctAnswers}/${totalQuestions}</p>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: ${percentage}%"></div>
                </div>
                <p class="percentage-display">${percentage.toFixed(1)}%</p>
            </div>
        `;

        document.querySelector('.category-selector').style.display = 'none';
        document.querySelector('.quiz-container').style.display = 'none';
        document.querySelector('.results-container').style.display = 'block';
    }
    
    backToCategories() {
        this.selectedCategories = [];
        document.querySelectorAll('.subcategory-btn').forEach(btn => {
            btn.classList.remove('selected');
        });
        document.getElementById('start-quiz').disabled = true;
        
        document.querySelector('.category-selector').style.display = 'block';
        document.querySelector('.quiz-container').style.display = 'none';
        document.querySelector('.results-container').style.display = 'none';
        document.querySelector('.quiz-history-container').style.display = 'none'; // 🔥 FIX
    }

    attachEventListeners() {
        // Bind the context for all event handlers
        document.getElementById('start-quiz').addEventListener('click', () => {
            this.startQuiz();
        });

        document.getElementById('submit-quiz').addEventListener('click', () => {
            this.submitQuiz();
        });

        document.getElementById('prev-question').addEventListener('click', () => {
            this.quizManager.prevQuestion();
        });

        document.getElementById('next-question').addEventListener('click', () => {
            this.quizManager.nextQuestion();
        });

        document.getElementById('back-to-categories').addEventListener('click', () => {
            this.backToCategories();
        });
        document.getElementById('view-history').addEventListener('click', () => {
            this.showQuizHistory();
        });
        document.getElementById('back-to-categories-from-history').addEventListener('click', () => {
            this.backToCategories();
        });
        document.addEventListener('DOMContentLoaded', function() {
            const toggleBtn = document.getElementById('toggle-history-view');
            if (toggleBtn) {
                toggleBtn.addEventListener('click', () => {
                    resultsManager.toggleHistoryView();
                });
            }
        });
    }
}

// Initialize the app when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    new QuizletApp();
});