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
    params['last_question'] = true if answers_passed_ids.size + 1 >= GAME_QUESTIONS_COUNT
    answer_text = check_answer(params)
    answer_text
  end

  def next_question
    allowed_questions = questions.where.not(id: answers_passed_ids)
    allowed_questions.first.generate_template(question_num)
  end

  def results
    define_game_locale
    resp = GamesResponseFormater.new(
        user_name: user.first_name,
        answers_correct: answers_correct,
        answers_passed_ids: answers_passed_ids
    )
    [
      resp.result_title_template,
      resp.result_gallery_template,
      resp.result_quick_reply_template(define_result)
    ]
  end

  private

  def define_result
    case answers_correct
      when 0..5
        I18n.t('game.result_subtitle.newbee')
      when 6..10
        I18n.t('game.result_subtitle.midle')
      when 11..20
        I18n.t('game.result_subtitle.geek')
    end
  end

  def question_num
    answers_passed_ids.count + 1
  end

  def check_answer(params)
    question = questions.find_by(id: params['question_id'])
    return { error: 'question not found' } unless question
    correct = question.answer.to_s == params['answer']
    update_results(question.id, correct)
    params = {
        locale:  locale,
        answer: generate_answer_text(correct,  question.answer.to_s),
        answer_description: question.answer_description,
        game_id: id,
        last_question: params['last_question']
    }
    QuestionsResponseFormater.new(params).generate_answer_template
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
