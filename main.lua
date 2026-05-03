---@type Game
local Game = require("src.core.game")

---@return nil
function love.load()
  Game:init()
end

---@param dt number
---@return nil
function love.update(dt)
  Game:update(dt)
end

---@return nil
function love.draw()
  Game:draw()
end

---@param key string
---@return nil
function love.keypressed(key)
  Game:keypressed(key)
end
