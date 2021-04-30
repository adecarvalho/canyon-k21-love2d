--
local Class = require("lib/class")
local Entity = require("lib/entity")

local Pillar = Class {__includes = Entity}

--constructeur
function Pillar:init(screenWidth, screenHeight, type)
  self.screenWidth = screenWidth
  self.screenHeight = screenHeight
  self.touchLeft = false

  if type == "UP" then
    Entity.init(self, 0, 0, theGame:getAssetManager():getImage("pillar_up"))
  end

  if type == "DOWN" then
    Entity.init(self, 0, 0, theGame:getAssetManager():getImage("pillar_down"))

    self:setBottom(self.screenHeight)
  end
  --
  self:setLeft(self.screenWidth)
  self:inflate(30, 20)
end
--
--
function Pillar:reset()
  --
  self.touchLeft = false
  self:setVelocityX(0)
  self:setLeft(self.screenWidth)
end
--
--
function Pillar:move(speed)
  self:setVelocityX(-speed)
end
--
--
function Pillar:isTouchLeft()
  return self.touchLeft
end
--
--
function Pillar:update(dt)
  Entity.update(self, dt)
  --
  if self:getRight() <= 0 then
    self.touchLeft = true
  end
end
--
--
function Pillar:render()
  Entity.render(self)
  --Entity.renderDebug(self)
end
--
return Pillar
