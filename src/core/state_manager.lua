---@class State
---@field enter fun(self: State, previous_state: string|nil, context: table|nil): nil
---@field update fun(self: State, dt: number): nil
---@field draw fun(self: State): nil
---@field keypressed fun(self: State, key: string): nil

---@class StateManager
---@field current_name string|nil
---@field current State|nil
---@field states table<string, State>
local StateManager = {}

---@return StateManager
function StateManager.new()
  local self = setmetatable({}, { __index = StateManager })
  self.current_name = nil
  self.states = {}
  return self
end

---@param name string
---@param state State
---@return nil
function StateManager:register(name, state)
  self.states[name] = state
end

---@param name string
---@param context table|nil
---@return nil
function StateManager:change(name, context)
  local previous_name = self.current_name
  self.current = self.states[name]
  self.current_name = name

  if self.current and self.current.enter then
    self.current:enter(previous_name, context)
  end
end

---@param dt number
---@return nil
function StateManager:update(dt)
  if self.current then
    self.current:update(dt)
  end
end

---@return nil
function StateManager:draw()
  if self.current then
    self.current:draw()
  end
end

---@param key string
---@return nil
function StateManager:keypressed(key)
  if self.current then
    self.current:keypressed(key)
  end
end

return StateManager
