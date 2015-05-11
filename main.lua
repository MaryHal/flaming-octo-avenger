local Game = require 'game'

-- Setup game states
require 'LoadingState'
require 'BarrageState'
require 'InputState'
require 'MenuState'

-- game instance
local testGame = nil

-- Pass basic LÖVE callbacks to our game instance.
function love.load()
   testGame = Game:new()
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
