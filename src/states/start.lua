local Input = require("src.systems.input")

---@class StartState: State
---@field context GameContext
---@field state_manager StateManager
local StartState = {}

---@param context GameContext
---@return StartState
function StartState.new(context)
  local self = setmetatable({}, { __index = StartState })
  self.context = context
  self.state_manager = context.state_manager
  return self
end

---@param previous_state string|nil
---@param context table|nil
---@return nil
function StartState:enter(previous_state, context) end

---@param dt number
---@return nil
function StartState:update(dt) end

---@return nil
function StartState:draw()
  love.graphics.printf(
    self.context.text.title,
    0,
    self.context.viewport_height / 2 - 24,
    self.context.viewport_width,
    "center"
  )
  love.graphics.printf(
    self.context.text.start_prompt,
    0,
    self.context.viewport_height / 2 + 4,
    self.context.viewport_width,
    "center"
  )
end

---@param key string
---@return nil
function StartState:keypressed(key)
  if Input.is_start_key(key) then
    self.state_manager:change("play")
  end
end

return StartState
