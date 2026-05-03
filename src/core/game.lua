local Debug = require("src.core.debug")
local DebugConfig = require("src.config.debug")
local Context = require("src.core.context")
local Display = require("src.config.display")
local GameOverState = require("src.states.game_over")
local Gameplay = require("src.config.gameplay")
local Palette = require("src.config.palette")
local Text = require("src.config.text")
local PauseState = require("src.states.pause")
local PlayState = require("src.states.play")
local StartState = require("src.states.start")
local StateManager = require("src.core.state_manager")
local Ui = require("src.config.ui")
local Viewport = require("src.core.viewport")

---@class Game
---@field debug Debug
---@field font any
---@field debug_font any
---@field context GameContext
---@field state_manager StateManager
---@field viewport Viewport
local Game = {}

---@return Game
function Game:init()
  love.graphics.setDefaultFilter("nearest", "nearest")

  self.font = love.graphics.newFont(Ui.font_path, Ui.score_font_size)
  self.debug_font = love.graphics.newFont(Ui.font_path, Ui.debug_font_size)
  love.graphics.setFont(self.font)

  self.state_manager = StateManager:new()
  self.viewport = Viewport.new(Display.virtual_width, Display.virtual_height)
  self.context = Context.new({
    state_manager = self.state_manager,
    viewport_width = Display.virtual_width,
    viewport_height = Display.virtual_height,
    gameplay = Gameplay,
    text = Text,
    ui = Ui,
    palette = Palette,
    debug_enabled = DebugConfig.enabled,
    font = self.font,
    debug_font = self.debug_font,
  })

  self.debug = Debug.new(self.context)

  local start_state = StartState.new(self.context)
  local play_state = PlayState.new(self.context)
  local pause_state = PauseState.new(self.context)
  local game_over_state = GameOverState.new(
    self.context,
    self.context.text.game_over_default
  )

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
  love.graphics.clear(self.context.palette.background)

  self.viewport:start()
  love.graphics.setFont(self.font)
  self.debug:draw()
  love.graphics.setFont(self.font)
  love.graphics.setColor(self.context.palette.foreground)
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
