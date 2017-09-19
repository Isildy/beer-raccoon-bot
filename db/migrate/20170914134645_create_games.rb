class CreateGames < ActiveRecord::Migration
  create_table :games do |t|
    t.integer :user_id
    t.string :locale
    t.string :answers_passed_ids, default: [], null: false
    t.integer :answers_correct,   default: 0,  null: false
    t.timestamps null: false
  end
end
