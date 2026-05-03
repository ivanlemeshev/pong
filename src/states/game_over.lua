local Input = require("src.systems.input")

---@class GameOverState: State
---@field context GameContext
---@field state_manager StateManager
---@field message string
local GameOverState = {}

---@param context GameContext
---@param message string
---@return GameOverState
function GameOverState.new(context, message)
  local self = setmetatable({}, { __index = GameOverState })
  self.context = context
  self.state_manager = context.state_manager
  self.message = message or context.text.game_over_default
  return self
end

---@param previous_state string|nil
---@param context table|nil
---@return nil
function GameOverState:enter(previous_state, context)
  if context and context.message then
    self.message = context.message
  else
    self.message = self.message or self.context.text.game_over_default
  end
end

---@param dt number
---@return nil
function GameOverState:update(dt) end

---@return nil
function GameOverState:draw()
  love.graphics.printf(
    self.message,
    0,
    self.context.viewport_height / 2 - 24,
    self.context.viewport_width,
    "center"
  )
  love.graphics.printf(
    self.context.text.game_over_prompt,
    0,
    self.context.viewport_height / 2 + 4,
    self.context.viewport_width,
    "center"
  )
end

---@param key string
---@return nil
function GameOverState:keypressed(key)
  if Input.is_start_key(key) then
    self.state_manager:change("start")
  end
end

return GameOverState
