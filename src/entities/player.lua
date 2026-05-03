---@class Player
---@field x number
---@field y number
---@field width number
---@field height number
---@field speed number
---@field score number
---@field move_up fun(self: Player, dt: number, min_y: number): nil
---@field move_down fun(self: Player, dt: number, max_y: number): nil
---@field draw fun(self: Player): nil
local Player = {}

---@param width number
---@param height number
---@param speed number
---@return Player
function Player.new(width, height, speed)
  local self = setmetatable({}, { __index = Player })
  self.x = 0
  self.y = 0
  self.width = width
  self.height = height
  self.speed = speed
  self.score = 0
  return self
end

---@param x number
---@param y number
---@return nil
function Player:set_position(x, y)
  self.x = x
  self.y = y
end

---@return nil
function Player:reset_score()
  self.score = 0
end

---@param dt number
---@param min_y number
---@return nil
function Player:move_up(dt, min_y)
  self.y = math.max(min_y, self.y - self.speed * dt)
end

---@param dt number
---@param max_y number
---@return nil
function Player:move_down(dt, max_y)
  self.y = math.min(max_y, self.y + self.speed * dt)
end

---@param dt number
---@return nil
function Player:update(dt) end

---@return nil
function Player:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Player
