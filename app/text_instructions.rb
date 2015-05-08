class TextInstructions
  attr_reader :title_img_key
  attr_reader :title_directions_img_key
  attr_reader :gameover_img_key
  attr_reader :try_again_img_key
  
  def initialize(game)
    @title_img_key             = "title"
    @title_img_path            = "assets/text/title.png"
    
    @title_directions_img_key  = "title directions"
    @title_directions_img_path = "assets/text/title_directions.png"
    
    @gameover_img_key          = "gameover"
    @gameover_img_path         = "assets/text/gameover.png"
    
    @try_again_img_key         = "try again"
    @try_again_img_path        = "assets/text/try_again.png"
    
    @game                      = game
  end
  
  def preload
    @game.load.image(@title_img_key, @title_img_path)
    @game.load.image(@title_directions_img_key, @title_directions_img_path)
    @game.load.image(@gameover_img_key, @gameover_img_path)
    @game.load.image(@try_again_img_key, @try_again_img_path)
  end
  
  def create
    # nothing to do in here for this class
  end
end