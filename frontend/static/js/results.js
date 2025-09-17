// results.js
class ResultsManager {
    constructor() {
        this.quizHistory = [];
        this.isBackendAvailable = true;
        this.hasAttemptedLoad = false;
        this.isLoading = false;
        this.showDetails = true;
    }

    async loadQuizHistory() {
        if (this.isLoading) return;
        if (this.hasAttemptedLoad) {
            this.renderQuizHistory();
            return;
        }

        this.isLoading = true;
        this.hasAttemptedLoad = true;
        
        // Show loading state
        this.showLoadingMessage();
        
        try {
            if (!this.isBackendAvailable) {
                throw new Error('Backend previously unavailable');
            }

            console.log('Attempting to load quiz history from API...');
            this.quizHistory = await API.getQuizHistory();
            console.log('Quiz history loaded from API:', this.quizHistory);
            this.renderQuizHistory();
            this.renderProgressCards();
            
        } catch (error) {
            console.error('Error loading quiz history from API:', error);
            this.isBackendAvailable = false;
            
            setTimeout(() => {
                this.loadFromLocalStorage();
            }, 500);
        } finally {
            this.isLoading = false;
        }
    }

    loadFromLocalStorage() {
        try {
            const savedHistory = localStorage.getItem('quizHistory');
            if (savedHistory) {
                this.quizHistory = JSON.parse(savedHistory);
                console.log('Quiz history loaded from local storage:', this.quizHistory);
                
                if (this.quizHistory.length > 0) {
                    this.renderQuizHistory();
                    this.showInfoMessage('Displaying quiz history from local storage');
                } else {
                    this.renderNoHistoryMessage();
                }
            } else {
                console.log('No quiz history found in local storage');
                this.renderNoHistoryMessage();
            }
        } catch (e) {
            console.error('Error loading from local storage:', e);
            this.renderNoHistoryMessage();
        }
    }

    saveToLocalStorage(quizResult) {
        try {
            const existingHistory = JSON.parse(localStorage.getItem('quizHistory') || '[]');

            const resultToSave = {
                id: quizResult.id || Date.now(),
                timestamp: quizResult.timestamp || new Date().toISOString(),
                categories: quizResult.categories || [],
                correct_answers: quizResult.correct_answers || quizResult.score || 0,
                total_questions: quizResult.total_questions || 0,
                percentage: quizResult.percentage || ((quizResult.correct_answers || quizResult.score || 0) /
                            (quizResult.total_questions || 1) * 100),
                duration_seconds: quizResult.duration_seconds || 0
            };

            existingHistory.unshift(resultToSave);
            const limitedHistory = existingHistory.slice(0, 20);
            localStorage.setItem('quizHistory', JSON.stringify(limitedHistory));

            this.quizHistory = limitedHistory;
            this.renderQuizHistory();
            this.renderProgressCards();

        } catch (e) {
            console.error('Error saving to local storage:', e);
        }
    }


    renderQuizHistory() {
        const container = document.getElementById('quiz-history');
        if (!container) {
            console.error('Quiz history container not found');
            return;
        }

        if (!this.quizHistory || this.quizHistory.length === 0) {
            this.renderNoHistoryMessage();
            return;
        }

        // Group quizzes by category combinations
        const groupedQuizzes = this.groupQuizzesByCategories(this.quizHistory);
        
        container.innerHTML = `
            <h3>Quiz History by Category</h3>
            ${!this.isBackendAvailable ? '<div class="offline-notice">⚠️ Showing local data</div>' : ''}
            <div class="history-groups">
                ${Object.entries(groupedQuizzes).map(([categoryKey, quizzes]) => 
                    this.renderCategoryGroup(categoryKey, quizzes)
                ).join('')}
            </div>
        `;
        
        // Attach event listeners for expand/collapse
        this.attachGroupEventListeners();
    }

    groupQuizzesByCategories(quizzes) {
        const groups = {};
        
        quizzes.forEach(quiz => {
            const categoryKey = quiz.categories.map(cat => 
                `${cat.category}:${cat.subcategory}`
            ).sort().join('|');
            
            if (!groups[categoryKey]) {
                groups[categoryKey] = [];
            }
            groups[categoryKey].push(quiz);
        });
        
        return groups;
    }

    renderCategoryGroup(categoryKey, quizzes) {
        const categories = categoryKey.split('|').map(cat => {
            const [category, subcategory] = cat.split(':');
            return `${category} - ${subcategory}`;
        }).join(', ');
        
        const totalQuizzes = quizzes.length;
        const avgScore = quizzes.reduce((sum, quiz) => sum + quiz.percentage, 0) / totalQuizzes;
        const totalQuestions = quizzes.reduce((sum, quiz) => sum + quiz.total_questions, 0);
        
        return `
            <div class="category-group">
                <div class="category-header" data-category-key="${categoryKey}">
                    <h3>${categories}</h3>
                    <div class="category-stats">
                        <span>${totalQuizzes} quiz${totalQuizzes !== 1 ? 'zes' : ''}</span>
                        <span>Avg: ${avgScore.toFixed(1)}%</span>
                        <span>${totalQuestions} questions</span>
                    </div>
                </div>
                <div class="category-content" id="content-${categoryKey}">
                    <div class="category-quizzes">
                        ${quizzes.map(quiz => this.renderCompactQuizItem(quiz)).join('')}
                    </div>
                </div>
            </div>
        `;
    }

