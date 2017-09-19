class Question < ActiveRecord::Base
  has_and_belongs_to_many :games

  def generate_template(game_id)
    QuestionsResponseFormater.new(prepared_params(game_id)).generate_question_template
  end

  private

  def prepared_params(game_id)
    {
      title: title,
      img_url: img_url,
      q_id: q_id,
      locale: locale,
      game_id: game_id
    }
  end
end

