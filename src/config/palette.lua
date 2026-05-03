-- Shared palette. Treat as immutable.
---@class Palette
---@field background table
---@field foreground table
---@field grid table
---@field fps table
local Palette = {
  background = { 0, 0, 0, 1 },
  foreground = { 1, 1, 1, 1 },
  grid = { 0.5, 0.5, 0.5, 1 },
  fps = { 0, 1, 0, 1 },
}

return Palette
