local class = require 'lib/middleclass'
local Menu = class('Menu')

function Menu:initialize(font, menuTable, borderMargin, itemSpacing)
   self.font = font

   self.menuTable = menuTable
   self.menuIndex = 1

   self.metrics = {
      width = 0,
      height = 0,
      margin  = borderMargin == nil and 6 or borderMargin,
      spacing = itemSpacing == nil  and 4 or itemSpacing
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

-- Searches the menu table for a tag pair. Returns nil if there's no matching tag.
-- `matchFunction` argument allows you to set a function (that takes two arguments)
-- to test for equality between tags. For example, you can test for substrings with
-- string.find, or test with lua patterns with string.match. If `matchFunction` is nil,
-- string equality is used.
function Menu:getMenuItem(matchString, matchFunction)
   -- Setup a string equality function that acts similarly to string.find and string.match. When
   -- find/match fails, it returns nil, so this function must do the same.
   if matchFunction == nil then
      matchFunction = function (s1, s2)
         return s1 == s2 and true or nil
      end
   end

   for i, v in ipairs(self.menuTable) do
      if (matchFunction(self.menuTable[i].tag, matchString) ~= nil) then
         return v
      end
   end

   return nil
end

-- Rename a menu item's tag. Tag matching is done via getMenuItem above.
function Menu:retag(newTagName, matchString, matchFunction)
   local tagPair = self:getMenuItem(matchString, matchFunction)
   if tagPair ~= nil then
      tagPair.tag = newTagName

      -- Calculate the new width of the menu.
      self.metrics.width = math.max(self.metrics.width, self.font:getWidth(tagPair.tag))
   end
end

function Menu:keyPressed(key, unicode)
   if key == ' ' or key == 'return' then
      local menuItem = self.menuTable[self.menuIndex]
      menuItem.func()
      return menuItem.tag
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
   local bgWidth  = self.metrics.width + 2 * self.metrics.margin
   local bgHeight = self.metrics.height + (#self.menuTable - 1) * self.metrics.spacing + 2 * self.metrics.margin

   love.graphics.setColor(0, 0, 0, 128)
   love.graphics.rectangle('fill', x, y, bgWidth, bgHeight)

   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.rectangle('line', x, y, bgWidth, bgHeight)

   x = x + self.metrics.margin
   y = y + self.metrics.margin

   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.setFont(self.font)

   for i, v in ipairs(self.menuTable) do
      if i == self.menuIndex then
         love.graphics.setColor(255, 255, 0, 255)
      else
         love.graphics.setColor(255, 255, 255, 255)
      end
      love.graphics.print(v.tag, x, y)
      y = y + self.font:getHeight() + self.metrics.spacing
   end
end

return Menu
