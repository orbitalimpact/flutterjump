require 'opal'
require 'opal-phaser'
require './constants'
require './background'
require './ground'

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
      entities_state_call :preload
    end
  end
  
  def create
    state.create do
      entities_state_call :create
    end
  end
  
  def update
    state.update do 
      entities_state_call :update
    end
  end
  
  def initialize_entities(game)
    @background = Background.new(game)
    @ground     = Ground.new(game)
    
    @game_entities = [@background, @ground]
  end
  
  def entities_state_call(method)
    @game_entities.each do |entity|
      entity.send(method)
    end
  end
end