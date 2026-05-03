---@class GameContext
---@field state_manager StateManager
---@field viewport_width number
---@field viewport_height number
---@field gameplay GameplayConfig
---@field text TextConfig
---@field ui UiConfig
---@field palette Palette
---@field debug_enabled boolean
---@field font any
---@field debug_font any
local Context = {}

---@param data GameContext
---@return GameContext
function Context.new(data)
  return data
end

return Context
