class PauseButton < GameObject
  def initialize
    @pause_img_key  = "pause"
    @pause_img_path = "assets/sprites/pause_buttons/pause.png"
    
    @play_img_key   = "play"
    @play_img_path  = "assets/sprites/pause_buttons/play.png"
  end
  
  def preload
    @@game.load.image(@pause_img_key, @pause_img_path)
    @@game.load.image(@play_img_key,  @play_img_path)
  end
  
  def create
    play = proc do
      @@game.paused = false
      @button.load_texture(@pause_img_key)
    end
    
    pause = proc do
      @@game.paused = true
      @@game.input.on(:down, &play)
      @button.load_texture(@play_img_key)
    end
    
    @button = @@game.add.button(Constants::PAUSE_BUTTON_X_POS, Constants::PAUSE_BUTTON_Y_POS, @pause_img_key, &pause)
  end
end