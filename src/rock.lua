--
local Class = require("lib/class")
local Entity = require("lib/entity")

local Rock = Class {__includes = Entity}

--constructor
function Rock:init(screenWidth, screenHeight, type)
  --
  self.screenWidth = screenWidth
  self.screenHeight = screenHeight
  self.speed = -250
  --
  if type == "UP" then
    --
    Entity.init(self, 0, 0, theGame:getAssetManager():getImage("rock_up"))
  else
    Entity.init(self, 0, 0, theGame:getAssetManager():getImage("rock_down"))

    self:setBottom(self.screenHeight)
  end
  --
  self:inflate(0, 10)
  self.type = type
  self:setVelocityX(self.speed)
end
--
--
function Rock:update(dt)
  --
  Entity.update(self, dt)
  --
  if self:getRight() < self.screenWidth then
    self:setLeft(0)
  end
end
--
--
function Rock:render()
  --
  Entity.render(self)

  --Entity.renderDebug(self)
end
--
return Rock
