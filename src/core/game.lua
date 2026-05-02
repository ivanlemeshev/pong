local PlayState = require("src.states.play")
local Settings = require("src.config.settings")

---@class Game
---@field state_manager StateManager
local Game = {}

---@return Game
function Game:init()
  love.graphics.setDefaultFilter("nearest", "nearest")

  self.virtual_width = Settings.virtual_width
  self.virtual_height = Settings.virtual_height
  self.window_width, self.window_height = love.graphics.getDimensions()

  self.state_manager = require("src.core.state_manager").new()

  local play_state = PlayState.new(
    Settings.virtual_width,
    Settings.virtual_height,
    Settings.ball_size
  )

  self.state_manager:register("play", play_state)
  self.state_manager:change("play")
  return self
end

---@param dt number
---@return nil
function Game:update(dt)
  self.state_manager:update(dt)
end

---@return nil
function Game:draw()
  love.graphics.push()

  local scale_x = self.window_width / self.virtual_width
  local scale_y = self.window_height / self.virtual_height
  local scale_value = math.min(scale_x, scale_y)
  local offset_x =
    math.floor((self.window_width - (self.virtual_width * scale_value)) / 2)
  local offset_y =
    math.floor((self.window_height - (self.virtual_height * scale_value)) / 2)

  love.graphics.translate(offset_x, offset_y)
  love.graphics.scale(scale_value, scale_value)

  love.graphics.clear(0, 0, 0, 1)

  self.state_manager:draw()
  love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)

  love.graphics.pop()
end

return Game
