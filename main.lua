local Game = require 'game'

-- Setup game states
require 'BarrageState'
require 'InputState'
require 'MenuState'

-- game instance
local testGame = nil	-- main game object

-- basic LÖVE callbacks used on this game; add more as needed
function love.load()
   testGame = Game:new() -- initialize game
end

function love.update(dt)
   testGame:baseUpdate(dt)
end

function love.draw()
   testGame:baseDraw()
end

function love.keypressed(key, code)
   testGame:baseKeypressed(key, code)
end

function love.keyreleased(key, code)
   testGame:baseKeyreleased(key, code)
end

function love.mousepressed(x,y,button)
   testGame:baseMousepressed(x,y,button)
end

function love.mousereleased(x,y,button)
   testGame:baseMousereleased(x,y,button)
end

function love.focus(f)
   testGame:baseFocus(f)
end

function love.quit()
   testGame:baseQuit()
end
