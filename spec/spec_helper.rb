ENV['RACK_ENV'] = 'test'

require './app.rb'
require 'rspec'
require 'rack/test'

include Rack::Test::Methods
def app() Sinatra::Application end

RSpec.configure do |config|
  require 'database_cleaner'

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner[:active_record, { connection: :test_my_second_connection }].strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
    DatabaseCleaner[:active_record, { connection: :test_my_second_connection }].start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    DatabaseCleaner[:active_record, { connection: :test_my_second_connection }].clean
  end
end

def start_game
  get '/start_game', valid_user_params
  expect(last_response.status).to be(200)
end

def create_questions
  30.times { Answer.create(body: "Answer N #{rand(1..10_000)} ") }
  answers_ids = Answer.all.pluck(:id)
  100.times do
    q = Question.create
    q.answer = Answer.find_by(id: answers_ids.sample)
    q.save
  end
end

def valid_user_params
  { messenger_user_id: 'Test_id', fb_first_name: 'Test name' }
end

def correct_answer_params(game, question)
  { messenger_user_id: game.user.messenger_user_id, fb_first_name: game.user.first_name, question_id: question.id, answer_id: question.answer.id }
end

def wrong_answer_params(game)
  { messenger_user_id: game.user.messenger_user_id, fb_first_name: game.user.first_name, question_id: game.questions.last.id, answer_id: 1 }
end
