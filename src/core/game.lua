local Debug = require("src.core.debug")
local GameOverState = require("src.states.game_over")
local PauseState = require("src.states.pause")
local PlayState = require("src.states.play")
local Settings = require("src.config.settings")
local StartState = require("src.states.start")
local StateManager = require("src.core.state_manager")
local Viewport = require("src.core.viewport")

---@class Game
---@field debug Debug
---@field font love.Font
---@field debug_font love.Font
---@field state_manager StateManager
---@field viewport Viewport
local Game = {}

---@return Game
function Game:init()
  love.graphics.setDefaultFilter("nearest", "nearest")
  self.font = love.graphics.newFont(Settings.font_path, Settings.score_font_size)
  self.debug_font =
    love.graphics.newFont(Settings.font_path, Settings.debug_font_size)
  love.graphics.setFont(self.font)

  local viewport_width = love.graphics.getWidth() / 3
  local viewport_height = love.graphics.getHeight() / 3

  self.debug =
    Debug.new(Settings.debug_mode, self.debug_font, viewport_width, viewport_height)
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
  local game_over_state =
    GameOverState.new(self.state_manager, viewport_width, viewport_height, "Game Over")

  self.state_manager:register("start", start_state)
  self.state_manager:register("play", play_state)
  self.state_manager:register("pause", pause_state)
  self.state_manager:register("game_over", game_over_state)
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
  love.graphics.setFont(self.font)
  self.debug:draw()
  love.graphics.setFont(self.font)
  love.graphics.setColor(1, 1, 1, 1)
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
