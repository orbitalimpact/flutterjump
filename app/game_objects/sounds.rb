class Sounds < GameObject
  attr_reader :jump
  attr_reader :score
  attr_reader :music
  attr_reader :game_over
  attr_reader :audio_objects
  
  def initialize
    @jump_key               = "jump"
    @non_ios_jump_path      = ["assets/audio/jump.ogg",       "assets/audio/jump.mp3"]
    @ios_jump_path          = "assets/audio/jump.m4a"
    
    @score_key              = "score"
    @non_ios_score_path     = ["assets/audio/score.ogg",      "assets/audio/score.mp3"]
    @ios_score_path         = "assets/audio/score.m4a"
    
    @music_key              = "music"
    @non_ios_music_path     = ["assets/audio/game_music.ogg", "assets/audio/game_music.mp3"]
    @ios_music_path         = "assets/audio/game_music.m4a"
    
    @game_over_key          = "game over"
    @non_ios_game_over_path = ["assets/audio/game_over.ogg",  "assets/audio/game_over.mp3"]
    @ios_game_over_path     = "assets/audio/game_over.m4a"
  end
  
  def preload
    if @@game.device.iOS
      @@game.load.audio(@jump_key,      @ios_jump_path)
      @@game.load.audio(@score_key,     @ios_score_path)
      @@game.load.audio(@music_key,     @ios_music_path)
      @@game.load.audio(@game_over_key, @ios_game_over_path)
    else
      @@game.load.audio(@jump_key,      @non_ios_jump_path)
      @@game.load.audio(@score_key,     @non_ios_score_path)
      @@game.load.audio(@music_key,     @non_ios_music_path)
      @@game.load.audio(@game_over_key, @non_ios_game_over_path)
    end
  end
  
  def create
    sound_names = ["jump", "score", "music", "game_over"]
    @audio_objects = []
    
    sound_names.each do |name|
      sound = @@game.add.audio(instance_variable_get("@#{name}_key"))
      instance_variable_set("@#{name}", sound)
      @audio_objects.push(instance_variable_get("@#{name}"))
    end
  end
end