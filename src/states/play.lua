---@class PlayState: State
---@field state_manager StateManager
---@field ball Ball
---@field player_1 Player
---@field player_2 Player
---@field viewport_width number
---@field viewport_height number
---@field start fun(self: PlayState): nil
local PlayState = {}

local LEFT_PLAYER_UP_KEY = "d"
local LEFT_PLAYER_DOWN_KEY = "s"
local RIGHT_PLAYER_UP_KEY = "k"
local RIGHT_PLAYER_DOWN_KEY = "j"
local BALL_SPEED_MULTIPLIER = 1.03
local BALL_MIN_VERTICAL_SPEED = 10
local BALL_MAX_VERTICAL_SPEED = 150

---@param state_manager StateManager
---@param viewport_width number
---@param viewport_height number
---@param ball_size number
---@return PlayState
function PlayState.new(
  state_manager,
  viewport_width,
  viewport_height,
  ball_size
)
  local self = setmetatable({}, { __index = PlayState })

  local Settings = require("src.config.settings")

  self.state_manager = state_manager
  self.viewport_width = viewport_width
  self.viewport_height = viewport_height
  self.ball = require("src.entities.ball").new(ball_size)
  self.player_1 = require("src.entities.player").new(
    Settings.player_width,
    Settings.player_height,
    Settings.player_speed
  )
  self.player_2 = require("src.entities.player").new(
    Settings.player_width,
    Settings.player_height,
    Settings.player_speed
  )

  self.player_1:set_position(
    13,
    viewport_height / 2 - Settings.player_height / 2
  )
  self.player_2:set_position(
    viewport_width - 13 - Settings.player_width,
    viewport_height / 2 - Settings.player_height / 2
  )

  return self
end

---@return nil
function PlayState:enter() end

---@return nil
function PlayState:start()
  self.player_1:reset_score()
  self.player_2:reset_score()
  self.ball:reset(self.viewport_width, self.viewport_height)
end

---@param player Player
---@return nil
function PlayState:award_point_to(player)
  player.score = player.score + 1
  self.ball:reset(self.viewport_width, self.viewport_height)

  local Settings = require("src.config.settings")
  if player.score >= Settings.win_score then
    local game_over_state = self.state_manager.states.game_over
    ---@cast game_over_state GameOverState
    local winner = player == self.player_1 and "Player 1 wins!" or "Player 2 wins!"
    game_over_state:set_message(winner)
    self.state_manager:change("game_over")
  end
end

---@param player Player
---@return boolean
function PlayState:ball_hits_player(player)
  local ball_left = self.ball.x
  local ball_right = self.ball.x + self.ball.size
  local ball_top = self.ball.y
  local ball_bottom = self.ball.y + self.ball.size
  local player_left = player.x
  local player_right = player.x + player.width
  local player_top = player.y
  local player_bottom = player.y + player.height

  return ball_right >= player_left
    and ball_left <= player_right
    and ball_bottom >= player_top
    and ball_top <= player_bottom
end

---@param player Player
---@return nil
function PlayState:bounce_off_player(player)
  self.ball.dx = -self.ball.dx * BALL_SPEED_MULTIPLIER

  if self.ball.x < self.viewport_width / 2 then
    self.ball.x = player.x + player.width
  else
    self.ball.x = player.x - self.ball.size
  end

  if self.ball.dy < 0 then
    self.ball.dy = -math.random(BALL_MIN_VERTICAL_SPEED, BALL_MAX_VERTICAL_SPEED)
  else
    self.ball.dy = math.random(BALL_MIN_VERTICAL_SPEED, BALL_MAX_VERTICAL_SPEED)
  end
end

---@param dt number
---@return nil
function PlayState:update(dt)
  local max_y = self.viewport_height - self.player_1.height

  if love.keyboard.isDown(LEFT_PLAYER_UP_KEY) then
    self.player_1:move_up(dt, 0)
  elseif love.keyboard.isDown(LEFT_PLAYER_DOWN_KEY) then
    self.player_1:move_down(dt, max_y)
  end

  if love.keyboard.isDown(RIGHT_PLAYER_UP_KEY) then
    self.player_2:move_up(dt, 0)
  elseif love.keyboard.isDown(RIGHT_PLAYER_DOWN_KEY) then
    self.player_2:move_down(dt, max_y)
  end

  self.ball:update(dt)

  if self.ball.y <= 0 then
    self.ball.y = 0
    self.ball.dy = -self.ball.dy
  elseif self.ball.y >= self.viewport_height - self.ball.size then
    self.ball.y = self.viewport_height - self.ball.size
    self.ball.dy = -self.ball.dy
  end

  if self:ball_hits_player(self.player_1) and self.ball.dx < 0 then
    self:bounce_off_player(self.player_1)
  elseif self:ball_hits_player(self.player_2) and self.ball.dx > 0 then
    self:bounce_off_player(self.player_2)
  end

  if self.ball.x + self.ball.size < 0 then
    self:award_point_to(self.player_2)
  elseif self.ball.x > self.viewport_width then
    self:award_point_to(self.player_1)
  end
end

---@return nil
function PlayState:draw()
  love.graphics.print(tostring(self.player_1.score), self.viewport_width / 4, 20)
  love.graphics.print(
    tostring(self.player_2.score),
    self.viewport_width * 3 / 4,
    20
  )
  self.ball:draw()
  self.player_1:draw()
  self.player_2:draw()
end

---@param key string
---@return nil
function PlayState:keypressed(key)
  if key == "space" then
    self.state_manager:change("pause")
  end
end

return PlayState
