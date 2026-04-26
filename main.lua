package.path = table.concat({ "./.cache/deps/?.lua", package.path }, ";")

local push = require("push")

local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

-- 432 / 243 = 16:9, same aspect ratio as 1280 / 720
local VIRTUAL_WIDTH = 432
local VIRTUAL_HEIGHT = 243

local FONT_HEIGHT = 8

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
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
  love.graphics.printf(
    "HELLO, PONG!",
    0,
    VIRTUAL_HEIGHT / 2 - FONT_HEIGHT,
    VIRTUAL_WIDTH,
    "center"
  )
  push.finish()
end
