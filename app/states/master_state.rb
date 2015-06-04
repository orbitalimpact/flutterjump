class MasterState < Phaser::State
  def initialize(phaser_game, flutterjump)
    @@phaser_game = phaser_game
    @@flutterjump = flutterjump
  end
end