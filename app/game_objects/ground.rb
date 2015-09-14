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
    @sprite = @@game.add.tile_sprite(Constants::GROUND_X_POS, Constants::GROUND_Y_POS, Constants::GROUND_WIDTH, Constants::GROUND_HEIGHT, @sprite_key)
    @@game.physics.arcade.enable(@sprite)
    @sprite.body.immovable = true
    
    @sprite.auto_scroll(Constants::GROUND_AUTOSCROLL_X_SPEED, Constants::GROUND_AUTOSCROLL_Y_SPEED)
  end
end