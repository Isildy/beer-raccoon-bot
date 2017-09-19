class Game < ActiveRecord::Base

  serialize :answers_passed_ids

  belongs_to :user
  has_and_belongs_to_many :questions

  scope :last_twenty_four_hours, lambda {
    where(created_at: Time.current - 24.hours...Time.current)
  }

  def start
    generate_questions_set
    save
    questions.first.generate_template(id)
  end

  def put_answer(params)
    last_question = true if answers_passed_ids.size == GAME_QUESTIONS_COUNT
    answer_text = check_answer(params, last_question)
    answer_text
  end

  def next_question
    allowed_questions = questions.where.not(id: answers_passed_ids)
    allowed_questions.first.generate_template(question_num)
  end

  def results
    define_game_locale
    [
      result_title_template,
      result_gallery_template,
      result_quick_reply_template
    ]
  end

  private

  def question_num
    answers_passed_ids.count + 1
  end

  def check_answer(params, last_q=false)
    question = questions.find_by(id: params['question_id'])
    return { error: 'question not found' } unless question
    correct = question.answer.to_s == params['answer']
    update_results(question.id, correct)
    params = {
        locale:  locale,
        answer:generate_answer_text(correct,  question.answer.to_s),
        answer_description: question.answer_description,
        game_id: id,
    }
    QuestionsResponseFormater.new(params).generate_answer_template(last_q)
  end

  def generate_questions_set
    self.questions = Question.where(locale: locale)
  end

  def update_results(question_id, correct)
    return if answers_passed_ids.include? question_id
    answers_passed_ids << question_id
    self.answers_correct += 1 if correct
    save
  end

  def generate_answer_text(correct, right_answer)
    text = I18n.t("answer.#{right_answer}_ans")
    return I18n.t("answer.correct_#{correct}", answer: text)
  end

  def define_game_locale
    I18n.locale = locale if locale
  end
end