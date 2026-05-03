local Ball = require("src.entities.ball")
local Collision = require("src.systems.collision")
local Input = require("src.systems.input")
local Player = require("src.entities.player")
local Scoring = require("src.systems.scoring")

---@class Match
---@field context GameContext
---@field win_score number
---@field ball Ball
---@field player_1 Player
---@field player_2 Player
---@field gameplay GameplayConfig
local Match = {}

---@param context GameContext
---@return Match
function Match.new(context)
  local self = setmetatable({}, { __index = Match })
  self.context = context
  self.win_score = context.gameplay.win_score
  self.ball = Ball.new(context.gameplay.ball_size)
  self.player_1 = Player.new(
    context.gameplay.player_width,
    context.gameplay.player_height,
    context.gameplay.player_speed
  )
  self.player_2 = Player.new(
    context.gameplay.player_width,
    context.gameplay.player_height,
    context.gameplay.player_speed
  )
  self.gameplay = context.gameplay
  self:position_players()
  return self
end

---@return nil
function Match:position_players()
  self.player_1:set_position(
    self.gameplay.paddle_padding,
    self.context.viewport_height / 2 - self.gameplay.player_height / 2
  )
  self.player_2:set_position(
    self.context.viewport_width
      - self.gameplay.paddle_padding
      - self.gameplay.player_width,
    self.context.viewport_height / 2 - self.gameplay.player_height / 2
  )
end

---@return nil
function Match:reset_round()
  self.ball:reset(self.context.viewport_width, self.context.viewport_height)
end

---@return nil
function Match:reset_match()
  self.player_1:reset_score()
  self.player_2:reset_score()
  self:position_players()
  self:reset_round()
end

---@param player Player
---@return nil
function Match:bounce_off_player(player)
  self.ball.dx = -self.ball.dx * self.gameplay.ball_speed_multiplier

  if self.ball.x < self.context.viewport_width / 2 then
    self.ball.x = player.x + player.width
  else
    self.ball.x = player.x - self.ball.size
  end

  if self.ball.dy < 0 then
    self.ball.dy = -math.random(
      self.gameplay.ball_min_vertical_speed,
      self.gameplay.ball_max_vertical_speed
    )
  else
    self.ball.dy = math.random(
      self.gameplay.ball_min_vertical_speed,
      self.gameplay.ball_max_vertical_speed
    )
  end
end

---@param dt number
---@return string|nil
function Match:update(dt)
  Input.update_players(
    self.player_1,
    self.player_2,
    dt,
    self.context.viewport_height
  )
  self.ball:update(dt)

  if Collision.ball_hits_top(self.ball) then
    self.ball.y = 0
    self.ball.dy = -self.ball.dy
  elseif Collision.ball_hits_bottom(self.ball, self.context.viewport_height) then
    self.ball.y = self.context.viewport_height - self.ball.size
    self.ball.dy = -self.ball.dy
  end

  if
    Collision.ball_hits_player(self.ball, self.player_1) and self.ball.dx < 0
  then
    self:bounce_off_player(self.player_1)
  elseif
    Collision.ball_hits_player(self.ball, self.player_2) and self.ball.dx > 0
  then
    self:bounce_off_player(self.player_2)
  end

  if Collision.ball_out_left(self.ball, self.context.viewport_width) then
    Scoring.add_point(self.player_2)
    self:reset_round()

    if Scoring.has_winner(self.player_2, self.win_score) then
      return Scoring.winner_message(
        self.player_1,
        self.player_2,
        self.player_2,
        self.context.text
      )
    end
  elseif Collision.ball_out_right(self.ball, self.context.viewport_width) then
    Scoring.add_point(self.player_1)
    self:reset_round()

    if Scoring.has_winner(self.player_1, self.win_score) then
      return Scoring.winner_message(
        self.player_1,
        self.player_2,
        self.player_1,
        self.context.text
      )
    end
  end

  return nil
end

---@return nil
function Match:draw()
  love.graphics.print(
    tostring(self.player_1.score),
    self.context.viewport_width / 4,
    20
  )
  love.graphics.print(
    tostring(self.player_2.score),
    self.context.viewport_width * 3 / 4,
    20
  )
  self.ball:draw()
  self.player_1:draw()
  self.player_2:draw()
end

return Match
