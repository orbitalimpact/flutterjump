require 'constants'

class Obstacles
  attr_reader :group
  attr_reader :obstacle_generator
  attr_reader :animal_collectible
  
  def initialize(game)
    @top_obstacle_key     = "top obstacle"
    @top_obstacle_path    = "assets/sprites/game_world/cloud.png"
    
    @bottom_obstacle_key  = "bottom obstacle"
    @bottom_obstacle_path = "assets/sprites/game_world/tree.png"
    
    @bunny_key            = "angel bunny"
    @bunny_path           = "assets/sprites/animals/angel_bunny.png"
    @bird_key             = "bird"
    @bird_path            = "assets/sprites/animals/bird.png"
    @duck_key             = "duckling"
    @duck_path            = "assets/sprites/animals/duckling.png"
    @ferret_key           = "ferret"
    @ferret_path          = "assets/sprites/animals/ferret.png"
    @beaver_key           = "mr beaverton beaverteeth"
    @beaver_path          = "assets/sprites/animals/mr_beaverton_beaverteeth.png"
    @squirrel_key         = "squirrel"
    @squirrel_path        = "assets/sprites/animals/squirrel.png"
    
    @game                 = game
  end
  
  def preload
    @game.load.image(@top_obstacle_key,     @top_obstacle_path)
    @game.load.image(@bottom_obstacle_key , @bottom_obstacle_path)
    
    @game.load.image(@bunny_key,    @bunny_path)
    @game.load.image(@bird_key,     @bird_path)
    @game.load.image(@duck_key,     @duck_path)
    @game.load.image(@ferret_key,   @ferret_path)
    @game.load.image(@beaver_key,   @beaver_path)
    @game.load.image(@squirrel_key, @squirrel_path)
  end
  
  def create
    @group = @game.add.group
    @group.enable_body = true
    
    animals = [@bunny_key, @bird_key, @duck_key, @ferret_key, @beaver_key, @squirrel_key]
    
    generate_obstacles = proc do
      top_random_range    = @game.rnd.integer_in_range(Constants::TOP_RANDOM_RANGE_MIN, Constants::TOP_RANDOM_RANGE_MAX)
      bottom_random_range = @game.rnd.integer_in_range(Constants::BOTTOM_RANDOM_RANGE_MIN, Constants::BOTTOM_RANDOM_RANGE_MAX)
      
      top_obstacle    = @group.create(Constants::OBSTACLES_START_X_POS, top_random_range, @top_obstacle_key)
      bottom_obstacle = @group.create(Constants::OBSTACLES_START_X_POS, bottom_random_range, @bottom_obstacle_key)
      @group.set_all "body.immovable", true
      @group.set_all "body.velocity.x", Constants::LEFT_VELOCITY
      
      animal_y_pos  = (bottom_obstacle.y - top_obstacle.y) / 2
      random_animal = rand(6)
      
      @animal_collectible = @game.add.sprite(Constants::ANIMAL_X_START_POS, animal_y_pos, animals[random_animal])
      @animal_collectible.scale.set(Constants::ANIMAL_SCALE_FACTOR)
      @game.physics.arcade.enable(@animal_collectible)
      @animal_collectible.body.velocity.x = Constants::LEFT_VELOCITY
    end
    
    @obstacle_generator = @game.time.events.loop(Phaser::Timer::SECOND * Constants::TIME_INTERVAL, generate_obstacles)
    @obstacle_generator.timer.start
  end
end