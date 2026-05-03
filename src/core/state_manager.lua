---@class State
---@field enter fun(self: State): nil
---@field update fun(self: State, dt: number): nil
---@field draw fun(self: State): nil
---@field keypressed fun(self: State, key: string): nil

---@class StateManager
---@field current State|nil
---@field states table<string, State>
local StateManager = {}

---@return StateManager
function StateManager.new()
  local self = setmetatable({}, { __index = StateManager })
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
---@return nil
function StateManager:change(name)
  self.current = self.states[name]

  if self.current and self.current.enter then
    self.current:enter()
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
