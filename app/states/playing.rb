class Playing < MasterState
  def initialize
    @game_over    = false
    @down_counter = 0
  end
  
  def create
    @jump_or_try_again = proc do
      unless @game_over
        @@flutterjump.jumping = true
        @@flutterjump.fluttershy.sprite.body.velocity.y = JUMP_VELOCITY
      
        @@flutterjump.fluttershy.sprite.load_texture(@@flutterjump.fluttershy.flying_key)
        @@flutterjump.fluttershy.sprite.body.set_size(FLYING_WIDTH, FLYING_HEIGHT)
        @@flutterjump.fluttershy.sprite.animations.play(@@flutterjump.fluttershy.flying_key)
        
        @@flutterjump.sounds.jump.play
      else
        @@flutterjump.background.sprite.destroy
        @@flutterjump.obstacles.group.destroy
        @@flutterjump.obstacles.animal_collectible.destroy
        @@flutterjump.ground.sprite.destroy
        @@flutterjump.fluttershy.sprite.destroy
        
        @game_over_text.destroy
        @try_again_text.destroy
        
        @@flutterjump.score.amount = 0
        @game_over = false
        create
      end
    end
    
    @@flutterjump.game_objects.each do |object|
      object.send(:create)
    end
    
    if @down_counter == 0
    @@flutterjump.sounds.music.play
    
      @@flutterjump.keys.spacebar.on(:down, &@jump_or_try_again)
      @@phaser_game.input.on(        :down, &@jump_or_try_again)
      @down_counter += 1
    end
  end
  
  def update
    game_over_screen = proc do
      unless @game_over
        @game_over = true
        
        @@flutterjump.sounds.music.stop
        @@flutterjump.sounds.game_over.play
        
        if @@flutterjump.score.amount > $$.localStorage.getItem("high_score").to_i || !$$.localStorage.getItem("high_score")
          $$.localStorage.setItem("high_score", @@flutterjump.score.amount)
        end
        
        @@phaser_game.add.text(HIGH_SCORE_X_POS, HIGH_SCORE_Y_POS, "High score: #{$$.localStorage.getItem("high_score")}", {font: "30px Verdana"})
        
        @game_over_text = @@phaser_game.add.image(GAME_OVER_X_POS, GAME_OVER_Y_POS, @@flutterjump.instructions.game_over_key)
        @try_again_text = @@phaser_game.add.sprite(TRY_AGAIN_X_POS, TRY_AGAIN_Y_POS, @@flutterjump.instructions.try_again_key)
        
        @@flutterjump.obstacles.stop
        @@flutterjump.background.sprite.stop_scroll
        @@flutterjump.ground.sprite.stop_scroll
        @@flutterjump.fluttershy.stop_walking
        
        @@flutterjump.fluttershy.sprite.load_texture(@@flutterjump.fluttershy.ouch_key)
        @@flutterjump.fluttershy.sprite.body.set_size(OUCH_WIDTH, OUCH_HEIGHT)
      end
    end
    
    collect_animal = proc do
      @@flutterjump.obstacles.animal_collectible.kill
      @@flutterjump.score.amount += 1
      @@flutterjump.score.display.text = @@flutterjump.score.amount
      @@flutterjump.sounds.score.play
    end
    
    @@phaser_game.physics.arcade.collide(@@flutterjump.fluttershy.sprite, @@flutterjump.ground.sprite)
    @@phaser_game.physics.arcade.collide(@@flutterjump.fluttershy.sprite, @@flutterjump.obstacles.group, &game_over_screen)
    
    unless @game_over
      @@flutterjump.fluttershy.stop_walking
      
      @@phaser_game.physics.arcade.collide(@@flutterjump.fluttershy.sprite, @@flutterjump.obstacles.animal_collectible, &collect_animal)
      
      if @@flutterjump.keys.right.down? || @@flutterjump.keys.d.down?
        @@flutterjump.fluttershy.move_right
      end
      
      if @@flutterjump.keys.left.down? || @@flutterjump.keys.a.down?
        @@flutterjump.fluttershy.move_left
      end
      
      if @@flutterjump.jumping && @@flutterjump.fluttershy.sprite.body.touching.down
        @@flutterjump.jumping = false
        @@flutterjump.fluttershy.sprite.load_texture(@@flutterjump.fluttershy.walking_key)
        @@flutterjump.fluttershy.sprite.body.set_size(WALKING_WIDTH, WALKING_HEIGHT)
        @@flutterjump.fluttershy.sprite.animations.play(@@flutterjump.fluttershy.walking_key)
      end
    end
  end
end