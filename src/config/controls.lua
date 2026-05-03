-- Shared control bindings. Treat as immutable.
---@class ControlBindings
---@field start table<string>
---@field pause string
---@field left table<string, string>
---@field right table<string, string>
local Controls = {
  start = { "return", "kpenter" },
  pause = "space",
  left = { up = "d", down = "s" },
  right = { up = "k", down = "j" },
}

return Controls
