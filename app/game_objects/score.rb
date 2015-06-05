require_relative '../constants'

class Score
  attr_accessor :amount
  attr_reader   :display
  
  def initialize(game)
    @game = game
  end
  
  def preload
    # nothing to do in here for this class
  end
  
  def create
    @amount  = 0
    @display = @game.add.text(Constants::SCORE_X_POS, Constants::SCORE_Y_POS, @amount.to_s, {font: "30px Verdana"})
  end
end