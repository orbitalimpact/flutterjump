class Story < MasterState
  def create
    @@flutterjump.keys.create
    
    next_slide = proc do
      @@flutterjump.story_slides.slide_number += 1
      
      if @@flutterjump.story_slides.slide_number == 1
        @@flutterjump.story_slides.slide = @@phaser_game.add.image(Constants::SLIDES_X_POS, Constants::SLIDES_Y_POS, "slide #{@@flutterjump.story_slides.slide_number}")
      elsif @@flutterjump.story_slides.slide_number <= 22
        @@flutterjump.story_slides.slide.load_texture("slide #{@@flutterjump.story_slides.slide_number}")
      end
      
      if @@flutterjump.story_slides.slide_number <= 12
        @@flutterjump.story_slides.slide.scale.set(Constants::COTTAGE_SLIDES_X_SCALE_FACTOR, Constants::COTTAGE_SLIDES_Y_SCALE_FACTOR)
      else
        @@flutterjump.story_slides.slide.scale.set(Constants::FOREST_SLIDES_X_SCALE_FACTOR, Constants::FOREST_SLIDES_Y_SCALE_FACTOR)
      end
    end
    
    next_slide.call
    @@phaser_game.input.on(:down, &next_slide)
    
    @@phaser_game.add.image(Constants::PRESS_ESC_X_POS, Constants::PRESS_ESC_Y_POS, @@flutterjump.text_instructions.press_esc_img_key)
  end
  
  def update
    next_state = proc do
      @@flutterjump.story_slides.slide.destroy
      @@phaser_game.state.start(:playing)
    end
    
    @@flutterjump.keys.esc.on(:down, &next_state)
    
    if @@flutterjump.story_slides.slide_number == 23
      next_state.call
    end
  end
end