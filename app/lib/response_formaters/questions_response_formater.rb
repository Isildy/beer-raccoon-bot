class QuestionsResponseFormater < MainResponseFormater

  attr_accessor :title, :img_url, :q_id, :locale, :game_id, :answer, :answer_description, :locale, :last_question

  def initialize(params = {})
    params.each do |name, value|
      send("#{name}=", value)
    end
  end

  def generate_question_template
    [
      text_template(QESTIONS_NUMBERS_EMOJIES[q_id]),
      image_template(img_url),
      text_with_quick_reply_template(title, answers_template)
    ]
  end

  def answers_template
    [
      button_template(generate_answer_url('true'),  I18n.t('answer.true_ans')),
      button_template(generate_answer_url('false'),  I18n.t('answer.false_ans')),
    ]
  end


  def generate_answer_template
    [
     text_template(answer),
     text_with_quick_reply_template(answer_description, define_next_button )
    ]
  end

  private

  def define_next_button
    return [button_template(generate_next_question_url,  I18n.t('answer.next'))] unless last_question
    [button_template(generate_show_result_url,  I18n.t('game.result_button'))]
  end

  def generate_next_question_url
    "#{ENV['MAIN_HOST']}/#{locale}/next_question?game_id=#{game_id}"
  end

  def generate_answer_url(type)
    "#{ENV['MAIN_HOST']}/#{locale}/set_answer?game_id=#{game_id}&question_id=#{q_id}&answer=#{type}"
  end

  def generate_show_result_url
    "#{ENV['MAIN_HOST']}/#{locale}/end_game?game_id=#{game_id}"
  end

end