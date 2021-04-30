--
local Class = require("lib/class")

local Paysage = Class {}

--constructeur
function Paysage:init(screenWidth, screenHeight)
  --
  self.screenWidth = screenWidth
  self.screenHeight = screenHeight
  --
  self.img = theGame:getAssetManager():getImage("paysage")
  self.position = {x = 0, y = 0}
  self.dx = -2
end
--
--
function Paysage:update(dt)
  self.position.x = self.position.x + self.dx

  if self.position.x <= -self.screenWidth then
    self.position.x = 0
  end
end
--
--
function Paysage:render(args)
  love.graphics.draw(self.img, self.position.x, self.position.y)
end
--
return Paysage
