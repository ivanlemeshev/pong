---@class GameOverState: State
---@field state_manager StateManager
---@field viewport_width number
---@field viewport_height number
---@field message string
---@field set_message fun(self: GameOverState, message: string): nil
local GameOverState = {}

---@param state_manager StateManager
---@param viewport_width number
---@param viewport_height number
---@param message string
---@return GameOverState
function GameOverState.new(state_manager, viewport_width, viewport_height, message)
  local self = setmetatable({}, { __index = GameOverState })
  self.state_manager = state_manager
  self.viewport_width = viewport_width
  self.viewport_height = viewport_height
  self.message = message
  return self
end

---@param message string
---@return nil
function GameOverState:set_message(message)
  self.message = message
end

---@return nil
function GameOverState:enter() end

---@param dt number
---@return nil
function GameOverState:update(dt) end

---@return nil
function GameOverState:draw()
  love.graphics.printf(
    self.message,
    0,
    self.viewport_height / 2 - 24,
    self.viewport_width,
    "center"
  )
  love.graphics.printf(
    "Press Enter",
    0,
    self.viewport_height / 2 + 4,
    self.viewport_width,
    "center"
  )
end

---@param key string
---@return nil
function GameOverState:keypressed(key)
  if key == "return" or key == "kpenter" then
    self.state_manager:change("start")
  end
end

return GameOverState
