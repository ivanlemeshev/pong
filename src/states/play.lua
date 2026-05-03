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
  self.ball:reset(self.viewport_width, self.viewport_height)
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
end

---@return nil
function PlayState:draw()
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
