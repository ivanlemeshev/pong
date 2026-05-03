local Debug = require("src.core.debug")
local PauseState = require("src.states.pause")
local PlayState = require("src.states.play")
local Settings = require("src.config.settings")
local StartState = require("src.states.start")
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

  local start_state =
    StartState.new(self.state_manager, viewport_width, viewport_height)

  local play_state = PlayState.new(
    self.state_manager,
    viewport_width,
    viewport_height,
    Settings.ball_size
  )

  local pause_state =
    PauseState.new(self.state_manager, viewport_width, viewport_height)

  self.state_manager:register("start", start_state)
  self.state_manager:register("play", play_state)
  self.state_manager:register("pause", pause_state)
  self.state_manager:change("start")

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

---@param key string
---@return nil
function Game:keypressed(key)
  if key == "escape" then
    love.event.quit()
    return
  end

  self.state_manager:keypressed(key)
end

return Game
