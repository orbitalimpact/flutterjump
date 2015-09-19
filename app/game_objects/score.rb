class Score < GameObject
  attr_accessor :amount
  attr_reader   :display
  attr_reader   :sound
  
  def initialize
    @score_sound_key      = "score"
    @score_sound_path     = ["assets/audio/score.m4a", "assets/audio/score/ogg"]
  end
  
  def preload
    @@game.load.audio(@score_sound_key, @score_sound_path)
  end
  
  def create
    @amount  = 0
    @display = @@game.add.text(Constants::SCORE_X_POS, Constants::SCORE_Y_POS, @amount.to_s, {font: "30px Verdana"})
    
    @sound   = @@game.add.audio(@score_sound_key)
  end
  
  def play_score_sound
    @sound.play
  end
end