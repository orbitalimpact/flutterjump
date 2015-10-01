class Title < MasterState
  def create
    @@flutterjump.background.create
    @@flutterjump.audio.create
    @@flutterjump.ground.create
    
    @@flutterjump.audio.title_music.fade_in(INTRO_MUSIC_FADE_DURATION)
    
    title          = @@phaser_game.add.image(TITLE_X_POS, TITLE_Y_POS, @@flutterjump.instructions.title_key)
    click_to_start = @@phaser_game.add.image(TITLE_DIRECTIONS_X_POS, TITLE_DIRECTIONS_Y_POS, @@flutterjump.instructions.click_to_start_key)
    
    next_state = proc do
      title.destroy
      click_to_start.destroy
      @@flutterjump.background.sprite.destroy
      @@flutterjump.ground.sprite.destroy
      @@flutterjump.audio.title_music.stop
      @@phaser_game.state.start(:story)
    end
    
    @@phaser_game.input.on(:down, &next_state)
  end
end