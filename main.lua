-- Load dependencies from the .cache/deps directory.
package.path = table.concat({ "./.cache/deps/?.lua", package.path }, ";")

-- Load the push library for virtual resolution handling.
local push = require("push")

-- Main game table to hold all game-related data and configuration.
local Game = {
  fonts = {},
  config = {
    -- Real window dimensions.
    windowWidth = 1280,
    windowHeight = 720,

    -- Virtual window dimensions, for a retro aesthetic.
    -- The actual game will be rendered within this virtual window,
    -- and then scaled up to fit the real window.
    -- 432 / 243 = 16:9, same aspect ratio as 1280 / 720
    virtualWidth = 432,
    virtualHeight = 243,

    -- Colors
    backgroundColor = { r = 0, g = 0, b = 0, a = 1 },
    textColor = { r = 255, g = 255, b = 255, a = 1 },

    -- Font settings
    fontPath = "assets/font.ttf",
    fontSizeLarge = 32,
    fontSizeSmall = 8,

    -- Layout settings for score display, paddles, and ball.
    layout = {
      scoreYFromCenter = 80,
      scorePlayer1XFromCenter = 50,
      scorePlayer2XFromCenter = 30,

      paddleWidth = 5,
      paddleHeight = 20,
      paddle1X = 10,
      paddle1Y = 10,
      paddle2RightMargin = 10,
      paddle2BottomMargin = 10,

      ballSize = 4,
    },
  },

  -- Initial scores for both players.
  scores = {
    player1 = 0,
    player2 = 0,
  },
}

function love.load()
  -- Set the default filter to "nearest" for a pixelated look when scaling.
  love.graphics.setDefaultFilter("nearest", "nearest")

  -- Set up fonts for the game using the specified font path and sizes.
  Game.fonts.large =
    love.graphics.newFont(Game.config.fontPath, Game.config.fontSizeLarge)
  Game.fonts.small =
    love.graphics.newFont(Game.config.fontPath, Game.config.fontSizeSmall)

  -- Set up the window and the virtual resolution using the push library.
  love.window.setMode(
    Game.config.windowWidth,
    Game.config.windowHeight,
    { fullscreen = false, resizable = false, vsync = true }
  )
  push.setupScreen(
    Game.config.virtualWidth,
    Game.config.virtualHeight,
    { upscale = "normal" }
  )
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end

function love.draw()
  -- Calculate the center of the virtual screen for positioning elements.
  local centerX = Game.config.virtualWidth / 2
  local centerY = Game.config.virtualHeight / 2

  -- Calculate the Y position for the score display based on the center of the
  -- screen and the configured offset.
  local scoreY = centerY - Game.config.layout.scoreYFromCenter

  -- Calculate the X and Y positions for the second paddle based on the virtual
  -- screen dimensions and the configured margins.
  local paddle2X = Game.config.virtualWidth
    - Game.config.layout.paddle2RightMargin
    - Game.config.layout.paddleWidth
  local paddle2Y = Game.config.virtualHeight
    - Game.config.layout.paddle2BottomMargin
    - Game.config.layout.paddleHeight

  -- Calculate half the size of the ball for centering it on the screen.
  local ballHalfSize = Game.config.layout.ballSize / 2

  push.start()

  -- Clear the screen with the configured background color.
  love.graphics.clear(
    Game.config.backgroundColor.r,
    Game.config.backgroundColor.g,
    Game.config.backgroundColor.b,
    Game.config.backgroundColor.a
  )

  -- Set the drawing color to the configured text color for rendering scores and
  -- other text elements.
  love.graphics.setColor(
    Game.config.textColor.r,
    Game.config.textColor.g,
    Game.config.textColor.b,
    Game.config.textColor.a
  )

  love.graphics.setFont(Game.fonts.large)

  -- Player 1 score
  love.graphics.print(
    tostring(Game.scores.player1),
    centerX - Game.config.layout.scorePlayer1XFromCenter,
    scoreY
  )

  -- Player 2 score
  love.graphics.print(
    tostring(Game.scores.player2),
    centerX + Game.config.layout.scorePlayer2XFromCenter,
    scoreY
  )

  -- Paddle 1
  love.graphics.rectangle(
    "fill",
    Game.config.layout.paddle1X,
    Game.config.layout.paddle1Y,
    Game.config.layout.paddleWidth,
    Game.config.layout.paddleHeight
  )

  -- Paddle 2
  love.graphics.rectangle(
    "fill",
    paddle2X,
    paddle2Y,
    Game.config.layout.paddleWidth,
    Game.config.layout.paddleHeight
  )

  -- Ball
  love.graphics.rectangle(
    "fill",
    centerX - ballHalfSize,
    centerY - ballHalfSize,
    Game.config.layout.ballSize,
    Game.config.layout.ballSize
  )

  push.finish()
end
