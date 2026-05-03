---@class Ball
---@field size number
---@field x number
---@field y number
---@field dx number
---@field dy number
---@field reset fun(self: Ball, world_width: number, world_height: number): nil
---@field update fun(self: Ball, dt: number): nil
---@field draw fun(self: Ball): nil
local Ball = {}

-- Serve direction is chosen randomly between left and right.
local INITIAL_DIRECTION_CHOICES = 2

-- Base horizontal speed for a new serve.
local INITIAL_HORIZONTAL_SPEED = 100

-- Vertical speed is sampled from a symmetric range around zero.
local INITIAL_VERTICAL_SPEED_MIN = 50
local INITIAL_VERTICAL_SPEED_MAX = 50

-- Scales the vertical component so the serve is less flat.
local INITIAL_VERTICAL_SPEED_SCALE = 1.5

---@param size number
---@return Ball
function Ball.new(size)
  local self = setmetatable({}, { __index = Ball })
  self.size = size
  self.x = 0
  self.y = 0
  self.dx = 0
  self.dy = 0
  return self
end

---@param viewport_width number
---@param viewport_height number
---@return nil
function Ball:reset(viewport_width, viewport_height)
  -- Start in the middle of the viewport.
  self.x = viewport_width / 2 - self.size / 2
  self.y = viewport_height / 2 - self.size / 2

  -- Randomly choose the horizontal direction and speed.
  self.dx = (math.random(INITIAL_DIRECTION_CHOICES) == 1 and 1 or -1)
    * INITIAL_HORIZONTAL_SPEED

  -- Randomly choose the vertical speed.
  self.dy = math.random(-INITIAL_VERTICAL_SPEED_MIN, INITIAL_VERTICAL_SPEED_MAX)
    * INITIAL_VERTICAL_SPEED_SCALE
end

---@param dt number
---@return nil
function Ball:update(dt)
  -- Update the position based on the velocity and time delta to smoothly move
  -- the ball.
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
end

---@return nil
function Ball:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

return Ball
