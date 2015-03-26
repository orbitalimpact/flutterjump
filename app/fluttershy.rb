require './constants'

class Fluttershy
  attr_reader :sprite
  
  def initialize(game)
    @sprite_key   = "fluttershy"
    
    @walking_key  = "walk"
    @walking_img  = "assets/sprites/fluttershy/fluttershy_walking.png"
    @walking_json = "assets/sprites/fluttershy/fluttershy_walking.json"
    
    @flying_key   = "fly"
    @flying_img   = "assets/sprites/fluttershy/fluttershy_flying.png"
    @flying_json  = "assets/sprites/fluttershy/fluttershy_flying.json"
    
    @ouch_key     = "ouch"
    @ouch_img     = "assets/sprites/fluttershy/fluttershy_ouch.png"
    @ouch_json    = "assets/sprites/fluttershy/fluttershy_ouch.json"
    
    @game         = game
  end
  
  def preload
    @game.load.atlas(@walking_key, @walking_img, @walking_json)
    @game.load.atlas(@flying_key, @flying_img, @flying_json)
    @game.load.image(@ouch_key, @ouch_img)
  end
  
  def create
    @sprite = @game.add.sprite(Constants::FLUTTERSHY_X_POS, Constants::FLUTTERSHY_Y_POS, @walking_key)
    @game.physics.arcade.enable(@sprite)
    @sprite.body.collide_world_bounds = true
    @sprite.body.gravity.y = Constants::GRAVITY
    
    @sprite.animations.add(@walking_key, Constants::WALKING_FRAMES, Constants::FRAME_RATE, Constants::LOOP)
    @sprite.animations.play(@walking_key)
  end
  
  def update
    # nothing in here for this class
  end
end