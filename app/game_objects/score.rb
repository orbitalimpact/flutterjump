class Score < GameObject
  attr_accessor :amount
  attr_reader   :display
  
  def create
    @amount  = 0
    @display = @@game.add.text(SCORE_X_POS, SCORE_Y_POS, @amount.to_s, {font: "30px Verdana"})
  end
end