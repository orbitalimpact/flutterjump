class Boot < MasterState
  def initialize
    @loading_img_key  = "loading"
    @loading_img_path = "assets/sprites/loading/loading.png"
  end
  
  def preload
    @@phaser_game.load.image(@loading_img_key, @loading_img_path)
  end
  
  def create
    @@flutterjump.initialize_objects
    
    @@phaser_game.state.start(:preload)
  end
end