---@class Debug
---@field context GameContext
---@field debug_mode boolean
---@field font any
local Debug = {}

---@return Debug
---@param context GameContext
function Debug.new(context)
  local self = setmetatable({}, { __index = Debug })
  self.context = context
  self.debug_mode = context.debug_enabled
  self.font = context.debug_font
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
  love.graphics.setColor(self.context.palette.fps)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 0)
end

function Debug:draw_grid()
  love.graphics.setLineStyle("rough")
  love.graphics.setColor(self.context.palette.grid)

  local number_of_lines = 7

  local vy1 = 0
  local vy2 = self.context.viewport_height

  local hx1 = 0
  local hx2 = self.context.viewport_width

  for i = 1, number_of_lines, 1 do
    local vx1 = self.context.viewport_width / (number_of_lines + 1) * i
    local vx2 = vx1

    local hy1 = self.context.viewport_height / (number_of_lines + 1) * i
    local hy2 = hy1

    love.graphics.line(vx1, vy1, vx2, vy2)
    love.graphics.line(hx1, hy1, hx2, hy2)
  end
end

return Debug
