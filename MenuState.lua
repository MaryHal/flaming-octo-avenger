local Game = require 'game'
local MenuState = Game:addState('MenuState')
local Menu = require 'menu'

local mainMenuTable = {
   { tag = 'One',    func = function() print('One')   end },
   { tag = 'Two',    func = function() print('Two')   end },
   { tag = 'Three',  func = function() print('Three') end },
   { tag = 'Four',   func = function() print('Four')  end },
   { tag = 'Five',   func = function() print('Five')  end }
}
local mainMenu = Menu:new(love.graphics.newFont(12), mainMenuTable)

function MenuState:update(dt)
end

function MenuState:draw()
   mainMenu:draw(10, 10)
end

function MenuState:keyPressed(key,unicode)
   mainMenu:keyPressed(key, unicode)
end

function MenuState:keyReleased(key,unicode)
end

function MenuState:mousePressed(x, y, button)
end

function MenuState:mouseReleased(x, y, button)
end

function MenuState:focus()
end

function MenuState:quit()
end

return MenuState
