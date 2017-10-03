
before do
  @current_user = User.find_by(messenger_user_id: params['messenger user id'])
end

before '/:locale/*' do
  I18n.locale = params[:locale]
end

get '/:locale/start_game' do
  @current_user = User.create(messenger_user_id: params['messenger user id'], first_name: params['fb_first_name']) unless @current_user
  json @current_user.start_new_game
end

get '/:locale/set_answer' do
  return unless @current_user
  json @current_user.games.last.put_answer(params)
end

get '/:locale/next_question' do
  @current_user = User.create(messenger_user_id: params['messenger user id'], first_name: params['fb_first_name']) unless @current_user
  game = @current_user.games.find_by(id: params[:game_id])
  json game.next_question
end

get '/:locale/end_game' do
  json @current_user.games.last.results if @current_user
end

