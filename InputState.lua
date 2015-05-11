local Game = require 'game'
local InputState = Game:addState('InputState')
local Menu = require 'menu'

-- Are we going to set a key?
local settingState = false
local currentTag = nil

function InputState:enteredState()
   self.font = self.fonts.dsf14

   local function enableSetState()
      settingState = true
   end

   local inputKeyTable = {
      { tag = 'Left:',  func = enableSetState },
      { tag = 'Right:', func = enableSetState },
      { tag = 'Up:',    func = enableSetState },
      { tag = 'Down:',  func = enableSetState },
      { tag = 'Shoot:', func = enableSetState },
      { tag = 'Focus:', func = enableSetState }
   }

   self.inputMenu = Menu:new(self.font, inputKeyTable, 8, 3)
end

function InputState:exitedState()
   self.font = nil
   self.inputMenu = nil
end

function InputState:update(dt)
end

function InputState:draw()
   self.inputMenu:draw(100, 100)
end

function InputState:keyPressed(key, unicode)
   if settingState then
      -- Get key name and retag
      local thisKey = string.match(currentTag, '(.*):')
      self.inputMenu:retag(thisKey .. ': ' .. key, thisKey, string.match)
      settingState = false
   else
      currentTag = self.inputMenu:keyPressed(key, unicode)
   end
end

function InputState:keyReleased(key, unicode)
end

function InputState:mousePressed(x, y, button)
end

function InputState:mouseReleased(x, y, button)
end

function InputState:focus()
end

function InputState:quit()
end

return InputState
