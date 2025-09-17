class ProgressManager {
    constructor() {
        this.progressData = null;
    }

    async loadProgress() {
        try {
            this.progressData = await API.getProgress();
            this.renderProgress();
        } catch (error) {
            console.error('Error loading progress:', error);
        }
    }

    renderProgress() {
        const container = document.getElementById('progress-display');
        if (!this.progressData) {
            container.innerHTML = '<p>No progress data available</p>';
            return;
        }

        const { overall_progress, category_progress } = this.progressData;
        
        container.innerHTML = `
            <div class="overall-progress">
                <h3>Overall Progress</h3>
                <p>Total Quizzes: ${overall_progress.total_quizzes}</p>
                <p>Correct Answers: ${overall_progress.total_correct}/${overall_progress.total_questions}</p>
            </div>
        `;
    }

    renderCategoryProgress(categories) {
        return Object.values(categories).map(cat => `
            <div class="progress-item">
                <h4>${cat.category} - ${cat.subcategory}</h4>
                <p>Correct: ${cat.total_correct}/${cat.total_questions}</p>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: ${cat.percentage}%"></div>
                </div>
                <p class="percentage-display">${cat.percentage.toFixed(1)}%</p>
            </div>
        `).join('');
    }
}