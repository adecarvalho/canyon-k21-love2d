--[[
  Projet Canyon
  A.DeCarvalho
]] --
--
-- local variables
local WINDOW_WIDTH = 800
local WINDOW_HEIGHT = 480

local game = require("lib/game")
local stageManager = require("lib/stageManager")

local introStage = require("src/intro_stage")
local playStage = require("src/play_stage")
local concluStage = require("src/conclu_stage")

-- global variables
theGame = game(WINDOW_WIDTH, WINDOW_HEIGHT, "Canyon-lua")

--
function love.load()
  theGame:begin()

  -- images
  theGame:getAssetManager():loadImage("paysage", "assets/images/paysage.png")
  theGame:getAssetManager():loadImage("flying", "assets/images/flying.png")

  theGame:getAssetManager():loadImage("explosion", "assets/images/explosion.png")
  theGame:getAssetManager():loadImage("rock_down", "assets/images/rock_down.png")
  theGame:getAssetManager():loadImage("rock_up", "assets/images/rock_up.png")
  theGame:getAssetManager():loadImage("pillar_up", "assets/images/pillar_haut.png")
  theGame:getAssetManager():loadImage("pillar_down", "assets/images/pillar_bas.png")
  theGame:getAssetManager():loadImage("plane", "assets/images/plane1.png")

  -- sounds
  theGame:getAssetManager():loadSound("boom", "assets/sounds/boom.ogg")
  theGame:getAssetManager():loadSound("check", "assets/sounds/check.wav")

  -- musics
  theGame:getAssetManager():loadMusic("plane", "assets/musics/plane.ogg")
  theGame:getAssetManager():loadMusic("menu", "assets/musics/underground.ogg")

  -- fonts
  theGame:getAssetManager():loadFont("large", "assets/fonts/free.ttf", 30)
  theGame:getAssetManager():loadFont("big", "assets/fonts/free.ttf", 60)
  --
  --
  theGame:loadStages(
    stageManager(
      {
        ["intro"] = function()
          return introStage(WINDOW_WIDTH, WINDOW_HEIGHT)
        end,
        ["play"] = function()
          return playStage(WINDOW_WIDTH, WINDOW_HEIGHT)
        end,
        ["conclu"] = function()
          return concluStage(WINDOW_WIDTH, WINDOW_HEIGHT)
        end
      }
    )
  )
  --
  theGame:getStageManager():changeStage("intro")

  print("end loading")
end
--
--
function love.keypressed(key)
  theGame:getInputManager():setKeyPressed(key)
  --
  if key == "escape" then
    print("quit prog")
    theGame:exit()
  end
end
--
--
function love.keyreleased(key)
  theGame:getInputManager():setKeyReleased(key)
end
--
--
function love.update(dt)
  theGame:update(dt)
end
--
--
function love.draw()
  theGame:render()
end
