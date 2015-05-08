module Scenes
  def self.title_scene(phaser_game_instance, game_class)
    game_class.background.create
    game_class.ground.create
    title = phaser_game_instance.add.image(Constants::TITLE_X_POS, Constants::TITLE_Y_POS, game_class.text_instructions.title_img_key)
    title_directions = phaser_game_instance.add.image(Constants::TITLE_DIRECTIONS_X_POS, Constants::TITLE_DIRECTIONS_Y_POS, game_class.text_instructions.title_directions_img_key)
    
    change_scene = proc do
      if game_class.current_scene == "title"
        title.destroy
        game_class.background.sprite.destroy
        game_class.ground.sprite.destroy
        game_class.current_scene = "playing"
      end
    end
    
    phaser_game_instance.input.on_down.add(change_scene)
  end
  
  def self.play_scene(phaser_game_instance, game_class)
    jump = proc do
      game_class.jumping = true
      game_class.fluttershy.sprite.body.velocity.y = Constants::JUMP_VELOCITY
    
      game_class.fluttershy.sprite.load_texture(game_class.fluttershy.flying_key)
      game_class.fluttershy.sprite.body.set_size(Constants::FLYING_WIDTH, Constants::FLYING_HEIGHT)
      game_class.fluttershy.sprite.animations.play(game_class.fluttershy.flying_key)
    end
  
    game_class.call_entities_state_method :create
  
    game_class.keys.spacebar.on_down.add(jump)
    
    game_class.scene_counter += 1
  end
  
  def self.game_over_scene(phaser_game_instance, game_class)
    phaser_game_instanceover  = phaser_game_instance.add.image(Constants::GAMEOVER_X_POS, Constants::GAMEOVER_Y_POS, game_class.text_instructions.gameover_img_key)
    try_again = phaser_game_instance.add.sprite(Constants::TRY_AGAIN_X_POS, Constants::TRY_AGAIN_Y_POS, game_class.text_instructions.try_again_img_key)
    
    game_class.obstacles.obstacle_generator.timer.stop
    game_class.ground.sprite.stop_scroll
    game_class.obstacles.group.set_all("body.velocity.x", Constants::STOPPED)
    game_class.obstacles.animal_collectible.body.velocity.x = Constants::STOPPED
    game_class.fluttershy.sprite.load_texture(game_class.fluttershy.ouch_key)
    game_class.fluttershy.sprite.body.set_size(Constants::OUCH_WIDTH, Constants::OUCH_HEIGHT)
  
    keys_to_remove = [Phaser::Keyboard::SPACEBAR, Phaser::Keyboard::LEFT, Phaser::Keyboard::RIGHT, Phaser::Keyboard::A, Phaser::Keyboard::D]
    keys_to_remove.each do |key|
      phaser_game_instance.input.keyboard.remove_key(key)
    end
    
    game_class.scene_counter += 1
  end
end