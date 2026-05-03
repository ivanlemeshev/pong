---@class Viewport
---@field window_width number
---@field window_height number
---@field virtual_width number
---@field virtual_height number
local Viewport = {}

---@return Viewport
---@param virtual_width number
---@param virtual_height number
function Viewport.new(virtual_width, virtual_height)
  local self = setmetatable({}, { __index = Viewport })

  self.window_width = love.graphics.getWidth()
  self.window_height = love.graphics.getHeight()
  self.virtual_width = virtual_width
  self.virtual_height = virtual_height

  return self
end

---@return nil
function Viewport:start()
  love.graphics.push()

  local scale_x = self.window_width / self.virtual_width
  local scale_y = self.window_height / self.virtual_height

  local scale_value = math.min(scale_x, scale_y)

  local offset_x =
    math.floor((self.window_width - (self.virtual_width * scale_value)) / 2)
  local offset_y =
    math.floor((self.window_height - (self.virtual_height * scale_value)) / 2)

  love.graphics.translate(offset_x, offset_y)
  love.graphics.scale(scale_value, scale_value)
end

---@return nil
function Viewport:finish()
  love.graphics.pop()
end

return Viewport
