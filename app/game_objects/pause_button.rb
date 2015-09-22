class PauseButton < GameObject
  def initialize
    @pause_key  = "pause"
    @pause_path = "assets/sprites/pause_buttons/pause.png"
    
    @play_key   = "play"
    @play_path  = "assets/sprites/pause_buttons/play.png"
  end
  
  def preload
    @@game.load.image(@pause_key, @pause_path)
    @@game.load.image(@play_key,  @play_path)
  end
  
  def create
    play = proc do
      @@game.paused = false
      @button.load_texture(@pause_key)
    end
    
    pause = proc do
      @@game.paused = true
      @@game.input.on(:down, &play)
      @button.load_texture(@play_key)
    end
    
    @button = @@game.add.button(PAUSE_BUTTON_X_POS, PAUSE_BUTTON_Y_POS, @pause_key, &pause)
  end
end