class Background
  def initialize(game)
    @sprite_key = "background"
    @sprite_url = "assets/sprites/game_world/background.png"
    @game       = game
  end
  
  def preload
    @game.load.image(@sprite_key, @sprite_url)
  end
  
  def create
    @background = @game.add.sprite(0, 0, @sprite_key)
    @background.scale.setTo(1, 1)
  end
end