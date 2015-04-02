class Keys
  attr_reader :spacebar
  attr_reader :left
  attr_reader :right
  attr_reader :a
  attr_reader :d
  
  def initialize(game)
    @game = game
  end
  
  def preload
    # nothing in here for this class
  end
  
  def create
    @spacebar = @game.input.keyboard.add_key(Phaser::Keyboard::SPACEBAR)
    @left     = @game.input.keyboard.add_key(Phaser::Keyboard::LEFT)
    @right    = @game.input.keyboard.add_key(Phaser::Keyboard::RIGHT)
    @a        = @game.input.keyboard.add_key(Phaser::Keyboard::A)
    @d        = @game.input.keyboard.add_key(Phaser::Keyboard::D)
  end
end