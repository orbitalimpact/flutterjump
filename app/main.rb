require 'opal'
require 'opal-phaser'
require 'constants'
require 'background'
require 'score'
require 'obstacles'
require 'ground'
require 'fluttershy'
require 'keys'
require 'pp'

class Game
  def initialize
    preload
    create
    update
    
    Phaser::Game.new(width: Constants::GAME_WIDTH, height: Constants::GAME_HEIGHT, renderer: Phaser::CANVAS, parent: "game", state: state)
  end
  
  def initialize_entities(game)
    @background = Background.new(game)
    @score      = Score.new(game)
    @obstacles  = Obstacles.new(game)
    @ground     = Ground.new(game)
    @fluttershy = Fluttershy.new(game)
    @keys       = Keys.new(game)
    
    @game_entities = [@background, @score, @obstacles, @ground, @fluttershy, @keys]
  end
  
  def call_entities_state_method(method)
    @game_entities.each do |entity|
      entity.send(method)
    end
  end
  
  def state
    @state ||= Phaser::State.new
  end
  
  def preload
    state.preload do |game|
      @game_over = false
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
        @fluttershy.sprite.body.set_size(Constants::FLYING_WIDTH, Constants::FLYING_HEIGHT)
        @fluttershy.sprite.animations.play(@fluttershy.flying_key)
      end
      
      call_entities_state_method :create
      
      @keys.spacebar.on_down.add(jump)
    end
  end
  
  def update
    state.update do |game|
      game_over = proc do
        @game_over = true
        @obstacles.obstacle_generator.timer.stop
        @ground.sprite.stop_scroll
        @obstacles.group.set_all "body.velocity.x", Constants::STOPPED
        @obstacles.animal_collectible.body.velocity.x = Constants::STOPPED
        @fluttershy.sprite.load_texture("ouch")
        @fluttershy.sprite.body.set_size(Constants::OUCH_WIDTH, Constants::OUCH_HEIGHT)
        
        keys = [Phaser::Keyboard::SPACEBAR, Phaser::Keyboard::LEFT, Phaser::Keyboard::RIGHT, Phaser::Keyboard::A, Phaser::Keyboard::D]
        keys.each do |key|
          game.input.keyboard.remove_key(key)
        end
      end
      
      game.physics.arcade.collide(@fluttershy.sprite, @ground.sprite)
      game.physics.arcade.collide(@fluttershy.sprite, @obstacles.group, game_over)
      
      @fluttershy.stop_moving
      
      if (@keys.right.down? || @keys.d.down?) && @game_over == false
        @fluttershy.move_right
      end
      
      if (@keys.left.down? || @keys.a.down?) && @game_over == false
        @fluttershy.move_left
      end
      
      if @jumping && @fluttershy.sprite.body.touching.down && @game_over == false
        @jumping = false
        @fluttershy.sprite.load_texture(@fluttershy.walking_key)
        @fluttershy.sprite.body.set_size(Constants::WALKING_WIDTH, Constants::WALKING_HEIGHT)
        @fluttershy.sprite.animations.play(@fluttershy.walking_key)
      end
    end
  end
end