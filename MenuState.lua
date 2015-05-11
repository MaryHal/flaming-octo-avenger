local Game = require 'game'
local MenuState = Game:addState('MenuState')
local Menu = require 'menu'

function MenuState:enteredState()
   self.font = love.graphics.newFont('assets/font/DroidSansFallback.ttf', 14)

   local mainMenuTable = {
      { tag = 'BarrageState', func = function() self:pushState('BarrageState') end },
      { tag = 'Set Keys',     func = function() self:pushState('InputState') end },
      { tag = 'Three',        func = function() print('Three') end },
      { tag = 'Four',         func = function() print('Four') end },
      { tag = 'Five',         func = function() print('Five') end },
      { tag = 'Exit',         func = function() self:exit() end }
   }
   self.mainMenu = Menu:new(self.font, mainMenuTable, 8, 3)
end

function MenuState:exitedState()
   love.graphics.setBackgroundColor(0, 0, 0, 255)
end

function MenuState:update(dt)
end

function MenuState:draw()
   self.mainMenu:draw(10, 10)
end

function MenuState:keyPressed(key, unicode)
   self.mainMenu:keyPressed(key, unicode)
end

function MenuState:keyReleased(key, unicode)
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
