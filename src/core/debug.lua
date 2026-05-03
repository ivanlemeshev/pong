---@class Debug
---@field debug_mode boolean
---@field viewport_width number
---@field viewport_height number
local Debug = {}

---@return Debug
---@param debug_mode boolean
function Debug.new(debug_mode, viewport_width, viewport_height)
  local self = setmetatable({}, { __index = Debug })
  self.debug_mode = debug_mode
  self.viewport_width = viewport_width
  self.viewport_height = viewport_height
  return self
end

---@return nil
function Debug:draw()
  if self.debug_mode then
    self:draw_grid()
    self:draw_fsp()
  end
end

function Debug:draw_fsp()
  love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 0)
end

function Debug:draw_grid()
  love.graphics.setLineStyle("rough")

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
