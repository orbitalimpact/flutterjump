class Sounds < GameObject
  attr_reader :jump
  attr_reader :score
  attr_reader :music
  attr_reader :game_over
  
  def initialize
    @jump_key       = "jump"
    @jump_path      = ["assets/audio/jump.ogg",       "assets/audio/jump.mp3",        "assets/audio/jump.m4a"]
    
    @score_key      = "score"
    @score_path     = ["assets/audio/score.ogg",      "assets/audio/score.mp3",       "assets/audio/score.m4a"]
    
    @music_key      = "music"
    @music_path     = ["assets/audio/game_music.ogg", "assets/audio/game_music.mp3",   "assets/audio/game_music.m4a"]
    
    @game_over_key  = "game over"
    @game_over_path = ["assets/audio/game_over.ogg",  "assets/audio/game_over.mp3",  "assets/audio/game_over.m4a"]
  end
  
  def preload
    @@game.load.audio(@jump_key,      @jump_path)
    @@game.load.audio(@score_key,     @score_path)
    @@game.load.audio(@music_key,     @music_path)
    @@game.load.audio(@game_over_key, @game_over_path)
  end
  
  def create
    @jump      = @@game.add.audio(@jump_key)
    @score     = @@game.add.audio(@score_key)
    @music     = @@game.add.audio(@music_key)
    @game_over = @@game.add.audio(@game_over_key)
  end
end