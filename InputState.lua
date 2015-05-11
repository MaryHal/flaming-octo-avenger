local Game = require 'game'
local InputState = Game:addState('InputState')
local Menu = require 'menu'

function InputState:enteredState()
   self.font = self.fonts.dsf14

   -- Are we going to set a key?
   self.settingState = false
   self.currentTag = nil

   local function enableSetState()
      self.settingState = true
      print (self.settingState)
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
end

function InputState:update(dt)
end

function InputState:draw()
   self.inputMenu:draw(100, 100)
end

function InputState:keyPressed(key, unicode)
   if self.settingState then
      -- Get key name and retag
      local thisKey = string.match(self.currentTag, '(.*):')
      self.inputMenu:retag(thisKey .. ': ' .. key, thisKey, string.match)
      self.settingState = false
   else
      self.currentTag = self.inputMenu:keyPressed(key, unicode)
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
