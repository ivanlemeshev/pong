---@class Debug
---@field debug_mode boolean
---@field font love.Font
---@field viewport_width number
---@field viewport_height number
local Debug = {}

---@return Debug
---@param debug_mode boolean
---@param font love.Font
function Debug.new(debug_mode, font, viewport_width, viewport_height)
  local self = setmetatable({}, { __index = Debug })
  self.debug_mode = debug_mode
  self.font = font
  self.viewport_width = viewport_width
  self.viewport_height = viewport_height
  return self
end

---@return nil
function Debug:draw()
  if self.debug_mode then
    self:draw_grid()
    self:draw_fps()
  end
end

function Debug:draw_fps()
  love.graphics.setFont(self.font)
  love.graphics.setColor(0, 1, 0, 1)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 0)
end

function Debug:draw_grid()
  love.graphics.setLineStyle("rough")
  love.graphics.setColor(0.5, 0.5, 0.5, 1)

  local number_of_lines = 7

  local vy1 = 0
  local vy2 = self.viewport_height

  local hx1 = 0
  local hx2 = self.viewport_width

  for i = 1, number_of_lines, 1 do
    local vx1 = self.viewport_width / (number_of_lines + 1) * i
    local vx2 = vx1

    local hy1 = self.viewport_height / (number_of_lines + 1) * i
    local hy2 = hy1

    love.graphics.line(vx1, vy1, vx2, vy2)
    love.graphics.line(hx1, hy1, hx2, hy2)
  end
end

return Debug
