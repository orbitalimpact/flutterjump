class Instructions < GameObject
  attr_reader :title_key
  attr_reader :click_to_start_key
  attr_reader :game_over_key
  attr_reader :try_again_key
  attr_reader :skip_key
  
  def initialize
    @title_key                = "title"
    @title_path               = "assets/sprites/instructions/title.png"
    
    @click_to_start_key       = "click to start"
    @click_to_start_path      = "assets/sprites/instructions/click_to_start.png"
    
    @skip_key                 = "skip"
    @skip_path                = "assets/sprites/instructions/skip.png"
    
    @controls_key             = "controls"
    @controls_path            = "assets/sprites/instructions/controls.png"
    
    @game_over_key            = "game over"
    @game_over_path           = "assets/sprites/instructions/game_over.png"
    
    @try_again_key            = "try again"
    @try_again_path           = "assets/sprites/instructions/try_again.png"
    
    @controls_have_been_shown = false
  end
  
  def preload
    @@game.load.image(@title_key,          @title_path)
    @@game.load.image(@click_to_start_key, @click_to_start_path)
    @@game.load.image(@skip_key,           @skip_path)
    @@game.load.image(@controls_key,       @controls_path)
    @@game.load.image(@game_over_key,      @game_over_path)
    @@game.load.image(@try_again_key,      @try_again_path)
  end
  
  def create
    unless @controls_have_been_shown
      controls = @@game.add.image(CONTROLS_IMAGE_X_POS, CONTROLS_IMAGE_Y_POS, @controls_key)
      controls.alpha = 0
    
      @@game.add.tween(controls).to(properties: {alpha: 1}, duration: CONTROLS_IMAGE_DURATION, ease: Phaser::Easing::Linear.None, auto_start: true, yoyo: true)
      @controls_have_been_shown = true
    end
  end
end