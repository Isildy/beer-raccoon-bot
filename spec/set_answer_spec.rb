require File.expand_path '../spec_helper.rb', __FILE__

describe 'Set answer endpoint', type: :request do

  it 'should add id passed question to game answers_passed_ids and return next question' do
    start_game
    game = Game.last
    get "/#{game.locale}/set_answer", correct_answer_params(game, game.questions.last)
    game.reload
    expect(game.answers_passed_ids.first).to eq(game.questions.last.id)
    expect(last_response.body).to include('set_answer?')
  end

  it 'should successful set correct answer end update game correct answer counter' do
    start_game
    game = Game.last
    get "/#{game.locale}/set_answer", correct_answer_params(game, game.questions.last)
    game.reload
    expect(game.answers_correct).to eq(1)
  end

  it 'should_not update game correct answer counter' do
    start_game
    game = Game.last
    get "/#{game.locale}/set_answer", wrong_answer_params(game)
    game.reload
    expect(game.answers_correct).to eq(0)
  end

  it 'should return results' do
    start_game
    game = Game.last
    game.questions.each do |question|
      get "/#{game.locale}/set_answer", correct_answer_params(game, question)
      expect(last_response.status).to be(200)
    end
    expect(last_response.body).to include('Name That Wave 🏆')
  end
end
