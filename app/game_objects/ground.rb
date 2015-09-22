class Ground < GameObject
  attr_accessor :sprite
  
  def initialize
    @sprite_key  = "ground"
    @sprite_path = "assets/sprites/game_world/ground.png"
  end
  
  def preload
    @@game.load.image(@sprite_key, @sprite_path)
  end
  
  def create
    @sprite = @@game.add.tile_sprite(GROUND_X_POS, GROUND_Y_POS, GROUND_WIDTH, GROUND_HEIGHT, @sprite_key)
    @@game.physics.arcade.enable(@sprite)
    @sprite.body.immovable = true
    
    @sprite.auto_scroll(GROUND_AUTOSCROLL_X_SPEED, GROUND_AUTOSCROLL_Y_SPEED)
  end
end