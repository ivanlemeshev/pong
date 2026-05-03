---@class GameSettings
---@field debug_mode boolean
---@field ball_size number
---@field player_width number
---@field player_height number
---@field player_speed number
---@field win_score number
---@field score_font_size number
---@field debug_font_size number
---@field font_path string
local Settings = {
  debug_mode = false,
  ball_size = 4,
  player_width = 6,
  player_height = 28,
  player_speed = 200,
  win_score = 9,
  score_font_size = 32,
  debug_font_size = 12,
  font_path = "assets/font.ttf",
}

return Settings
