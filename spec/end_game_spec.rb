require File.expand_path '../spec_helper.rb', __FILE__

describe 'End game endpoint', type: :request do
  it 'should return game result' do
    create_questions
    start_game
    game = Game.last
    get "/#{game.locale}/set_answer", correct_answer_params(game, game.questions.last)
    get '/end_game', correct_answer_params(game, game.questions.last)
    expect(last_response.status).to be(200)
    expect(last_response.body).to include('Name That Wave 🏆')
  end
end
