local Input = require("src.systems.input")

---@class PauseState: State
---@field context GameContext
---@field state_manager StateManager
local PauseState = {}

---@param context GameContext
---@return PauseState
function PauseState.new(context)
  local self = setmetatable({}, { __index = PauseState })
  self.context = context
  self.state_manager = context.state_manager
  return self
end

---@param previous_state string|nil
---@param context table|nil
---@return nil
function PauseState:enter(previous_state, context) end

---@param dt number
---@return nil
function PauseState:update(dt) end

---@return nil
function PauseState:draw()
  love.graphics.printf(
    self.context.text.pause_title,
    0,
    self.context.viewport_height / 2 - 24,
    self.context.viewport_width,
    "center"
  )
  love.graphics.printf(
    self.context.text.pause_prompt,
    0,
    self.context.viewport_height / 2 + 4,
    self.context.viewport_width,
    "center"
  )
end

---@param key string
---@return nil
function PauseState:keypressed(key)
  if Input.is_pause_key(key) then
    self.state_manager:change("play")
  end
end

return PauseState
