--
local Class = require("lib/class")
local ScoreManager = require("lib/scoreManager")

local Paysage = require("src/paysage")
local Rock = require("src/rock")
local Pillars = require("src/pillars")

local Plane = require("src/plane")

local PlayStage = Class {}

--constructeur
function PlayStage:init(screenWidth, screenHeight)
  --
  self.screenWidth = screenWidth
  self.screenHeight = screenHeight
  self.score = ScoreManager(self.screenWidth, self.screenHeight)
  --
  self.paysage = Paysage(self.screenWidth, self.screenHeight)
  --
  self.rocks = {}
  table.insert(self.rocks, Rock(self.screenWidth, self.screenHeight, "UP"))
  table.insert(self.rocks, Rock(self.screenWidth, self.screenHeight, "DOWN"))
  --
  self.plane = Plane(self.screenWidth, self.screenHeight)
  --
  self.pillars = Pillars(self.screenWidth, self.screenHeight, self.plane, self.score)
end
--
--
function PlayStage:onEnter(datas)
  --
  theGame:getAssetManager():getMusic("plane"):setLooping(true)
  theGame:getAssetManager():getMusic("plane"):setVolume(0.2)
  theGame:getAssetManager():getMusic("plane"):play()

  if datas ~= nil then
    self.score:setName(datas.name)
  end
  --
  self.score:reset()
end
--
--
function PlayStage:onExit()
  --
  theGame:getAssetManager():getMusic("plane"):setLooping(false)
  theGame:getAssetManager():getMusic("plane"):stop()
end
--
--
function PlayStage:update(dt)
  --
  self.paysage:update(dt)
  -- rocks
  for k, rock in pairs(self.rocks) do
    rock:update(dt)
  end
  -- pillars
  self.pillars:update(dt)
  --
  self.plane:update(dt)
  --
  self:collisions()
  --
  self:isGameOver()
end
--
--
function PlayStage:isGameOver()
  --
  if self.score:isGameOver() then
    --
    local datas = {
      name = self.score:getName(),
      points = self.score:getPoints()
    }
    -- print('game over')
    theGame:getStageManager():changeStage("conclu", datas)
  end
end
--
--
function PlayStage:collisions()
  -- plane Pillars
  if self.pillars:isCollideWidthPlane() then
    self.plane:touched()
    --
    theGame:getAssetManager():getSound("boom"):stop()

    theGame:getAssetManager():getSound("boom"):setVolume(0.2)

    theGame:getAssetManager():getSound("boom"):play()

    self.score:decrementsLives()
  end

  -- plane rocks
  for k, rock in pairs(self.rocks) do
    --
    if self.plane:getState() == "LIVE" and self.plane:collide(rock) then
      --
      theGame:getAssetManager():getSound("boom"):stop()

      theGame:getAssetManager():getSound("boom"):setVolume(0.2)

      theGame:getAssetManager():getSound("boom"):play()

      self.plane:touched()
      self.pillars:newWave()
      self.score:decrementsLives()
    end
  end
end
--
--
function PlayStage:render()
  -- Paysage
  self.paysage:render()

  -- pillars
  self.pillars:render()

  -- rocks
  for k, rock in pairs(self.rocks) do
    rock:render()
  end
  -- plane
  self.plane:render()
  --
  self.score:render(0.2, 0.2, 0.2)
end
--
return PlayStage
