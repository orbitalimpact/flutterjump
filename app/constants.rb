module Constants
  # Game dimensions
  GAME_WIDTH                    = 800
  GAME_HEIGHT                   = 600
  
  # Loading bar properties
  LOADING_BAR_X_POS             = 400
  LOADING_BAR_Y_POS             = 300
  LOADING_BAR_ANCHOR            = 0.5
  
  # Title scene text positions
  TITLE_X_POS                   = 240
  TITLE_Y_POS                   = 250
  TITLE_DIRECTIONS_X_POS        = 310
  TITLE_DIRECTIONS_Y_POS        = 320
  
  # Game over scene text positions
  GAME_OVER_X_POS               = 115
  GAME_OVER_Y_POS               = 140
  TRY_AGAIN_X_POS               = 230
  TRY_AGAIN_Y_POS               = 335
  
  # Intro story properties
  SLIDES_X_POS                  = 0
  SLIDES_Y_POS                  = 0
  
  COTTAGE_SLIDES_X_SCALE_FACTOR = 1.235
  COTTAGE_SLIDES_Y_SCALE_FACTOR = 1.48
  
  FOREST_SLIDES_X_SCALE_FACTOR  = 1.235
  FOREST_SLIDES_Y_SCALE_FACTOR  = 1.5996
  
  PRESS_ESC_X_POS               = 0
  PRESS_ESC_Y_POS               = 0
  
  # Background properties
  BACKGROUND_X_POS              = 0
  BACKGROUND_Y_POS              = 0
  BACKGROUND_SCALE_FACTOR       = 1
  
  # Score position
  SCORE_X_POS                   = 400
  SCORE_Y_POS                   = 100
  
  # High score position
  HIGH_SCORE_X_POS              = 305
  HIGH_SCORE_Y_POS              = 0
  
  # Pause button position
  PAUSE_BUTTON_X_POS            = 765
  PAUSE_BUTTON_Y_POS            = 10
  
  # Ground properties
  GROUND_X_POS                  = 0
  GROUND_Y_POS                  = 506
  GROUND_WIDTH                  = 800
  GROUND_HEIGHT                 = 94
  AUTO_SCROLL_X_SPEED           = -250
  AUTO_SCROLL_Y_SPEED           = 0
  
  # Fluttershy starting position
  FLUTTERSHY_START_X_POS        = 270
  FLUTTERSHY_START_Y_POS        = 420
  
  # Fluttershy's animation dimensions
  OUCH_WIDTH                    = 102
  OUCH_HEIGHT                   = 68
  WALKING_WIDTH                 = 102
  WALKING_HEIGHT                = 86
  FLYING_WIDTH                  = 104
  FLYING_HEIGHT                 = 94
  
  # Movement constants
  GRAVITY                       = 300
  JUMP_VELOCITY                 = -300
  LEFT_VELOCITY                 = -250
  RIGHT_VELOCITY                = 300
  STOPPED                       = 0
  
  # Animations' frame properties
  WALKING_FRAMES                = [ "frame_000.png", "frame_001.png", "frame_002.png", "frame_003.png", "frame_004.png", "frame_005.png", "frame_006.png", "frame_007.png", "frame_008.png", "frame_009.png", "frame_010.png", "frame_011.png", "frame_012.png", "frame_013.png", "frame_014.png", "frame_015.png" ]
  FLYING_FRAMES                 = [ "frame_000.png", "frame_001.png", "frame_002.png", "frame_003.png", "frame_004.png", "frame_005.png", "frame_006.png", "frame_007.png", "frame_008.png", "frame_009.png", "frame_010.png", "frame_011.png", "frame_012.png", "frame_013.png", "frame_014.png", "frame_015.png" ]
  FRAME_RATE                    = 20
  LOOP                          = true
  
  # Obstacles' range minimums and maximums
  TOP_OBSTACLE_Y_RANGE_MIN      = -135
  TOP_OBSTACLE_Y_RANGE_MAX      = -90
  BOTTOM_OBSTACLE_Y_RANGE_MIN   = 375
  BOTTOM_OBSTACLE_Y_RANGE_MAX   = 320
  
  # Obstacles' starting position
  OBSTACLES_START_X_POS         = 800
  
  # Obstacles' dimensions
  TOP_OBSTACLE_WIDTH            = 115
  TOP_OBSTACLE_HEIGHT           = 261
  TOP_OBSTACLE_X_OFFSET         = 20
  
  BOTTOM_OBSTACLE_WIDTH         = 128
  BOTTOM_OBSTACLE_HEIGHT        = 284
  BOTTOM_OBSTACLE_X_OFFSET      = 19
  BOTTOM_OBSTACLE_Y_OFFSET      = 33
  
  # Animal collectible properties
  ANIMAL_SCALE_FACTOR           = 0.05
  ANIMAL_START_X_POS            = 850
  
  # Interval between new obstacles (in seconds)
  TIME_INTERVAL                 = 3
end