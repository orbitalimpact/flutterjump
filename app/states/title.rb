class Title < MasterState
  def create
    @@flutterjump.background.create
    @@flutterjump.ground.create
    
    title            = @@phaser_game.add.image(Constants::TITLE_X_POS, Constants::TITLE_Y_POS, @@flutterjump.text_instructions.title_img_key)
    title_directions = @@phaser_game.add.image(Constants::TITLE_DIRECTIONS_X_POS, Constants::TITLE_DIRECTIONS_Y_POS, @@flutterjump.text_instructions.title_directions_img_key)
    
    next_state = proc do
      title.destroy
      title_directions.destroy
      @@flutterjump.background.sprite.destroy
      @@flutterjump.ground.sprite.destroy
      @@phaser_game.state.start(:story)
    end
    
    @@phaser_game.input.on(:down, &next_state)
  end
end