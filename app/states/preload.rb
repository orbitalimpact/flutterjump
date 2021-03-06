class Preload < MasterState
  def preload
    loading_bar = @@phaser_game.add.image(LOADING_BAR_X_POS, LOADING_BAR_Y_POS, "loading")
    loading_bar.anchor.set(LOADING_BAR_ANCHOR)
    @@phaser_game.load.set_preload_sprite(loading_bar)
    
    @@flutterjump.game_objects.each do |object|
      object.send(:preload)
    end
  end
  
  def create
    @@phaser_game.state.start(:title)
  end
end