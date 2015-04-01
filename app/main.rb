require 'opal'
require 'opal-phaser'
require 'constants'
require 'background'
require 'ground'
require 'fluttershy'
require 'keys'
require 'pp'

class Game
  def initialize
    preload
    create
    update
    
    Phaser::Game.new(width: Constants::GAME_WIDTH, height: Constants::GAME_HEIGHT, renderer: Phaser::CANVAS, parent: "game", state: state, transparent: false, antialias: true, physics: nil)
  end
  
  def state
    @state ||= Phaser::State.new
  end
  
  def preload
    state.preload do |game|
      initialize_entities(game)
      call_entities_state_method :preload
    end
  end
  
  def create
    state.create do |game|
      jump = proc do
        @jumping = true
        @fluttershy.sprite.body.velocity.y = Constants::JUMP_VELOCITY
    
        @fluttershy.sprite.load_texture(@fluttershy.flying_key)
        @fluttershy.sprite.animations.add(@fluttershy.flying_key, Constants::FLYING_FRAMES, Constants::FRAME_RATE, Constants::LOOP)
        @fluttershy.sprite.body.set_size(Constants::FLYING_WIDTH, Constants::FLYING_HEIGHT)
        @fluttershy.sprite.animations.play(@fluttershy.flying_key)
      end
      
      call_entities_state_method :create
      
      @keys.spacebar.on_down.add(jump)
    end
  end
  
  def update
    state.update do |game|
      game.physics.arcade.collide(@fluttershy.sprite, @ground.sprite)
      
      @fluttershy.stop_moving
      
      if @keys.right.down? || @keys.d.down?
        @fluttershy.move_right
      end
      
      if @keys.left.down? || @keys.a.down?
        @fluttershy.move_left
      end
      
      if @jumping && @fluttershy.sprite.body.touching.down
        @jumping = false
        @fluttershy.sprite.load_texture(@fluttershy.walking_key)
        @fluttershy.sprite.body.set_size(Constants::WALKING_WIDTH, Constants::WALKING_HEIGHT)
        @fluttershy.sprite.animations.add(@fluttershy.walking_key, Constants::WALKING_FRAMES, Constants::FRAME_RATE, Constants::LOOP)
        @fluttershy.sprite.animations.play(@fluttershy.walking_key)
      end
      
      call_entities_state_method :update
    end
  end
  
  def initialize_entities(game)
    @background = Background.new(game)
    @ground     = Ground.new(game)
    @fluttershy = Fluttershy.new(game)
    @keys       = Keys.new(game)
    
    @game_entities = [@background, @ground, @fluttershy, @keys]
  end
  
  def call_entities_state_method(method)
    @game_entities.each do |entity|
      entity.send(method)
    end
  end
end