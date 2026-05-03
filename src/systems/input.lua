local Controls = require("src.config.controls")

---@class InputSystem
local Input = {}

---@param key string
---@return boolean
function Input.is_start_key(key)
  return key == Controls.start[1] or key == Controls.start[2]
end

---@param key string
---@return boolean
function Input.is_pause_key(key)
  return key == Controls.pause
end

---@param player_1 Player
---@param player_2 Player
---@param dt number
---@param viewport_height number
---@return nil
function Input.update_players(player_1, player_2, dt, viewport_height)
  local max_y = viewport_height - player_1.height

  if love.keyboard.isDown(Controls.left.up) then
    player_1:move_up(dt, 0)
  elseif love.keyboard.isDown(Controls.left.down) then
    player_1:move_down(dt, max_y)
  end

  if love.keyboard.isDown(Controls.right.up) then
    player_2:move_up(dt, 0)
  elseif love.keyboard.isDown(Controls.right.down) then
    player_2:move_down(dt, max_y)
  end
end

return Input
