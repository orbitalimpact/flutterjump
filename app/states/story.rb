class Story < MasterState
  def create
    @@flutterjump.keys.create
    
    next_slide = proc do
      @@flutterjump.story_slides.slide_index += 1
      
      if @@flutterjump.story_slides.slide_index == 1
        @@flutterjump.story_slides.current_slide = @@phaser_game.add.image(SLIDES_X_POS, SLIDES_Y_POS, "slide #{@@flutterjump.story_slides.slide_index}")
      elsif @@flutterjump.story_slides.slide_index <= FINAL_SLIDE
        @@flutterjump.story_slides.current_slide.load_texture("slide #{@@flutterjump.story_slides.slide_index}")
      end
      
      if @@flutterjump.story_slides.slide_index <= FINAL_COTTAGE_SLIDE
        @@flutterjump.story_slides.current_slide.scale.set(COTTAGE_SLIDES_X_SCALE_FACTOR, COTTAGE_SLIDES_Y_SCALE_FACTOR)
      else
        @@flutterjump.story_slides.current_slide.scale.set(FOREST_SLIDES_X_SCALE_FACTOR, FOREST_SLIDES_Y_SCALE_FACTOR)
      end
    end
    
    next_slide.call
    
    @@flutterjump.story_slides.current_slide.input_enabled = true
    @@flutterjump.story_slides.current_slide.events.on(:down, self, &next_slide)
    
    @next_state = proc do
      @@flutterjump.story_slides.current_slide.destroy
      @@flutterjump.sounds.intro_music.stop
      @@flutterjump.sounds.audio_objects.each { |object| object.destroy }
      @@phaser_game.state.start(:playing)
    end
    
    @skip = @@phaser_game.add.image(SKIP_X_POS, SKIP_Y_POS, @@flutterjump.instructions.skip_key)
    
    @skip.input_enabled = true
    @skip.events.on(:down, self, &@next_state)
    
    @@flutterjump.sounds.intro_music.play(loop: true)
  end
  
  def update
    @@flutterjump.keys.esc.on(:down, &@next_state)
    
    if @@flutterjump.story_slides.slide_index > FINAL_SLIDE
      @next_state.call
    end
  end
end