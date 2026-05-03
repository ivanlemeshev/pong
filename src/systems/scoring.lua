---@class ScoringSystem
local Scoring = {}

---@param player Player
---@return nil
function Scoring.add_point(player)
  player.score = player.score + 1
end

---@param player Player
---@param win_score number
---@return boolean
function Scoring.has_winner(player, win_score)
  return player.score >= win_score
end

---@param player_1 Player
---@param player_2 Player
---@param player Player
---@param text TextConfig
---@return string
function Scoring.winner_message(player_1, player_2, player, text)
  return player == player_1 and text.player_1_wins or text.player_2_wins
end

return Scoring
