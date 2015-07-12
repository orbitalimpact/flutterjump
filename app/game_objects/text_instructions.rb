class TextInstructions < GameObject
  attr_reader :title_img_key
  attr_reader :title_directions_img_key
  attr_reader :game_over_img_key
  attr_reader :try_again_img_key
  attr_reader :press_esc_img_key
  
  def initialize
    @title_img_key             = "title"
    @title_img_path            = "assets/text/title.png"
    
    @title_directions_img_key  = "title directions"
    @title_directions_img_path = "assets/text/title_directions.png"
    
    @game_over_img_key         = "game over"
    @game_over_img_path        = "assets/text/game_over.png"
    
    @try_again_img_key         = "try again"
    @try_again_img_path        = "assets/text/try_again.png"
    
    @press_esc_img_key         = "press esc"
    @press_esc_img_path        = "assets/text/press_esc.png"
  end
  
  def preload
    @@game.load.image(@title_img_key,            @title_img_path)
    @@game.load.image(@title_directions_img_key, @title_directions_img_path)
    @@game.load.image(@game_over_img_key,        @game_over_img_path)
    @@game.load.image(@try_again_img_key,        @try_again_img_path)
    @@game.load.image(@press_esc_img_key,        @press_esc_img_path)
  end
end