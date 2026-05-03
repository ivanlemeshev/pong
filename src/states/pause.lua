---@class PauseState: State
---@field state_manager StateManager
---@field viewport_width number
---@field viewport_height number
local PauseState = {}

---@param state_manager StateManager
---@param viewport_width number
---@param viewport_height number
---@return PauseState
function PauseState.new(state_manager, viewport_width, viewport_height)
  local self = setmetatable({}, { __index = PauseState })
  self.state_manager = state_manager
  self.viewport_width = viewport_width
  self.viewport_height = viewport_height
  return self
end

---@return nil
function PauseState:enter() end

---@param dt number
---@return nil
function PauseState:update(dt) end

---@return nil
function PauseState:draw()
  love.graphics.printf(
    "PAUSED",
    0,
    self.viewport_height / 2 - 24,
    self.viewport_width,
    "center"
  )
  love.graphics.printf(
    "Press Space",
    0,
    self.viewport_height / 2 + 4,
    self.viewport_width,
    "center"
  )
end

---@param key string
---@return nil
function PauseState:keypressed(key)
  if key == "space" then
    self.state_manager:change("play")
  end
end

return PauseState
