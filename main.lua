-- Load dependencies from the .cache/deps directory
package.path = table.concat({ "./.cache/deps/?.lua", package.path }, ";")

-- Load the push library for virtual resolution handling
local push = require("push")

-- Real window dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Virtual window dimensions, for a retro aesthetic.
-- The actual game will be rendered within this virtual window,
-- and then scaled up to fit the real window.
-- 432 / 243 = 16:9, same aspect ratio as 1280 / 720
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- NOTE: Colors are in the range [0, 1], so we divide RGB values by 255

-- Background color
BACKGROUND_R = 0 / 255
BACKGROUND_G = 0 / 255
BACKGROUND_B = 0 / 255
BACKGROUND_A = 1

-- Text color
TEXT_R = 255 / 255
TEXT_G = 255 / 255
TEXT_B = 255 / 255
TEXT_A = 1

-- Fonts
FONT_SIZE_LARGE = 32
FONT_SIZE_SMALL = 8

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")

  FONT_LARGE = love.graphics.newFont("assets/font.ttf", FONT_SIZE_LARGE)
  FONT_SMALL = love.graphics.newFont("assets/font.ttf", FONT_SIZE_SMALL)

  love.window.setMode(
    WINDOW_WIDTH,
    WINDOW_HEIGHT,
    { fullscreen = false, resizable = false, vsync = true }
  )
  push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = "normal" })
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end

function love.draw()
  push.start()

  love.graphics.clear(BACKGROUND_R, BACKGROUND_G, BACKGROUND_B, BACKGROUND_A)
  love.graphics.setColor(TEXT_R, TEXT_G, TEXT_B, TEXT_A)

  -- love.graphics.setFont(FONT_LARGE)
  -- love.graphics.printf(
  --   "PONG",
  --   0,
  --   VIRTUAL_HEIGHT / 2 - FONT_SIZE_LARGE / 2,
  --   VIRTUAL_WIDTH,
  --   "center"
  -- )

  -- Paddle 1
  love.graphics.rectangle("fill", 10, 10, 5, 20)

  -- Paddle 2
  love.graphics.rectangle(
    "fill",
    VIRTUAL_WIDTH - 15,
    VIRTUAL_HEIGHT - 30,
    5,
    20
  )

  -- Ball
  love.graphics.rectangle(
    "fill",
    VIRTUAL_WIDTH / 2 - 2,
    VIRTUAL_HEIGHT / 2 - 2,
    4,
    4
  )

  push.finish()
end
