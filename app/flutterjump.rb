require 'pp'
require 'browser'
require_relative 'scenes'

class Flutterjump
  attr_reader   :story_slides
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
    
    @current_scene   = "title"
    @scene_counter = 0
  end
  
  def initialize_entities(game)
    @story_slides      = StorySlides.new(game)
    @background        = Background.new(game)
    @obstacles         = Obstacles.new(game)
    @ground            = Ground.new(game)
    @text_instructions = TextInstructions.new(game)
    @score             = Score.new(game)
    @fluttershy        = Fluttershy.new(game)
    @keys              = Keys.new(game)
    
    @game_objects = [@story_slides, @background, @obstacles, @text_instructions, @ground, @score, @fluttershy, @keys]
  end
  
  def state
    @state ||= Phaser::State.new
  end
  
  def preload
    state.preload do |game|
      initialize_entities(game)
      
      @game_objects.each do |entity|
        entity.send(:preload)
      end
    end
  end
  
  def create
    state.create do |game|
      Scenes::title_scene(game, self)
    end
  end
  
  def update
    state.update do |game|
      case @current_scene
      when "story slides"
        if @scene_counter == 0
          Scenes::story_slides(game, self)
        else
          change_scene = proc do
            @story_slides.slide.destroy
            @current_scene = "playing"
          end
          
          @keys.esc.on_down.add(change_scene)
          if @story_slides.slide_number == 23
            change_scene.call
          end
        end
      when "playing"
        if @scene_counter == 1
          Scenes::playing_scene(game, self)
        else
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
          game.physics.arcade.collide(@fluttershy.sprite, @obstacles.group, change_scene)
          game.physics.arcade.collide(@fluttershy.sprite, @obstacles.animal_collectible, collect_animal)
          
          @fluttershy.stop_moving
          
          if (@keys.right.down? || @keys.d.down?)
            @fluttershy.move_right
          end
          
          if (@keys.left.down? || @keys.a.down?)
            @fluttershy.move_left
          end
          
          if @jumping && @fluttershy.sprite.body.touching.down
            @jumping = false
            @fluttershy.sprite.load_texture(@fluttershy.walking_key)
            @fluttershy.sprite.body.set_size(Constants::WALKING_WIDTH, Constants::WALKING_HEIGHT)
            @fluttershy.sprite.animations.play(@fluttershy.walking_key)
          end
        end
      when "game over"
        if @scene_counter == 2
          Scenes::game_over_scene(game, self)
        else
          change_scene = proc do
            if @current_scene == "game over"
              @fluttershy.sprite.destroy
              @obstacles.group.destroy
              @obstacles.animal_collectible.destroy
              @score.amount  = 0
              @scene_counter = 1
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
end