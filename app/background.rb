require_relative 'constants'

class Background
  def initialize(game)
    @sprite_key = "background"
    @sprite_url = "assets/sprites/game_world/background.png"
    @game       = game
  end
  
  def preload
    @game.load.image(@sprite_key, @sprite_url)
  end
  
  def create
    @background = @game.add.sprite(Constants::BACKGROUND_X_POS, Constants::BACKGROUND_Y_POS, @sprite_key)
    @background.scale.set(Constants::BACKGROUND_SCALE_FACTOR)
  end
end