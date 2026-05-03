---@class StartState: State
---@field state_manager StateManager
---@field viewport_width number
---@field viewport_height number
local StartState = {}

---@param state_manager StateManager
---@param viewport_width number
---@param viewport_height number
---@return StartState
function StartState.new(state_manager, viewport_width, viewport_height)
  local self = setmetatable({}, { __index = StartState })
  self.state_manager = state_manager
  self.viewport_width = viewport_width
  self.viewport_height = viewport_height
  return self
end

---@return nil
function StartState:enter() end

---@param dt number
---@return nil
function StartState:update(dt) end

---@return nil
function StartState:draw()
  love.graphics.printf(
    "PONG",
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
function StartState:keypressed(key)
  if key == "return" or key == "kpenter" then
    local play_state = self.state_manager.states.play
    ---@cast play_state PlayState
    play_state:start()
    self.state_manager:change("play")
  end
end

return StartState
