module Constants
  # Game dimensions
  GAME_WIDTH                  = 800
  GAME_HEIGHT                 = 600
  
  # Background properties
  BACKGROUND_X_POS            = 0
  BACKGROUND_Y_POS            = 0
  BACKGROUND_SCALE_FACTOR     = 1
  
  # Score position
  SCORE_X_POS                 = 400
  SCORE_Y_POS                 = 100
  
  # Ground properties
  GROUND_X_POS                = 0
  GROUND_Y_POS                = 506
  GROUND_WIDTH                = 800
  GROUND_HEIGHT               = 94
  AUTO_SCROLL_X_SPEED         = -250
  AUTO_SCROLL_Y_SPEED         = 0
  
  # Fluttershy starting position
  FLUTTERSHY_START_X_POS      = 270
  FLUTTERSHY_START_Y_POS      = 420
  
  # Fluttershy's animation dimensions
  OUCH_WIDTH                  = 102
  OUCH_HEIGHT                 = 68
  WALKING_WIDTH               = 102
  WALKING_HEIGHT              = 86
  FLYING_WIDTH                = 104
  FLYING_HEIGHT               = 94
  
  # Movement constants
  GRAVITY                     = 300
  JUMP_VELOCITY               = -300
  LEFT_VELOCITY               = -250
  RIGHT_VELOCITY              = 300
  STOPPED                     = 0
  
  # Animations' frame properties
  WALKING_FRAMES              = [ "frame_000.png", "frame_001.png", "frame_002.png", "frame_003.png", "frame_004.png", "frame_005.png", "frame_006.png", "frame_007.png", "frame_008.png", "frame_009.png", "frame_010.png", "frame_011.png", "frame_012.png", "frame_013.png", "frame_014.png", "frame_015.png" ]
  FLYING_FRAMES               = [ "frame_000.png", "frame_001.png", "frame_002.png", "frame_003.png", "frame_004.png", "frame_005.png", "frame_006.png", "frame_007.png", "frame_008.png", "frame_009.png", "frame_010.png", "frame_011.png", "frame_012.png", "frame_013.png", "frame_014.png", "frame_015.png" ]
  FRAME_RATE                  = 20
  LOOP                        = true
  
  # Obstacles' range minimums and maximums
  TOP_OBSTACLE_Y_RANGE_MIN    = -140
  TOP_OBSTACLE_Y_RANGE_MAX    = -90
  BOTTOM_OBSTACLE_Y_RANGE_MIN = 380
  BOTTOM_OBSTACLE_Y_RANGE_MAX = 320
  
  # Obstacles' starting position
  OBSTACLES_START_X_POS       = 800
  
  # Animal collectible properties
  ANIMAL_SCALE_FACTOR         = 0.05
  ANIMAL_START_X_POS          = 850
  
  # Interval between new obstacles (in seconds)
  TIME_INTERVAL               = 3
end