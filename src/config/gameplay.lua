-- Shared gameplay config. Treat as immutable.
---@class GameplayConfig
---@field ball_size number
---@field player_width number
---@field player_height number
---@field player_speed number
---@field win_score number
---@field paddle_padding number
---@field ball_speed_multiplier number
---@field ball_min_vertical_speed number
---@field ball_max_vertical_speed number
local Gameplay = {
  ball_size = 4,
  player_width = 6,
  player_height = 28,
  player_speed = 200,
  win_score = 9,
  paddle_padding = 13,
  ball_speed_multiplier = 1.03,
  ball_min_vertical_speed = 10,
  ball_max_vertical_speed = 150,
}

return Gameplay
