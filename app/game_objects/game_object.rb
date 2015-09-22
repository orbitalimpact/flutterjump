class GameObject
  include Constants
  
  def initialize(game)
    @@game = game
  end
  
  def method_missing(method)
  end
end