require './constants'

class Ground
  def initialize(game)
    @sprite_key = "ground"
    @sprite_url = "assets/sprites/game_world/ground.png"
    @game       = game
  end
  
  def preload
    @game.load.image(@sprite_key, @sprite_url)
  end
  
  def create
    @game.add.tile_sprite(Constants::GROUND_X_POS, Constants::GROUND_Y_POS, Constants::GROUND_WIDTH, Constants::GROUND_HEIGHT, @sprite_key)
  end
  
  def update
    # nothing in here for this class
  end
end