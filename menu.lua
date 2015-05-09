local class = require 'lib/middleclass'


local Menu = class('Menu')

function Menu:initialize(font, menuTable)
   self.font = font

   self.menuTable = menuTable
   self.menuIndex = 1

   self.metrics = {
      width = 0,
      height = 0,
      margin = 6
   }

   self:calculateMetrics()
end

function Menu:calculateMetrics()
   self.metrics.width = 0
   for i, v in ipairs(self.menuTable) do
      local currentTag = self.menuTable[i].tag
      self.metrics.width = math.max(self.metrics.width, self.font:getWidth(currentTag))
      self.metrics.height = self.metrics.height + self.font:getHeight()
   end
end

function Menu:keyPressed(key, unicode)
   if key == ' ' or key == 'return' then
      self.menuTable[self.menuIndex].func()
   elseif key == 'up' or key == 'w' then
      self.menuIndex = self.menuIndex - 1
      if self.menuIndex < 1 then
         self.menuIndex = #self.menuTable
      end
   elseif key == 'down' or key == 's' then
      self.menuIndex = self.menuIndex + 1
      if self.menuIndex > #self.menuTable then
         self.menuIndex = 1
      end
   end
end

function Menu:draw(x, y)
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.rectangle('line', x, y,
                           self.metrics.width + 2 * self.metrics.margin,
                           self.metrics.height + (#self.menuTable + 1) * self.metrics.margin)

   x = x + self.metrics.margin
   y = y + self.metrics.margin

   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.setFont(self.font)

   for i, v in ipairs(self.menuTable) do
      if i == self.menuIndex then
         love.graphics.setColor(255, 0, 255, 255)
      else
         love.graphics.setColor(255, 255, 255, 255)
      end
      love.graphics.print(v.tag, x, y)
      y = y + self.font:getHeight() + self.metrics.margin
   end
end

return Menu
