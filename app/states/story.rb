class Story < MasterState
  def create
    @@flutterjump.keys.create
    
    next_slide = proc do
      @@flutterjump.story_slides.slide_index += 1
      
      if @@flutterjump.story_slides.slide_index == 1
        @@flutterjump.story_slides.current_slide = @@phaser_game.add.image(Constants::SLIDES_X_POS, Constants::SLIDES_Y_POS, "slide #{@@flutterjump.story_slides.slide_index}")
      elsif @@flutterjump.story_slides.slide_index <= Constants::FINAL_SLIDE
        @@flutterjump.story_slides.current_slide.load_texture("slide #{@@flutterjump.story_slides.slide_index}")
      end
      
      if @@flutterjump.story_slides.slide_index <= Constants::FINAL_COTTAGE_SLIDE
        @@flutterjump.story_slides.current_slide.scale.set(Constants::COTTAGE_SLIDES_X_SCALE_FACTOR, Constants::COTTAGE_SLIDES_Y_SCALE_FACTOR)
      else
        @@flutterjump.story_slides.current_slide.scale.set(Constants::FOREST_SLIDES_X_SCALE_FACTOR, Constants::FOREST_SLIDES_Y_SCALE_FACTOR)
      end
      
      puts @@flutterjump.story_slides.slide_index
    end
    
    next_slide.call
    
    @@flutterjump.story_slides.current_slide.input_enabled = true
    @@flutterjump.story_slides.current_slide.events.on(:down, self, &next_slide)
    
    @next_state = proc do
      @@flutterjump.story_slides.current_slide.destroy
      @@phaser_game.state.start(:playing)
    end
    
    @escape = @@phaser_game.add.image(Constants::PRESS_ESC_X_POS, Constants::PRESS_ESC_Y_POS, @@flutterjump.text_instructions.press_esc_img_key)
    
    @escape.input_enabled = true
    @escape.events.on(:down, self, &@next_state)
  end
  
  def update
    @@flutterjump.keys.esc.on(:down, &@next_state)
    
    if @@flutterjump.story_slides.slide_index > Constants::FINAL_SLIDE
      @next_state.call
    end
  end
end