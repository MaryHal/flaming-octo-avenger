local Game = require 'game'
local TestState = Game:addState('TestState')

function TestState:enteredState()
end

function TestState:exitedState()
end

function TestState:update(dt)
end

function TestState:draw()
end

function TestState:keyPressed(key, unicode)
end

function TestState:keyReleased(key, unicode)
end

function TestState:mousePressed(x, y, button)
end

function TestState:mouseReleased(x, y, button)
end

function TestState:focus()
end

function TestState:quit()
end

return TestState
