class Audio < GameObject
  attr_reader :jump
  attr_reader :score
  attr_reader :title_music
  attr_reader :story_music
  attr_reader :game_music
  attr_reader :game_over
  attr_reader :sounds
  
  def initialize
    @title_music_key          = "title music"
    @non_ios_title_music_path = ["assets/audio/music/title_music.ogg", "assets/audio/music/title_music.mp3"]
    @ios_title_music_path     = "assets/audio/music/title_music.m4a"
    
    @story_music_key          = "story music"
    @non_ios_story_music_path = ["assets/audio/music/story_music.ogg", "assets/audio/music/story_music.mp3"]
    @ios_story_music_path     = "assets/audio/music/story_music.m4a"
    
    @game_music_key           = "game music"
    @non_ios_game_music_path  = ["assets/audio/music/game_music.ogg",  "assets/audio/music/game_music.mp3"]
    @ios_game_music_path      = "assets/audio/music/game_music.m4a"
    
    @jump_key                 = "jump"
    @non_ios_jump_path        = ["assets/audio/effects/jump.ogg",      "assets/audio/effects/jump.mp3"]
    @ios_jump_path            = "assets/audio/effects/jump.m4a"
    
    @score_key                = "score"
    @non_ios_score_path       = ["assets/audio/effects/score.ogg",     "assets/audio/effects/score.mp3"]
    @ios_score_path           = "assets/audio/effects/score.m4a"
    
    @game_over_key            = "game over"
    @non_ios_game_over_path   = ["assets/audio/effects/game_over.ogg", "assets/audio/effects/game_over.mp3"]
    @ios_game_over_path       = "assets/audio/effects/game_over.m4a"
  end
  
  def preload
    if @@game.device.iOS
      @@game.load.audio(@jump_key,        @ios_jump_path)
      @@game.load.audio(@score_key,       @ios_score_path)
      @@game.load.audio(@title_music_key, @ios_title_music_path)
      @@game.load.audio(@story_music_key, @ios_story_music_path)
      @@game.load.audio(@game_music_key,  @ios_game_music_path)
      @@game.load.audio(@game_over_key,   @ios_game_over_path)
    else
      @@game.load.audio(@jump_key,        @non_ios_jump_path)
      @@game.load.audio(@score_key,       @non_ios_score_path)
      @@game.load.audio(@title_music_key, @non_ios_title_music_path)
      @@game.load.audio(@story_music_key, @non_ios_story_music_path)
      @@game.load.audio(@game_music_key,  @non_ios_game_music_path)
      @@game.load.audio(@game_over_key,   @non_ios_game_over_path)
    end
  end
  
  def create
    sound_names = ["jump", "score", "title_music", "story_music", "game_music", "game_over"]
    @sounds = []
    
    sound_names.each do |name|
      sound = @@game.add.audio(instance_variable_get("@#{name}_key"))
      
      instance_variable_set("@#{name}", sound)
      @sounds.push(instance_variable_get("@#{name}"))
    end
  end
end