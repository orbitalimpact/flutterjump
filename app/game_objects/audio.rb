class Audio < GameObject
  attr_reader :jump
  attr_reader :score
  attr_reader :intro_music
  attr_reader :story_music
  attr_reader :game_music
  attr_reader :game_over
  attr_reader :sounds
  
  def initialize
    @jump_key                 = "jump"
    @non_ios_jump_path        = ["assets/audio/jump.ogg",        "assets/audio/jump.mp3"]
    @ios_jump_path            = "assets/audio/jump.m4a"
    
    @score_key                = "score"
    @non_ios_score_path       = ["assets/audio/score.ogg",       "assets/audio/score.mp3"]
    @ios_score_path           = "assets/audio/score.m4a"
    
    @intro_music_key          = "intro music"
    @non_ios_intro_music_path = ["assets/audio/intro_music.ogg", "assets/audio/intro_music.mp3"]
    @ios_intro_music_path     = "intro music"
    
    @story_music_key          = "story music"
    @non_ios_story_music_path = ["assets/audio/story_music.ogg", "assets/audio/story_music.mp3"]
    @ios_story_music_path     = "assets/audio/story_music.m4a"
    
    @game_music_key           = "game music"
    @non_ios_game_music_path  = ["assets/audio/game_music.ogg",  "assets/audio/game_music.mp3"]
    @ios_game_music_path      = "assets/audio/game_music.m4a"
    
    @game_over_key            = "game over"
    @non_ios_game_over_path   = ["assets/audio/game_over.ogg",   "assets/audio/game_over.mp3"]
    @ios_game_over_path       = "assets/audio/game_over.m4a"
  end
  
  def preload
    if @@game.device.iOS
      @@game.load.audio(@jump_key,        @ios_jump_path)
      @@game.load.audio(@score_key,       @ios_score_path)
      @@game.load.audio(@intro_music_key, @ios_intro_music_path)
      @@game.load.audio(@story_music_key, @ios_story_music_path)
      @@game.load.audio(@game_music_key,  @ios_game_music_path)
      @@game.load.audio(@game_over_key,   @ios_game_over_path)
    else
      @@game.load.audio(@jump_key,        @non_ios_jump_path)
      @@game.load.audio(@score_key,       @non_ios_score_path)
      @@game.load.audio(@intro_music_key, @non_ios_intro_music_path)
      @@game.load.audio(@story_music_key, @non_ios_story_music_path)
      @@game.load.audio(@game_music_key,  @non_ios_game_music_path)
      @@game.load.audio(@game_over_key,   @non_ios_game_over_path)
    end
  end
  
  def create
    sound_names = ["jump", "score", "intro_music", "story_music", "game_music", "game_over"]
    @sounds = []
    
    sound_names.each do |name|
      sound = @@game.add.audio(instance_variable_get("@#{name}_key"))
      
      instance_variable_set("@#{name}", sound)
      @sounds.push(instance_variable_get("@#{name}"))
    end
  end
end