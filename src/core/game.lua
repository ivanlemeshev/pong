local Debug = require("src.core.debug")
local PlayState = require("src.states.play")
local Settings = require("src.config.settings")
local StateManager = require("src.core.state_manager")
local Viewport = require("src.core.viewport")

---@class Game
---@field debug Debug
---@field state_manager StateManager
---@field viewport Viewport
local Game = {}

---@return Game
function Game:init()
  love.graphics.setDefaultFilter("nearest", "nearest")

  local viewport_width = love.graphics.getWidth() / 3
  local viewport_height = love.graphics.getHeight() / 3

  self.debug = Debug.new(Settings.debug_mode, viewport_width, viewport_height)
  self.state_manager = StateManager:new()
  self.viewport = Viewport.new(viewport_width, viewport_height)

  local play_state =
    PlayState.new(viewport_width, viewport_height, Settings.ball_size)

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

  self.viewport:start()
  self.debug:draw()
  self.state_manager:draw()
  self.viewport:finish()
end

return Game
