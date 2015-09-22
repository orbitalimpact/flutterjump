class Boot < MasterState
  def initialize
    @loading_key  = "loading"
    @loading_path = "assets/sprites/loading/loading.png"
  end
  
  def preload
    @@phaser_game.load.image(@loading_key, @loading_path)
  end
  
  def create
    @@flutterjump.initialize_objects
    
    @@phaser_game.state.start(:preload)
  end
end