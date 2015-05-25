module Scenes
  def self.title_scene(phaser_game, flutterjump)
    flutterjump.background.create
    flutterjump.ground.create
    title = phaser_game.add.image(Constants::TITLE_X_POS, Constants::TITLE_Y_POS, flutterjump.text_instructions.title_img_key)
    title_directions = phaser_game.add.image(Constants::TITLE_DIRECTIONS_X_POS, Constants::TITLE_DIRECTIONS_Y_POS, flutterjump.text_instructions.title_directions_img_key)
    
    change_scene = proc do
      if flutterjump.current_scene == "title"
        title.destroy
        title_directions.destroy
        flutterjump.background.sprite.destroy
        flutterjump.ground.sprite.destroy
        flutterjump.current_scene = "story slides"
      end
    end
    
    phaser_game.input.on_down.add(change_scene)
  end
  
  def self.story_slides(phaser_game, flutterjump)
    flutterjump.keys.create
    
    next_slide = proc do
      if flutterjump.current_scene == "story slides"
        flutterjump.story_slides.slide_number += 1
        
        if flutterjump.story_slides.slide_number == 1
          flutterjump.story_slides.slide = phaser_game.add.image(Constants::SLIDES_X_POS, Constants::SLIDES_Y_POS, "slide #{flutterjump.story_slides.slide_number}")
        elsif flutterjump.story_slides.slide_number <= 22
          flutterjump.story_slides.slide.load_texture("slide #{flutterjump.story_slides.slide_number}")
        end
        
        if flutterjump.story_slides.slide_number <= 12
          flutterjump.story_slides.slide.scale.setTo(Constants::SLIDES_X_SCALE_FACTOR, Constants::SLIDES_Y_SCALE_FACTOR)
        else
          flutterjump.story_slides.slide.scale.setTo(1.235, 1.5996)
        end
      end
    end
    
    next_slide.call
    phaser_game.input.on_down.add(next_slide)
    
    flutterjump.scene_counter += 1
  end
  
  def self.playing_scene(phaser_game, flutterjump)
    jump = proc do
      flutterjump.jumping = true
      flutterjump.fluttershy.sprite.body.velocity.y = Constants::JUMP_VELOCITY
      
      flutterjump.fluttershy.sprite.load_texture(flutterjump.fluttershy.flying_key)
      flutterjump.fluttershy.sprite.body.set_size(Constants::FLYING_WIDTH, Constants::FLYING_HEIGHT)
      flutterjump.fluttershy.sprite.animations.play(flutterjump.fluttershy.flying_key)
    end
    
    objects_to_create = [flutterjump.background, flutterjump.obstacles, flutterjump.ground, flutterjump.score, flutterjump.keys, flutterjump.fluttershy]
    
    objects_to_create.each do |object|
      object.create
    end
    
    flutterjump.keys.spacebar.on_down.add(jump)
    
    flutterjump.scene_counter += 1
  end
  
  def self.game_over_scene(phaser_game, flutterjump)
    phaser_gameover = phaser_game.add.image(Constants::GAMEOVER_X_POS, Constants::GAMEOVER_Y_POS, flutterjump.text_instructions.gameover_img_key)
    try_again = phaser_game.add.sprite(Constants::TRY_AGAIN_X_POS, Constants::TRY_AGAIN_Y_POS, flutterjump.text_instructions.try_again_img_key)
    
    flutterjump.obstacles.obstacle_generator.timer.stop
    flutterjump.ground.sprite.stop_scroll
    flutterjump.obstacles.group.set_all("body.velocity.x", Constants::STOPPED)
    flutterjump.obstacles.animal_collectible.body.velocity.x = Constants::STOPPED
    flutterjump.fluttershy.sprite.load_texture(flutterjump.fluttershy.ouch_key)
    flutterjump.fluttershy.sprite.body.set_size(Constants::OUCH_WIDTH, Constants::OUCH_HEIGHT)
    flutterjump.fluttershy.stop_moving
  
    keys_to_remove = [Phaser::Keyboard::SPACEBAR, Phaser::Keyboard::LEFT, Phaser::Keyboard::RIGHT, Phaser::Keyboard::A, Phaser::Keyboard::D]
    keys_to_remove.each do |key|
      phaser_game.input.keyboard.remove_key(key)
    end
    
    flutterjump.scene_counter += 1
  end
end