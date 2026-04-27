-- Load dependencies from the .cache/deps directory.
package.path = table.concat({ "./.cache/deps/?.lua", package.path }, ";")

-- Load the push library for virtual resolution handling.
local push = require("push")

-- Main game table to hold all game-related data and configuration.
local Game = {
  window = {
    real = {
      width = 1280,
      height = 720,
    },

    -- Virtual window dimensions, for a retro aesthetic.
    -- The actual game will be rendered within this virtual window,
    -- and then scaled up to fit the real window.
    -- 432 / 243 = 16:9, same aspect ratio as 1280 / 720
    virtual = {
      width = 432,
      height = 243,
    },
  },

  colors = {
    background = { r = 0, g = 0, b = 0, a = 1 },
    draw = { r = 255, g = 255, b = 255, a = 1 },
  },

  fonts = {
    path = "assets/font.ttf",
    size = {
      large = 32,
      small = 8,
    },
  },

  paddle = {
    width = 6,
    height = 20,
    speed = 200,
    padding = 13,
  },

  ball = {
    size = 4,
    x = 0,
    y = 0,
    speedX = 0,
    speedY = 0,
  },

  players = {
    left = {
      score = 0,
      x = 0,
      y = 0,
    },
    right = {
      score = 0,
      x = 0,
      y = 0,
    },
  },
}

function Game.draw_grid()
  love.graphics.setLineStyle("rough")

  local number_of_lines = 7

  local vy1 = 0
  local vy2 = Game.window.virtual.height

  local hx1 = 0
  local hx2 = Game.window.virtual.width

  for i = 1, number_of_lines, 1 do
    local vx1 = Game.window.virtual.width / (number_of_lines + 1) * i
    local vx2 = vx1

    local hy1 = Game.window.virtual.height / (number_of_lines + 1) * i
    local hy2 = hy1

    love.graphics.line(vx1, vy1, vx2, vy2)
    love.graphics.line(hx1, hy1, hx2, hy2)
  end
end

function love.load()
  -- Set the default filter to "nearest" for a pixelated look when scaling
  love.graphics.setDefaultFilter("nearest", "nearest")

  -- Set fonts
  local font_path = Game.fonts.path
  Game.fonts.large = love.graphics.newFont(font_path, Game.fonts.size.large)
  Game.fonts.small = love.graphics.newFont(font_path, Game.fonts.size.small)

  -- Set window
  love.window.setMode(Game.window.real.width, Game.window.real.height, {
    fullscreen = false,
    resizable = false,
    vsync = true,
  })

  push.setupScreen(
    Game.window.virtual.width,
    Game.window.virtual.height,
    { upscale = "normal" }
  )

  -- Set the initial ball position
  Game.ball.x = Game.window.virtual.width / 2 - Game.ball.size / 2
  Game.ball.y = Game.window.virtual.height / 2 - Game.ball.size / 2

  -- Set the initial left player position
  Game.players.left.x = Game.paddle.padding - Game.paddle.width / 2
  Game.players.left.y = Game.window.virtual.height / 2 - Game.paddle.height / 2

  -- Set the initial right player position
  Game.players.right.x = Game.window.virtual.width
    - Game.paddle.padding
    - Game.paddle.width / 2
  Game.players.right.y = Game.window.virtual.height / 2 - Game.paddle.height / 2
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end

function love.update(dt)
  if love.keyboard.isDown("s") then
    Game.players.left.y = Game.players.left.y - Game.paddle.speed * dt
  end

  if love.keyboard.isDown("d") then
    Game.players.left.y = Game.players.left.y + Game.paddle.speed * dt
  end

  if love.keyboard.isDown("j") then
    Game.players.right.y = Game.players.right.y - Game.paddle.speed * dt
  end

  if love.keyboard.isDown("k") then
    Game.players.right.y = Game.players.right.y + Game.paddle.speed * dt
  end
end

function love.draw()
  push.start()

  -- Clear the screen to the specified color
  love.graphics.clear(
    Game.colors.background.r,
    Game.colors.background.g,
    Game.colors.background.b,
    Game.colors.background.a
  )

  -- Set the drawing color
  love.graphics.setColor(
    Game.colors.draw.r,
    Game.colors.draw.g,
    Game.colors.draw.b,
    Game.colors.draw.a
  )

  -- Set the font
  love.graphics.setFont(Game.fonts.large)

  Game.draw_grid()

  -- Set the left player
  love.graphics.print(tostring(Game.players.left.score))

  love.graphics.rectangle(
    "fill",
    Game.players.left.x,
    Game.players.left.y,
    Game.paddle.width,
    Game.paddle.height
  )

  -- Set the right player
  love.graphics.print(tostring(Game.players.right.score))

  love.graphics.rectangle(
    "fill",
    Game.players.right.x,
    Game.players.right.y,
    Game.paddle.width,
    Game.paddle.height
  )

  -- Set the ball
  love.graphics.rectangle(
    "fill",
    Game.ball.x,
    Game.ball.y,
    Game.ball.size,
    Game.ball.size
  )

  push.finish()
end
