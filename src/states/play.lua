---@class PlayState: State
---@field ball Ball
---@field world_width number
---@field world_height number
local PlayState = {}

---@param world_width number
---@param world_height number
---@param ball_size number
---@return PlayState
function PlayState.new(world_width, world_height, ball_size)
  local self = setmetatable({}, { __index = PlayState })
  self.world_width = world_width
  self.world_height = world_height
  self.ball = require("src.entities.ball").new(ball_size)
  return self
end

---@return nil
function PlayState:enter()
  self.ball:reset(self.world_width, self.world_height)
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

return PlayState
