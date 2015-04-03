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
    keys = {spacebar: Phaser::Keyboard::SPACEBAR, left: Phaser::Keyboard::LEFT, right: Phaser::Keyboard::RIGHT, a: Phaser::Keyboard::A, d: Phaser::Keyboard::D}
    
    keys.each do |name, key|
      variable_value = @game.input.keyboard.add_key(key)
      instance_variable_set("@#{name}", variable_value)
    end
  end
end