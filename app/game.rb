require 'pp'

class Game
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
  
  def play_scene
    jump = proc do
      @jumping = true
      @fluttershy.sprite.body.velocity.y = Constants::JUMP_VELOCITY
    
      @fluttershy.sprite.load_texture(@fluttershy.flying_key)
      @fluttershy.sprite.body.set_size(Constants::FLYING_WIDTH, Constants::FLYING_HEIGHT)
      @fluttershy.sprite.animations.play(@fluttershy.flying_key)
    end
  
    call_entities_state_method :create
  
    @keys.spacebar.on_down.add(jump)
    
    @scene_counter += 1
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
      @background.create
      @ground.create
      title = game.add.image(Constants::TITLE_X_POS, Constants::TITLE_Y_POS, "title")
      title_directions = game.add.image(Constants::TITLE_DIRECTIONS_X_POS, Constants::TITLE_DIRECTIONS_Y_POS, "title_directions")
      
      change_scene = proc do
        if @which_scene == "title"
          title.destroy
          @background.sprite.destroy
          @ground.sprite.destroy
        end
        
        @which_scene = "playing"
      end
      
      game.input.on_down.add(change_scene)
    end
  end
  
  def update
    state.update do |game|
      if @which_scene == "playing" && @scene_counter == 0
        play_scene
      elsif @which_scene == "playing"
        game_over = proc do
          @game_over = true
          @obstacles.obstacle_generator.timer.stop
          @ground.sprite.stop_scroll
          @obstacles.group.set_all("body.velocity.x", Constants::STOPPED)
          @obstacles.animal_collectible.body.velocity.x = Constants::STOPPED
          @fluttershy.sprite.load_texture("ouch")
          @fluttershy.sprite.body.set_size(Constants::OUCH_WIDTH, Constants::OUCH_HEIGHT)
        
          keys_to_remove = [Phaser::Keyboard::SPACEBAR, Phaser::Keyboard::LEFT, Phaser::Keyboard::RIGHT, Phaser::Keyboard::A, Phaser::Keyboard::D]
          keys_to_remove.each do |key|
            game.input.keyboard.remove_key(key)
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
      end
    end
  end
end