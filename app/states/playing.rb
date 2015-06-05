class Playing < MasterState
  def initialize
    @game_over_counter = 0
    @game_over = false
  end
  
  def create
    jump = proc do
      if @game_over == false
        @@flutterjump.jumping = true
        @@flutterjump.fluttershy.sprite.body.velocity.y = Constants::JUMP_VELOCITY
      
        @@flutterjump.fluttershy.sprite.load_texture(@@flutterjump.fluttershy.flying_key)
        @@flutterjump.fluttershy.sprite.body.set_size(Constants::FLYING_WIDTH, Constants::FLYING_HEIGHT)
        @@flutterjump.fluttershy.sprite.animations.play(@@flutterjump.fluttershy.flying_key)
      end
    end
    
    @objects_to_create = [@@flutterjump.background, @@flutterjump.obstacles, @@flutterjump.ground, @@flutterjump.score, @@flutterjump.keys, @@flutterjump.fluttershy]
    
    @objects_to_create.each do |object|
      object.create
    end
    
    @@flutterjump.keys.spacebar.on(:down, &jump)
  end
  
  def update
    game_over_screen = proc do
      if @game_over == false
        @game_over = true
        
        if @@flutterjump.score.amount > $$.localStorage.getItem("high_score").to_i || !$$.localStorage.getItem("high_score")
          $$.localStorage.setItem("high_score", @@flutterjump.score.amount)
        end
        
        @@phaser_game.add.text(Constants::HIGH_SCORE_X_POS, Constants::HIGH_SCORE_Y_POS, "High score: #{$$.localStorage.getItem("high_score")}", {font: "30px Verdana"})
        
        @game_over_text = @@phaser_game.add.image(Constants::GAME_OVER_X_POS, Constants::GAME_OVER_Y_POS, @@flutterjump.text_instructions.game_over_img_key)
        @try_again_text = @@phaser_game.add.sprite(Constants::TRY_AGAIN_X_POS, Constants::TRY_AGAIN_Y_POS, @@flutterjump.text_instructions.try_again_img_key)
        
        @@flutterjump.obstacles.obstacle_generator.timer.stop
        @@flutterjump.ground.sprite.stop_scroll
        @@flutterjump.obstacles.group.set_all("body.velocity.x", Constants::STOPPED)
        @@flutterjump.obstacles.animal_collectible.body.velocity.x = Constants::STOPPED
        @@flutterjump.fluttershy.sprite.load_texture(@@flutterjump.fluttershy.ouch_key)
        @@flutterjump.fluttershy.sprite.body.set_size(Constants::OUCH_WIDTH, Constants::OUCH_HEIGHT)
        @@flutterjump.fluttershy.stop_moving
        
        keys_to_remove = [Phaser::Keyboard::LEFT, Phaser::Keyboard::RIGHT, Phaser::Keyboard::A, Phaser::Keyboard::D]
        keys_to_remove.each do |key|
          @@phaser_game.input.keyboard.remove_key(key)
        end
      end
    end
    
    collect_animal = proc do
      @@flutterjump.obstacles.animal_collectible.kill
      @@flutterjump.score.amount += 1
      @@flutterjump.score.display.text = @@flutterjump.score.amount
    end
    
    @@phaser_game.physics.arcade.collide(@@flutterjump.fluttershy.sprite, @@flutterjump.ground.sprite)
    @@phaser_game.physics.arcade.collide(@@flutterjump.fluttershy.sprite, @@flutterjump.obstacles.group, game_over_screen)
    
    if @game_over == false
      @@phaser_game.physics.arcade.collide(@@flutterjump.fluttershy.sprite, @@flutterjump.obstacles.animal_collectible, collect_animal)
    end
    
    @@flutterjump.fluttershy.stop_moving
    
    if (@@flutterjump.keys.right.down? || @@flutterjump.keys.d.down?) && @game_over == false
      @@flutterjump.fluttershy.move_right
    end
    
    if (@@flutterjump.keys.left.down? || @@flutterjump.keys.a.down?) && @game_over == false
      @@flutterjump.fluttershy.move_left
    end
    
    if @@flutterjump.jumping && @@flutterjump.fluttershy.sprite.body.touching.down && @game_over == false
      @@flutterjump.jumping = false
      @@flutterjump.fluttershy.sprite.load_texture(@@flutterjump.fluttershy.walking_key)
      @@flutterjump.fluttershy.sprite.body.set_size(Constants::WALKING_WIDTH, Constants::WALKING_HEIGHT)
      @@flutterjump.fluttershy.sprite.animations.play(@@flutterjump.fluttershy.walking_key)
    end
    
    try_again = proc do
      if @game_over_counter == 0 && @game_over == true
        @@flutterjump.background.sprite.destroy
        @@flutterjump.obstacles.group.destroy
        @@flutterjump.ground.sprite.destroy
        @@flutterjump.fluttershy.sprite.destroy
        
        @game_over_text.destroy
        @try_again_text.destroy
        
        @@flutterjump.score.amount = 0
        @game_over = false
        create
          
        @game_over_counter += 1
      elsif @game_over == false
        @game_over_counter = 0
      end
    end
    
    @@phaser_game.input.on(:down, &try_again)
    @@flutterjump.keys.spacebar.on(:down, &try_again)
  end
end