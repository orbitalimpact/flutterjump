require 'constants'

class Obstacles
  attr_reader :group
  
  def initialize(game)
    @top_obstacle_key     = "top obstacle"
    @top_obstacle_path    = "assets/sprites/game_world/cloud.png"
    
    @bottom_obstacle_key  = "bottom obstacle"
    @bottom_obstacle_path = "assets/sprites/game_world/tree.png"
    
    @game                 = game
  end
  
  def preload
    @game.load.image(@top_obstacle_key, @top_obstacle_path)
    @game.load.image(@bottom_obstacle_key , @bottom_obstacle_path)
  end
  
  def create
    @group = @game.add.group
    @group.enable_body = true
    
    generate_obstacles = proc do
      top_random_range    = @game.rnd.integer_in_range(Constants::TOP_RANDOM_RANGE_MIN, Constants::TOP_RANDOM_RANGE_MAX)
      bottom_random_range = @game.rnd.integer_in_range(Constants::BOTTOM_RANDOM_RANGE_MIN, Constants::BOTTOM_RANDOM_RANGE_MAX)
      
      top_obstacle    = @group.create(@game.width, top_random_range, @top_obstacle_key)
      bottom_obstacle = @group.create(@game.width, bottom_random_range, @bottom_obstacle_key)
      @group.set_all "body.immovable", true
      @group.set_all "body.velocity.x", Constants::LEFT_VELOCITY
    end
    
    @obstacle_generator = @game.time.events.loop(Phaser::Timer::SECOND * Constants::TIME_INTERVAL, generate_obstacles)
    @obstacle_generator.timer.start
  end
end