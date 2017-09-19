class CreateGameQuestions < ActiveRecord::Migration
  create_table :games_questions do |t|
    t.integer :question_id
    t.integer :game_id
  end
end
