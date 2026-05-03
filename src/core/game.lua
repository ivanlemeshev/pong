local PlayState = require("src.states.play")
local Settings = require("src.config.settings")
local StateManager = require("src.core.state_manager")
local Viewport = require("src.core.viewport")

---@class Game
---@field state_manager StateManager
local Game = {}

---@return Game
function Game:init()
  love.graphics.setDefaultFilter("nearest", "nearest")

  self.state_manager = StateManager:new()
  self.viewport = Viewport.new(Settings.virtual_width, Settings.virtual_height)

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
  self.viewport:start()

  love.graphics.clear(0, 0, 0, 1)

  self.state_manager:draw()

  love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)

  self.viewport:finish()
end

return Game
