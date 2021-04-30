--
local Class = require("lib/class")
local Entity = require("lib/entity")
local Label = require("lib/label")
local ParticuleGenerator = require("lib/particuleGenerator")

local Animation = require("lib/animation")

local Plane = Class {__includes = Entity}

--constructor
function Plane:init(screenWidth, screenHeight)
    --
    Entity.init(self, 0, 0, theGame:getAssetManager():getImage("plane"))

    self.screenWidth = screenWidth
    self.screenHeight = screenHeight

    self.gravity = 10
    self.positionInit = {x = self.screenWidth / 3, y = self.screenHeight / 2}
    self:setCenterX(self.positionInit.x)
    self:setCenterY(self.positionInit.y)

    self:inflate(5, 5)
    self:setState("IDLE") -- LIVE or TOUCHED

    self.label = Label("Press Space ...", theGame:getAssetManager():getFont("large"))
    self.label:setColor(0.9, 0.1, 0.9)

    self.flying = Animation(theGame:getAssetManager():getImage("flying"), 90, 75, 1 / 20, true)
    self.flying:play()

    self.explosion = Animation(theGame:getAssetManager():getImage("explosion"), 102, 102, 1 / 30, false)

    self.gaz = ParticuleGenerator(self.position.x, self.position.y, 50, 100, 2.5, 3.5)
    self.gaz:start()
end
--
--
function Plane:reset()
    --
    self:setCenterX(self.positionInit.x)
    self:setCenterY(self.positionInit.y)
    self:setState("IDLE")
    self:setVelocityXY(0, 0)
end
--
--
function Plane:touched()
    if self:getState() == "LIVE" then
        --
        self:setState("TOUCHED")
        self.explosion:play()
    end
end
--
--
function Plane:update(dt)
    --
    Entity.update(self, dt)
    --
    self.gaz:move(self:getPositionX(), self:getPositionY() + 20)
    self.gaz:update(dt)
    --
    self.flying:update(dt)
    --
    self.explosion:update(dt)
    --
    if self:getState() == "TOUCHED" and self.explosion:isPlaying() == false then
        self:reset()
    end
    --
    if self:getState() == "LIVE" then
        self.velocity.y = self.velocity.y + self.gravity * dt
        self.position.y = self.position.y + self.velocity.y
    end

    if theGame:getInputManager():isKeyPressed("space") then
        --
        if self:getState() == "IDLE" then
            self:setState("LIVE")
        end
        --
        self:setVelocityY(-self.gravity / 2)
    end

    -- limites
    if self:getBottom() > self.screenHeight then
        --
        self:setBottom(self.screenHeight)
    end
    --
    if self:getTop() < 0 then
        --
        self:setTop(0)
    end
end
--
--
function Plane:render()
    --
    if self:getState() == "LIVE" or self:getState() == "IDLE" then
        -- gaz
        self.gaz:render()

        self.flying:render(self:getPositionXY())
    end
    --
    if self:getState() == "IDLE" then
        self.label:render(self.screenWidth / 2, self.screenHeight / 2)
    end
    --
    if self:getState() == "TOUCHED" then
        self.explosion:render(self:getPositionXY())
    --
    end
    -- debug
    --Entity.renderDebug(self)
end
--
return Plane
