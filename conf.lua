---@class LoveWindowSettings
---@field title string
---@field icon string|nil
---@field width number
---@field height number
---@field fullscreen boolean|nil
---@field resizable boolean|nil
---@field vsync boolean|integer|nil
---@field borderless boolean|nil
---@field highdpi boolean|nil
---@field msaa number|nil

---@class LoveModuleSettings
---@field audio boolean
---@field data boolean
---@field event boolean
---@field font boolean
---@field graphics boolean
---@field image boolean
---@field joystick boolean
---@field keyboard boolean
---@field filesystem boolean
---@field math boolean
---@field mouse boolean
---@field physics boolean
---@field sound boolean
---@field system boolean
---@field thread boolean
---@field timer boolean
---@field touch boolean
---@field video boolean
---@field window boolean

---@class LoveConfig
---@field version string
---@field window LoveWindowSettings
---@field modules LoveModuleSettings

---@param t LoveConfig
---@return nil
function love.conf(t)
  t.version = "11.5"

  t.window.title = "Pong"
  t.window.icon = nil
  t.window.width = 1280
  t.window.height = 720

  t.modules.audio = true
  t.modules.data = true
  t.modules.event = true
  t.modules.font = true
  t.modules.graphics = true
  t.modules.image = true
  t.modules.joystick = true
  t.modules.keyboard = true
  t.modules.math = true
  t.modules.mouse = true
  t.modules.physics = true
  t.modules.sound = true
  t.modules.system = true
  t.modules.thread = true
  t.modules.timer = true
  t.modules.touch = true
  t.modules.video = true
  t.modules.window = true
end
