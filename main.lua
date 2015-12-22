local Game = require 'game'

-- Setup game states
require 'states/LoadingState'
require 'states/BarrageState'
require 'states/InputState'
require 'states/MenuState'
require 'states/TestState'

-- game instance
local testGame = nil

-- Pass basic LÖVE callbacks to our game instance.
function love.load(arg)
   testGame = Game:new()
end

function love.update(dt)
   testGame:baseUpdate(dt)
end

function love.draw()
   testGame:baseDraw()
end

function love.keypressed(key, code, isrepeat)
   testGame:baseKeypressed(key, code, isrepeat)
end

function love.keyreleased(key, code)
   testGame:baseKeyreleased(key, code)
end

function love.mousepressed(x, y, button)
   testGame:baseMousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
   testGame:baseMousereleased(x, y, button)
end

function love.focus(f)
   testGame:baseFocus(f)
end

function love.quit()
   testGame:baseQuit()
end
