class CreateUsers < ActiveRecord::Migration
  create_table :users do |t|
    t.string :messenger_user_id
    t.string :first_name
    t.timestamps null: false
  end
end