    renderCompactQuizItem(quiz) {
        const date = new Date(quiz.timestamp).toLocaleDateString();
        const score = quiz.correct_answers || quiz.score || 0;
        const total = quiz.total_questions || 1;
        const percentage = quiz.percentage || ((score / total) * 100);

        return `
            <div class="quiz-item compact">
                <div class="quiz-date">${date}</div>
                <div class="quiz-score">${score}/${total}</div>
                <div class="quiz-percentage">${percentage.toFixed(1)}%</div>
                <div class="quiz-duration">${this.formatDuration(quiz)}</div>
            </div>
        `;
    }

    formatDuration(quiz) {
        const seconds = quiz.duration_seconds || 0;
        if (seconds < 60) return `${seconds}s`;
        const mins = Math.floor(seconds / 60);
        const secs = seconds % 60;
        return secs > 0 ? `${mins}m ${secs}s` : `${mins}m`;
    }

    renderProgressCards() {
        if (this.quizHistory.length === 0) return;

        const totalQuizzes = this.quizHistory.length;
        const avgScore = this.quizHistory.reduce((sum, quiz) => sum + quiz.percentage, 0) / totalQuizzes;
        const totalQuestions = this.quizHistory.reduce((sum, quiz) => sum + quiz.total_questions, 0);

        // Update overall progress
        document.getElementById('total-quizzes').textContent = totalQuizzes;
        document.getElementById('avg-score').textContent = `${avgScore.toFixed(1)}%`;
        document.getElementById('total-questions').textContent = totalQuestions;

        // Render category breakdown
        this.renderCategoryBreakdown();
    }

    renderCategoryBreakdown() {
        const container = document.getElementById('category-stats');
        if (!container) return;

        const categoryStats = this.calculateCategoryStats();
        
        container.innerHTML = Object.entries(categoryStats)
            .sort(([,a], [,b]) => b.percentage - a.percentage)
            .map(([category, stats]) => `
                <div class="category-stat-item">
                    <div class="category-stat-header">
                        <span class="category-name">${category}</span>
                        <span class="category-percentage">${stats.percentage.toFixed(1)}%</span>
                    </div>
                    <div class="category-progress-bar">
                        <div class="category-progress-fill" style="width: ${stats.percentage}%"></div>
                    </div>
                    <div class="category-details">
                        ${stats.quizzes} quiz${stats.quizzes !== 1 ? 'zes' : ''}, 
                        ${stats.correct}/${stats.total} correct
                    </div>
                </div>
            `).join('');
    }

    calculateCategoryStats() {
        const stats = {};
        
        this.quizHistory.forEach(quiz => {
            quiz.categories.forEach(cat => {
                const categoryKey = `${cat.category} - ${cat.subcategory}`;
                
                if (!stats[categoryKey]) {
                    stats[categoryKey] = {
                        quizzes: 0,
                        correct: 0,
                        total: 0,
                        percentage: 0
                    };
                }
                
                stats[categoryKey].quizzes++;
                stats[categoryKey].correct += quiz.correct_answers || 0;
                stats[categoryKey].total += quiz.total_questions || 0;
                stats[categoryKey].percentage = (stats[categoryKey].correct / stats[categoryKey].total) * 100;
            });
        });
        
        return stats;
    }

    attachGroupEventListeners() {
        document.querySelectorAll('.category-header').forEach(header => {
            header.addEventListener('click', () => {
                const categoryKey = header.dataset.categoryKey;
                const content = document.getElementById(`content-${categoryKey}`);
                
                header.classList.toggle('expanded');
                content.classList.toggle('expanded');
            });
        });
    }

    toggleHistoryView() {
        this.showDetails = !this.showDetails;
        
        const toggleBtn = document.getElementById('toggle-history-view');
        const historyContent = document.querySelector('.history-content');
        
        if (this.showDetails) {
            toggleBtn.textContent = 'Hide Details';
            historyContent.style.display = 'block';
        } else {
            toggleBtn.textContent = 'Show Details';
            historyContent.style.display = 'none';
        }
    }

    showLoadingMessage() {
        const container = document.getElementById('quiz-history');
        if (!container) return;

        container.innerHTML = `
            <div class="loading-message">
                <h3>Quiz History</h3>
                <p>Loading your quiz history...</p>
                <div class="loading-spinner"></div>
            </div>
        `;
    }

    showInfoMessage(message) {
        const container = document.getElementById('quiz-history');
        if (!container) return;

        let messageDiv = document.getElementById('history-info-message');
        if (!messageDiv) {
            messageDiv = document.createElement('div');
            messageDiv.id = 'history-info-message';
            messageDiv.style.cssText = 'background-color: #e3f2fd; color: #1565c0; padding: 10px; margin: 10px 0; border-radius: 4px;';
            container.prepend(messageDiv);
        }
        messageDiv.textContent = message;
        
        setTimeout(() => {
            if (messageDiv) messageDiv.style.display = 'none';
        }, 5000);
    }

    renderNoHistoryMessage() {
        const container = document.getElementById('quiz-history');
        if (!container) return;

        container.innerHTML = `
            <div class="no-history">
                <h3>Quiz History</h3>
                <p>No quiz history available yet.</p>
                <p>Complete some quizzes to see your results here!</p>
                ${!this.isBackendAvailable ? '<p class="offline-note">⚠️ Currently showing local data only</p>' : ''}
            </div>
        `;
    }
}

// Global instance
const resultsManager = new ResultsManager();
