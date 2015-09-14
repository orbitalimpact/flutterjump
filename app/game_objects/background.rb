class Background < GameObject
  attr_reader :sprite
  
  def initialize
    @sprite_key  = "background"
    @sprite_path = "assets/sprites/game_world/background.png"
  end
  
  def preload
    @@game.load.image(@sprite_key, @sprite_path)
  end
  
  def create
    @sprite = @@game.add.tile_sprite(Constants::BACKGROUND_X_POS, Constants::BACKGROUND_Y_POS, Constants::BACKGROUND_WIDTH, Constants::BACKGROUND_HEIGHT, @sprite_key)
    @sprite.auto_scroll(Constants::BACKGROUND_AUTOSCROLL_X_SPEED, Constants::BACKGROUND_AUTOSCROLL_Y_SPEED)
  end
end