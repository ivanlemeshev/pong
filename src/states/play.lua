local Input = require("src.systems.input")
local Match = require("src.gameplay.match")

---@class PlayState: State
---@field state_manager StateManager
---@field match Match
local PlayState = {}

---@param context GameContext
---@return PlayState
function PlayState.new(context)
  local self = setmetatable({}, { __index = PlayState })
  self.state_manager = context.state_manager
  self.match = Match.new(context)
  return self
end

---@param previous_state string|nil
---@param context table|nil
---@return nil
function PlayState:enter(previous_state, context)
  if previous_state == "start" then
    self.match:reset_match()
  end
end

---@param dt number
---@return nil
function PlayState:update(dt)
  local winner_message = self.match:update(dt)
  if winner_message then
    self.state_manager:change("game_over", { message = winner_message })
  end
end

---@return nil
function PlayState:draw()
  self.match:draw()
end

---@param key string
---@return nil
function PlayState:keypressed(key)
  if Input.is_pause_key(key) then
    self.state_manager:change("pause")
  end
end

return PlayState
