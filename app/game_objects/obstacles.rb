class Obstacles < GameObject
  attr_reader :group
  attr_reader :obstacle_generator
  attr_reader :animal_collectible
  
  def initialize
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
  end
  
  def preload
    @@game.load.image(@top_obstacle_key,     @top_obstacle_path)
    @@game.load.image(@bottom_obstacle_key , @bottom_obstacle_path)
    
    @@game.load.image(@bunny_key,    @bunny_path)
    @@game.load.image(@bird_key,     @bird_path)
    @@game.load.image(@duck_key,     @duck_path)
    @@game.load.image(@ferret_key,   @ferret_path)
    @@game.load.image(@beaver_key,   @beaver_path)
    @@game.load.image(@squirrel_key, @squirrel_path)
  end
  
  def create
    @group = @@game.add.group
    @group.enable_body = true
    
    animals = [@bunny_key, @bird_key, @duck_key, @ferret_key, @beaver_key, @squirrel_key]
    
    generate_obstacles = proc do
      top_obstacle_y_range    = @@game.rnd.integer_in_range(Constants::TOP_OBSTACLE_Y_RANGE_MIN, Constants::TOP_OBSTACLE_Y_RANGE_MAX)
      bottom_obstacle_y_range = @@game.rnd.integer_in_range(Constants::BOTTOM_OBSTACLE_Y_RANGE_MIN, Constants::BOTTOM_OBSTACLE_Y_RANGE_MAX)
      
      top_obstacle    = @group.create(Constants::OBSTACLES_START_X_POS, top_obstacle_y_range, @top_obstacle_key)
      top_obstacle.body.set_size(Constants::TOP_OBSTACLE_WIDTH, Constants::TOP_OBSTACLE_HEIGHT, Constants::TOP_OBSTACLE_X_OFFSET)
      
      bottom_obstacle = @group.create(Constants::OBSTACLES_START_X_POS, bottom_obstacle_y_range, @bottom_obstacle_key)
      bottom_obstacle.body.set_size(Constants::BOTTOM_OBSTACLE_WIDTH, Constants::BOTTOM_OBSTACLE_HEIGHT, Constants::BOTTOM_OBSTACLE_X_OFFSET, Constants::BOTTOM_OBSTACLE_Y_OFFSET)
      
      @group.set_all("body.immovable", true)
      @group.set_all("body.velocity.x", Constants::LEFT_VELOCITY)
      
      animal_y_pos  = (bottom_obstacle.y - top_obstacle.y) / 2
      random_animal = rand(animals.length)
      
      @animal_collectible = @@game.add.sprite(Constants::ANIMAL_START_X_POS, animal_y_pos, animals[random_animal])
      @animal_collectible.scale.set(Constants::ANIMAL_SCALE_FACTOR)
      @@game.physics.arcade.enable(@animal_collectible)
      @animal_collectible.body.velocity.x = Constants::LEFT_VELOCITY
    end
    
    @obstacle_generator = @@game.time.events.loop(Phaser::Timer::SECOND * Constants::TIME_INTERVAL, &generate_obstacles)
    @obstacle_generator.timer.start
  end
  
  def stop
    @obstacle_generator.timer.stop
    @group.set_all("body.velocity.x", Constants::STOPPED)
    @animal_collectible.body.velocity.x = Constants::STOPPED
  end
end