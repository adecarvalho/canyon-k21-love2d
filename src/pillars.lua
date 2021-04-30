--
local Class = require("lib/class")
local Pillar = require("src/pillar")

local Pillars = Class {}

--constructeur
function Pillars:init(screenWidth, screenHeight, plane, score)
  --
  self.screenWidth = screenWidth
  self.screenHeight = screenHeight

  self.plane = plane
  self.score = score

  self.speed = 250

  self.pillar_up = Pillar(self.screenWidth, self.screenHeight, "UP")
  self.pillar_down = Pillar(self.screenWidth, self.screenHeight, "DOWN")

  self:newWave()
end
--
--
function Pillars:newWave()
  self:reset()
  self:action()
end
--
--
function Pillars:action()
  local x = math.random(0, 100)

  if x < 50 then
    self.pillar_up:move(self.speed)
  else
    self.pillar_down:move(self.speed)
  end
end
--
--
function Pillars:reset()
  self.pillar_up:reset()
  self.pillar_down:reset()
end
--
--
function Pillars:isCollideWidthPlane()
  --
  if self.plane:getState() ~= "LIVE" then
    return
  end
  --
  if self.pillar_up:collide(self.plane) or self.pillar_down:collide(self.plane) then
    --
    self:reset()
    self:action()
    return true
  end
  --
  return false
end
--
--
function Pillars:update(dt)
  --
  self.pillar_up:update(dt)
  self.pillar_down:update(dt)
  --
  if self.pillar_up:isTouchLeft() or self.pillar_down:isTouchLeft() then
    --
    self:reset()
    self:action()
    --
    if self.plane:getState() == "LIVE" then
      --
      theGame:getAssetManager():getSound("check"):play()

      self.score:incrementsPoints(1)
    end
  end
end
--
--
function Pillars:render()
  self.pillar_up:render()
  self.pillar_down:render()
end
--
return Pillars
