# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170914153955) do

  create_table "games", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "locale"
    t.string   "answers_passed_ids", default: "--- []\n", null: false
    t.integer  "answers_correct",    default: 0,          null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "games_questions", force: :cascade do |t|
    t.integer "question_id"
    t.integer "game_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "q_id"
    t.string   "locale"
    t.string   "title"
    t.string   "img_url"
    t.string   "answer_description"
    t.boolean  "answer"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "messenger_user_id"
    t.string   "first_name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
