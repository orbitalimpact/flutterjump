require_relative '../constants'

class StorySlides
  attr_accessor :slide
  attr_accessor :slide_number
  
  def initialize(game)
    @slide_number = 0
    
    @game         = game
  end
  
  def preload
    @slides_hash = {
      "slide 1" => "assets/sprites/story_slides/slide_1.png",
      "slide 2" => "assets/sprites/story_slides/slide_2.png",
      "slide 3" => "assets/sprites/story_slides/slide_3.png",
      "slide 4" => "assets/sprites/story_slides/slide_4.png",
      "slide 5" => "assets/sprites/story_slides/slide_5.png",
      "slide 6" => "assets/sprites/story_slides/slide_6.png",
      "slide 7" => "assets/sprites/story_slides/slide_7.png",
      "slide 8" => "assets/sprites/story_slides/slide_8.png",
      "slide 9" => "assets/sprites/story_slides/slide_9.png",
      "slide 10" => "assets/sprites/story_slides/slide_10.png",
      "slide 11" => "assets/sprites/story_slides/slide_11.png",
      "slide 12" => "assets/sprites/story_slides/slide_12.png",
      "slide 13" => "assets/sprites/story_slides/slide_13.png",
      "slide 14" => "assets/sprites/story_slides/slide_14.png",
      "slide 15" => "assets/sprites/story_slides/slide_15.png",
      "slide 16" => "assets/sprites/story_slides/slide_16.png",
      "slide 17" => "assets/sprites/story_slides/slide_17.png",
      "slide 18" => "assets/sprites/story_slides/slide_18.png",
      "slide 19" => "assets/sprites/story_slides/slide_19.png",
      "slide 20" => "assets/sprites/story_slides/slide_20.png",
      "slide 21" => "assets/sprites/story_slides/slide_21.png",
      "slide 22" => "assets/sprites/story_slides/slide_22.png"
    }
    
    @slides_hash.each do |name, path|
      @game.load.image(name, path)
    end
  end
  
  def create
    # nothing to do in here for this class
  end
end