require File.expand_path '../spec_helper.rb', __FILE__

describe 'Start game endpoint', type: :request do
  it 'should successful create user to start game' do
    create_questions
    start_game
    user = User.find_by(messenger_user_id: valid_user_params[:messenger_user_id])
    game = user.games.last
    expect(user.messenger_user_id).to eq(valid_user_params[:messenger_user_id])
    expect(user.games.count).to eq(1)
    expect(game.questions.count).to eq(10)
  end

  it 'should return params required error' do
    get '/start_game'
    expect(last_response.status).to be(400)
    expect(last_response.body).to eq('Parameter is required')
  end

  it 'should successful create eight games for user, end on nine game creating should delete all past games' do
    8.times do
      start_game
    end
    user = User.find_by(messenger_user_id: valid_user_params[:messenger_user_id])
    expect(user.games.count).to eq(8)
    start_game
    expect(user.games.count).to eq(1)
  end

  it 'should generate only uniq question for user games' do
    create_questions
    8.times do
      start_game
      User.last.games.last.update(answers_passed_ids: User.last.games.last.question_ids)
    end
    question_passed_array = []
    User.last.games.each do |game|
      question_passed_array += game.question_ids
    end
    expect(question_passed_array.uniq.length).to eq(80)
  end

  it 'should successful create game with right localiztion' do
    create_questions
    get '/en/start_game', valid_user_params
    expect(last_response.status).to be(200)
    user = User.find_by(messenger_user_id: valid_user_params[:messenger_user_id])
    expect(user.games.last.locale).to eq('en')
    get '/pt/start_game', valid_user_params
    user.reload
    expect(user.games.last.locale).to eq('pt')
  end
end
