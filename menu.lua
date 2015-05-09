local class = require 'lib/middleclass'

local Menu = class('Menu')

function Menu:initialize()
   self.menuTable = {}
   self.menuIndex = 1
end

function Menu:keyPressed(key, unicode)
   if key == ' ' or key == 'return' then
      return self.menuTable[self.menuIndex]
   elseif key == 'up' or key == 'a' then
      self.menuIndex = self.menuIndex - 1
      if self.menuIndex < 1 then
         self.menuIndex = #self.menuTable
      end
   elseif key == 'down' or key == 'd' then
      self.menuIndex = self.menuIndex + 1
      if self.menuIndex > #self.menuTable then
         self.menuIndex = 1
      end
   end
end

function Menu:draw(x, y)
end
