--
local Class = require("lib/class")
local Label = require("lib/label")

local IntroStage = Class {}
--
function IntroStage:init(screenWidth, screenHeight)
  self.screenWidth = screenWidth
  self.screenHeight = screenHeight

  self.backgroundImg = theGame:getAssetManager():getImage("paysage")

  self.chars = {[1] = 65, [2] = 65, [3] = 65}
  self.indice = 1
  self.timer = 0
  self.toggle = true

  self.premier = Label("A", theGame:getAssetManager():getFont("big"))
  self.premier:setColor(0.9, 0.1, 0.9)

  self.second = Label("A", theGame:getAssetManager():getFont("big"))
  self.second:setColor(0.9, 0.1, 0.9)

  self.troisieme = Label("A", theGame:getAssetManager():getFont("big"))
  self.troisieme:setColor(0.9, 0.1, 0.9)

  self.title = Label("Canyon", theGame:getAssetManager():getFont("big"))
  self.title:setColor(0.9, 0.1, 0.9)

  self.pseudo = Label("Pseudo", theGame:getAssetManager():getFont("large"))
  self.pseudo:setColor(0.9, 0.1, 0.9)

  self.commande = Label("Press Enter ...", theGame:getAssetManager():getFont("large"))
  self.commande:setColor(0.9, 0.1, 0.9)
end
--
--
function IntroStage:onEnter(datas)
  --
  theGame:getAssetManager():getMusic("menu"):setLooping(true)
  theGame:getAssetManager():getMusic("menu"):setVolume(0.3)
  theGame:getAssetManager():getMusic("menu"):play()
end
--
--
function IntroStage:onExit()
  theGame:getAssetManager():getMusic("menu"):setLooping(false)
  theGame:getAssetManager():getMusic("menu"):stop()
end
--
--
function IntroStage:update(dt)
  --
  self.timer = self.timer + dt

  if self.timer > 0.3 then
    --
    self.timer = 0
    if self.toggle then
      --
      self.toggle = false
    else
      self.toggle = true
    end
  end
  --
  --
  if theGame:getInputManager():isKeyPressed("left") and self.indice > 1 then
    --
    self.indice = self.indice - 1
  elseif theGame:getInputManager():isKeyPressed("right") and self.indice < 3 then
    self.indice = self.indice + 1
  end
  --
  if theGame:getInputManager():isKeyPressed("up") then
    --
    self.chars[self.indice] = self.chars[self.indice] + 1
    if self.chars[self.indice] > 90 then
      --
      self.chars[self.indice] = 65
    end
  else
    if theGame:getInputManager():isKeyPressed("down") then
      --
      self.chars[self.indice] = self.chars[self.indice] - 1
      if self.chars[self.indice] < 65 then
        --
        self.chars[self.indice] = 90
      end
    end
  end
  --
  if theGame:getInputManager():isKeyPressed("enter") or theGame:getInputManager():isKeyPressed("return") then
    --
    local playerName = string.char(self.chars[1]) .. string.char(self.chars[2]) .. string.char(self.chars[3])

    local datas = {name = playerName}
    --
    theGame:getStageManager():changeStage("play", datas)
  end
  --
end
--
--
function IntroStage:render()
  local xp = 0
  local yp = self.screenHeight / 4
  local xd = self.screenWidth / 4
  --
  love.graphics.draw(self.backgroundImg, 0, 0)
  --pseudo
  --indice 1
  if self.indice == 1 then
    --
    if self.toggle then
      self.premier:setText(string.char(self.chars[1]))
      self.premier:render(xd, yp)
    end
    self.second:setText(string.char(self.chars[2]))
    self.second:render(xd + 50, yp)

    self.troisieme:setText(string.char(self.chars[3]))
    self.troisieme:render(xd + 100, yp)
  end
  --indice 2
  if self.indice == 2 then
    --
    if self.toggle then
      self.second:setText(string.char(self.chars[2]))
      self.second:render(xd + 50, yp)
    end
    --
    self.premier:setText(string.char(self.chars[1]))
    self.premier:render(xd, yp)
    --
    self.troisieme:setText(string.char(self.chars[3]))
    self.troisieme:render(xd + 100, yp)
  end
  --indice 3
  if self.indice == 3 then
    --
    if self.toggle then
      --
      self.troisieme:setText(string.char(self.chars[3]))
      self.troisieme:render(xd + 100, yp)
    end
    --
    self.premier:setText(string.char(self.chars[1]))
    self.premier:render(xd, yp)
    --
    self.second:setText(string.char(self.chars[2]))
    self.second:render(xd + 50, yp)
  end
  --
  self.title:render(self.screenWidth / 4, 20)

  self.pseudo:render(self.screenWidth / 4, self.screenHeight / 2)

  self.commande:render(self.screenWidth / 4, self.screenHeight - 100)
  --
end
--
return IntroStage
