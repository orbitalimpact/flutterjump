require 'pp'
require_relative 'scenes'

class Game
  attr_reader   :background
  attr_reader   :obstacles
  attr_reader   :ground
  attr_reader   :text_instructions
  attr_reader   :score
  attr_reader   :fluttershy
  attr_reader   :keys
  attr_writer   :jumping
  attr_accessor :current_scene
  attr_accessor :scene_counter
  
  def initialize
    preload
    create
    update
    
    Phaser::Game.new(width: Constants::GAME_WIDTH, height: Constants::GAME_HEIGHT, renderer: Phaser::CANVAS, parent: "game", state: state)
    
    @which_scene   = "title"
    @scene_counter = 0
  end
  
  def initialize_entities(game)
    @background = Background.new(game)
    @obstacles  = Obstacles.new(game)
    @ground     = Ground.new(game)
    @score      = Score.new(game)
    @fluttershy = Fluttershy.new(game)
    @keys       = Keys.new(game)
    
    @game_entities = [@background, @obstacles, @ground, @score, @fluttershy, @keys]
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
      
      game.load.image("title", "assets/text/title.png")
      game.load.image("title_directions", "assets/text/title_directions.png")
      call_entities_state_method :preload
    end
  end
  
  def create
    state.create do |game|
      Scenes::title_scene(game, self)
    end
  end
  
  def update
    state.update do |game|
      if @current_scene == "playing" && @scene_counter == 0
        Scenes::play_scene(game, self)
      elsif @current_scene == "playing"
        change_scene = proc do
          if @current_scene == "playing"
            @current_scene = "game over"
          end
        end
      
        
        collect_animal = proc do
          @obstacles.animal_collectible.kill
          @score.amount += 1
          @score.display.text = @score.amount
        end
      
        game.physics.arcade.collide(@fluttershy.sprite, @ground.sprite)
        game.physics.arcade.collide(@fluttershy.sprite, @obstacles.group, game_over)
        game.physics.arcade.collide(@fluttershy.sprite, @obstacles.animal_collectible, collect_animal)
      
      
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
      elsif @current_scene == "game over" && @scene_counter == 1
        Scenes::game_over_scene(game, self)
      elsif @current_scene == "game over"
        change_scene = proc do
          if @current_scene == "game over"
            @fluttershy.sprite.destroy
            @obstacles.group.destroy
            @obstacles.animal_collectible.destroy
            @score.amount  = 0
            @scene_counter = 0
            @current_scene = "playing"
          end
        end
        
        game.physics.arcade.collide(@fluttershy.sprite, @ground.sprite)
        game.physics.arcade.collide(@fluttershy.sprite, @obstacles.group)
        
        game.input.on_down.add(change_scene)
      end
    end
  end
end