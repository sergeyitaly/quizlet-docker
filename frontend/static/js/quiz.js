class QuizManager {
    constructor() {
        this.currentQuestions = [];
        this.selectedAnswers = new Map();
        this.currentQuestionIndex = 0;
        this.startTime = null;
        this.endTime = null;
    }

    loadQuestions(questions) {
        this.currentQuestions = questions;
        this.selectedAnswers.clear();
        this.currentQuestionIndex = 0;
        this.startTime = new Date();
        this.endTime = null;
    }

    showQuestion(index) {
        if (index < 0 || index >= this.currentQuestions.length) return;
        
        this.currentQuestionIndex = index;
        const question = this.currentQuestions[index];
        
        const container = document.getElementById('current-question');
        container.innerHTML = `
            <div class="question">
                <h3>Question ${index + 1}</h3>
                <p>${question.question_text}</p>
                <div class="options">
                    ${this.renderOptions(question, index)}
                </div>
            </div>
        `;
        
        // Update question counter
        document.getElementById('question-counter').textContent = 
            `Question ${index + 1} of ${this.currentQuestions.length}`;
        
        // Update navigation buttons
        document.getElementById('prev-question').disabled = index === 0;
        document.getElementById('next-question').disabled = index === this.currentQuestions.length - 1;
        
        // Select previously chosen answer if exists
        const selectedAnswer = this.selectedAnswers.get(index);
        if (selectedAnswer) {
            document.querySelectorAll(`.option[data-question="${index}"]`).forEach(opt => {
                if (opt.dataset.option === selectedAnswer) {
                    opt.classList.add('selected');
                    opt.querySelector('input').checked = true;
                }
            });
        }
        
        this.attachOptionListeners();
    }

    renderOptions(question, questionIndex) {
        const letters = ['A', 'B', 'C', 'D'];
        
        // Check if question has options array, if not create it from individual fields
        let options = [];
        
        if (question.options && Array.isArray(question.options)) {
            // Use existing options array
            options = question.options;
        } else {
            // Create options from individual option fields
            options = [
                question.option_a,
                question.option_b, 
                question.option_c,
                question.option_d
            ].filter(opt => opt !== undefined && opt !== null && opt !== '');
        }
        
        // If no options found, show error message
        if (options.length === 0) {
            return '<p class="error">No options available for this question</p>';
        }
        
        return options.map((text, i) => `
            <label class="option" data-question="${questionIndex}" data-option="${letters[i]}">
                <input type="radio" name="question-${questionIndex}" value="${letters[i]}">
                ${letters[i]}. ${text}
            </label>
        `).join('');
    }

    attachOptionListeners() {
        document.querySelectorAll('.option').forEach(option => {
            option.addEventListener('click', (e) => {
                const questionIndex = parseInt(option.dataset.question);
                const selectedOption = option.dataset.option;
                
                this.selectedAnswers.set(questionIndex, selectedOption);
                
                // Update UI
                document.querySelectorAll(`.option[data-question="${questionIndex}"]`).forEach(opt => {
                    opt.classList.remove('selected');
                });
                option.classList.add('selected');
            });
        });
    }

    nextQuestion() {
        this.showQuestion(this.currentQuestionIndex + 1);
    }

    prevQuestion() {
        this.showQuestion(this.currentQuestionIndex - 1);
    }

    getSubmission(categories) {
        this.endTime = new Date();
        const durationSeconds = Math.floor((this.endTime - this.startTime) / 1000);

        const answers = [];
        this.currentQuestions.forEach((question, index) => {
            const selected = this.selectedAnswers.get(index);
            if (selected) {
                answers.push({
                    question_id: question.id,
                    selected_answer: selected,
                    question_text: question.question_text,
                    correct_answer: question.correct_answer
                });
            }
        });

        return {
            quiz_data: {
                categories: categories,
                total_questions: this.currentQuestions.length,
                answers: answers,
                timestamp: this.endTime.toISOString(),
                duration_seconds: durationSeconds
            }
        };
    }
}