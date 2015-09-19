class Fluttershy < GameObject
  attr_reader :sprite
  attr_reader :walking_key
  attr_reader :flying_key
  attr_reader :ouch_key
  attr_reader :jump_sound
  
  def initialize
    @sprite_key      = "fluttershy"
    
    @walking_key     = "walk"
    @walking_img     = "assets/sprites/fluttershy/fluttershy_walking.png"
    @walking_json    = "assets/sprites/fluttershy/fluttershy_walking.json"
    
    @flying_key      = "fly"
    @flying_img      = "assets/sprites/fluttershy/fluttershy_flying.png"
    @flying_json     = "assets/sprites/fluttershy/fluttershy_flying.json"
    
    @ouch_key        = "ouch"
    @ouch_img        = "assets/sprites/fluttershy/fluttershy_ouch.png"
    @ouch_json       = "assets/sprites/fluttershy/fluttershy_ouch.json"
    
    @jump_sound_key  = "jump"
    @jump_sound_path = ["assets/audio/jump.ogg", "assets/audio/jump.m4a"]
  end
  
  def preload
    @@game.load.atlas(@walking_key,    @walking_img, @walking_json)
    @@game.load.atlas(@flying_key,     @flying_img, @flying_json)
    @@game.load.image(@ouch_key,       @ouch_img)
    @@game.load.audio(@jump_sound_key, @jump_sound_path)
  end
  
  def create
    @sprite = @@game.add.sprite(Constants::FLUTTERSHY_START_X_POS, Constants::FLUTTERSHY_START_Y_POS, @walking_key)
    @@game.physics.arcade.enable(@sprite)
    @sprite.body.collide_world_bounds = true
    @sprite.body.gravity.y            = Constants::GRAVITY
    
    @sprite.animations.add(@walking_key, Constants::WALKING_FRAMES, Constants::FRAME_RATE, Constants::LOOP)
    @sprite.animations.add(@flying_key, Constants::FLYING_FRAMES, Constants::FRAME_RATE, Constants::LOOP)
    @sprite.animations.play(@walking_key)
    
    @jump_sound = @@game.add.audio(@jump_sound_key)
  end
  
  def play_jump_sound
    @jump_sound.play
  end
  
  def move_right
    @sprite.body.velocity.x = Constants::RIGHT_VELOCITY
  end
  
  def move_left
    @sprite.body.velocity.x = Constants::LEFT_VELOCITY
  end
  
  def stop_walking
    @sprite.body.velocity.x = Constants::STOPPED
  end
end