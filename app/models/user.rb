class User < ActiveRecord::Base
  has_many :games

  def start_new_game
    games.create(locale: I18n.locale).start
  end
end
