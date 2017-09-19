class CreateQuestions < ActiveRecord::Migration
  create_table :questions do |t|
    t.integer :q_id
    t.string :locale
    t.string :title
    t.string :img_url
    t.string :answer_description
    t.boolean :answer
    t.timestamps null: false
  end
end


