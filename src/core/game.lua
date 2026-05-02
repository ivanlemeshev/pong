local PlayState = require("src.states.play")
local Settings = require("src.config.settings")

---@class Game
---@field state_manager StateManager
local Game = {}

---@return Game
function Game:init()
  self.state_manager = require("src.core.state_manager").new()

  local play_state = PlayState.new(
    Settings.world_width,
    Settings.world_height,
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
  love.graphics.clear(0, 0, 0, 1)
  self.state_manager:draw()
end

return Game
