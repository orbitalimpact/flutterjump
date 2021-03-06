class Keys < GameObject
  attr_reader :spacebar
  attr_reader :left
  attr_reader :right
  attr_reader :a
  attr_reader :d
  attr_reader :esc
  
  def create
    keys = {spacebar: Phaser::Keyboard::SPACEBAR, left: Phaser::Keyboard::LEFT, right: Phaser::Keyboard::RIGHT, a: Phaser::Keyboard::A, d: Phaser::Keyboard::D, esc: Phaser::Keyboard::ESC}
    
    keys.each do |name, key|
      variable_value = @@game.input.keyboard.add_key(key)
      instance_variable_set("@#{name}", variable_value)
    end
  end
end