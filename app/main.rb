require 'opal'
require 'opal-phaser'
require 'pp'

require_relative 'constants'

require_relative 'game_objects/game_object'
require_relative 'game_objects/story_slides'
require_relative 'game_objects/background'
require_relative 'game_objects/sounds'
require_relative 'game_objects/obstacles'
require_relative 'game_objects/ground'
require_relative 'game_objects/instructions'
require_relative 'game_objects/score'
require_relative 'game_objects/fluttershy'
require_relative 'game_objects/pause_button'
require_relative 'game_objects/keys'

require_relative 'states/master_state'
require_relative 'states/boot'
require_relative 'states/preload'
require_relative 'states/title'
require_relative 'states/story'
require_relative 'states/playing'

class Flutterjump
  include Constants
  
  attr_reader   :story_slides
  attr_reader   :background
  attr_reader   :sounds
  attr_reader   :obstacles
  attr_reader   :ground
  attr_reader   :instructions
  attr_reader   :score
  attr_reader   :fluttershy
  attr_reader   :pause_button
  attr_reader   :keys
  
  attr_reader   :game_objects
  attr_accessor :jumping
  
  def initialize
    @game   = Phaser::Game.new(width: GAME_WIDTH, height: GAME_HEIGHT, renderer: Phaser::CANVAS, parent: "game")
    
    boot    = Boot.new(@game,    self)
    preload = Preload.new(@game, self)
    title   = Title.new(@game,   self)
    story   = Story.new(@game,   self)
    playing = Playing.new(@game, self)
    
    @game.state.add(:boot,    boot, true)
    @game.state.add(:preload, preload)
    @game.state.add(:title,   title)
    @game.state.add(:story,   story)
    @game.state.add(:playing, playing)
  end
  
  def initialize_objects
    @story_slides = StorySlides.new(@game)
    @background   = Background.new(@game)
    @sounds       = Sounds.new(@game)
    @obstacles    = Obstacles.new(@game)
    @ground       = Ground.new(@game)
    @instructions = Instructions.new(@game)
    @score        = Score.new(@game)
    @fluttershy   = Fluttershy.new(@game)
    @pause_button = PauseButton.new(@game)
    @keys         = Keys.new(@game)
    
    @game_objects = [@story_slides, @background, @sounds, @obstacles, @ground, @instructions, @score, @fluttershy, @pause_button, @keys]
  end
end