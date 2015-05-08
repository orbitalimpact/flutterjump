require_relative 'constants'

class Background
  attr_reader :sprite
  
  def initialize(game)
    @sprite_key = "background"
    @sprite_path = "assets/sprites/game_world/background.png"
    @game       = game
  end
  
  def preload
    @game.load.image(@sprite_key, @sprite_path)
  end
  
  def create
    @sprite = @game.add.sprite(Constants::BACKGROUND_X_POS, Constants::BACKGROUND_Y_POS, @sprite_key)
    @sprite.scale.set(Constants::BACKGROUND_SCALE_FACTOR)
  end
end