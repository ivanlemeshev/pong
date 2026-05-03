---@class CollisionSystem
local Collision = {}

---@param ball Ball
---@param player Player
---@return boolean
function Collision.ball_hits_player(ball, player)
  local ball_left = ball.x
  local ball_right = ball.x + ball.size
  local ball_top = ball.y
  local ball_bottom = ball.y + ball.size
  local player_left = player.x
  local player_right = player.x + player.width
  local player_top = player.y
  local player_bottom = player.y + player.height

  return ball_right >= player_left
    and ball_left <= player_right
    and ball_bottom >= player_top
    and ball_top <= player_bottom
end

---@param ball Ball
---@return boolean
function Collision.ball_hits_top(ball)
  return ball.y <= 0
end

---@param ball Ball
---@param viewport_height number
---@return boolean
function Collision.ball_hits_bottom(ball, viewport_height)
  return ball.y >= viewport_height - ball.size
end

---@param ball Ball
---@param viewport_width number
---@return boolean
function Collision.ball_out_left(ball, viewport_width)
  return ball.x + ball.size < 0
end

---@param ball Ball
---@param viewport_width number
---@return boolean
function Collision.ball_out_right(ball, viewport_width)
  return ball.x > viewport_width
end

return Collision
