require 'opal'
require 'opal-phaser'
require 'constants'
require 'background'
require 'ground'
require 'fluttershy'
require 'pp'

class Game
  def initialize
    preload
    create
    update
    
    Phaser::Game.new(width: Constants::GAME_WIDTH, height: Constants::GAME_HEIGHT, render: Phaser::CANVAS, parent: "game", state: state, transparent: false, antialias: true, physics: nil)
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
      
      @spacebar = game.input.keyboard.add_key(Phaser::Keyboard::SPACEBAR)
      @spacebar.on_down.add(jump)
      call_entities_state_method :create
      
      @left  = game.input.keyboard.add_key(Phaser::Keyboard::LEFT)
      @right = game.input.keyboard.add_key(Phaser::Keyboard::RIGHT)
      @a     = game.input.keyboard.add_key(Phaser::Keyboard::A)
      @d     = game.input.keyboard.add_key(Phaser::Keyboard::D)
      
    end
  end
  
  def update
    state.update do |game|
      game.physics.arcade.collide(@fluttershy.sprite, @ground.sprite)
      
      def move_right
        @fluttershy.sprite.body.velocity.x = Constants::RIGHT_VELOCITY
      end
      
      def move_left
        @fluttershy.sprite.body.velocity.x = Constants::LEFT_VELOCITY
      end
      
      def stop_moving
        @fluttershy.sprite.body.velocity.x = Constants::STOPPED
      end
      
      stop_moving
      
      if @right.down? || @d.down?
        move_right
      end
      
      if @left.down? || @a.down?
        move_left
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
    
    @game_entities = [@background, @ground, @fluttershy]
  end
  
  def call_entities_state_method(method)
    @game_entities.each do |entity|
      entity.send(method)
    end
  end
end