---@class PlayState: State
---@field state_manager StateManager
---@field ball Ball
---@field viewport_width number
---@field viewport_height number
---@field start fun(self: PlayState): nil
local PlayState = {}

---@param state_manager StateManager
---@param viewport_width number
---@param viewport_height number
---@param ball_size number
---@return PlayState
function PlayState.new(
  state_manager,
  viewport_width,
  viewport_height,
  ball_size
)
  local self = setmetatable({}, { __index = PlayState })
  self.state_manager = state_manager
  self.viewport_width = viewport_width
  self.viewport_height = viewport_height
  self.ball = require("src.entities.ball").new(ball_size)
  return self
end

---@return nil
function PlayState:enter() end

---@return nil
function PlayState:start()
  self.ball:reset(self.viewport_width, self.viewport_height)
end

---@param dt number
---@return nil
function PlayState:update(dt)
  self.ball:update(dt)
end

---@return nil
function PlayState:draw()
  self.ball:draw()
end

---@param key string
---@return nil
function PlayState:keypressed(key)
  if key == "space" then
    self.state_manager:change("pause")
  end
end

return PlayState
