-- Shared UI text. Treat as immutable.
---@class TextConfig
---@field title string
---@field start_prompt string
---@field pause_title string
---@field pause_prompt string
---@field game_over_default string
---@field game_over_prompt string
---@field player_1_wins string
---@field player_2_wins string
local Text = {
  title = "PONG",
  start_prompt = "Press Enter",
  pause_title = "PAUSED",
  pause_prompt = "Press Space",
  game_over_default = "Game Over",
  game_over_prompt = "Press Enter",
  player_1_wins = "Player 1 wins!",
  player_2_wins = "Player 2 wins!",
}

return Text
