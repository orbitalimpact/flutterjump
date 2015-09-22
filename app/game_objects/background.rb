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
    @sprite = @@game.add.tile_sprite(BACKGROUND_X_POS, BACKGROUND_Y_POS, BACKGROUND_WIDTH, BACKGROUND_HEIGHT, @sprite_key)
    @sprite.auto_scroll(BACKGROUND_AUTOSCROLL_X_SPEED, BACKGROUND_AUTOSCROLL_Y_SPEED)
  end
end