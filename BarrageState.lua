local barrage = require 'barrageC'

local Game = require 'game'
local BarrageState = Game:addState('BarrageState')

local myBarrage = barrage.newBarrage()
local sp = barrage.newSpacialPartition()

local viewCollisionBoxes = false
local frameAdvanceMode = false
local advanceFrame = false
local hitThisFrame = false

local barrageIndex = 1
local barrageFileList = love.filesystem.getDirectoryItems('barrage')

function BarrageState:enteredState()
   self.font = self.fonts.dsf11
   self.barrageBatch = love.graphics.newSpriteBatch(self.images.bullet01, 1024)

   love.mouse.setVisible(false)
end

function BarrageState:exitedState()
   self.font = nil
   self.barrageBatch = nil

   love.mouse.setVisible(true)
end

function BarrageState:update(dt)
   local x, y = love.mouse.getPosition()
   myBarrage:setPlayerPosition(x, y)

   if not frameAdvanceMode or advanceFrame then
      myBarrage:tick(sp)
      advanceFrame = false
   end

   hitThisFrame = false
   if (sp:checkCollision(x, y, 4, 4)) then
      hitThisFrame = true
   end

   self.barrageBatch:clear()
   self.barrageBatch:bind()
   do
      myBarrage:resetHasNext()

      while myBarrage:hasNext() do
         local x, y, vx, vy, alpha = myBarrage:yield()

         self.barrageBatch:setColor(255, 255, 255, 255 * alpha)
         -- self.barrageBatch:add(x, y, math.pi - math.atan2(vx, vy), 0.5, 0.5, 16, 16)

         -- Static orientation
         self.barrageBatch:add(x, y, 0, 0.5, 0.5, 16, 16)
      end
   end
   self.barrageBatch:unbind()
end

function BarrageState:draw()
   love.graphics.draw(self.barrageBatch)

   if viewCollisionBoxes then
      love.graphics.setColor(0, 0, 255, 128)
      myBarrage:resetHasNext()

      while myBarrage:hasNext() do
         local x, y, vx, vy, alpha = myBarrage:yield()
         if alpha == 1.0 then
            love.graphics.rectangle('fill', x - 2, y - 2, 4, 4)
         end
      end
   end

   local x, y = love.mouse.getPosition()
   love.graphics.setColor(0, 255, 255, 255)
   love.graphics.rectangle('fill', x - 2, y - 2, 4, 4)

   love.graphics.setFont(self.font)
   love.graphics.setColor(255, 255, 255)
   love.graphics.print(barrageFileList[barrageIndex] .. " (" .. myBarrage:getActiveCount() .. ")", 8, 8)
   love.graphics.print("FPS: " .. love.timer.getFPS(), 594, 8)
   love.graphics.print("Use Left/Right to switch files.\nPress Space to Launch.\n.", 8, 480 - 34)
   love.graphics.print("Freeze (F)\nAdvance Frame (G)\nToggle Collision Boxes (C)", 500, 480 - 48)

   if hitThisFrame then
      love.graphics.print("Hit!", 8, 22)
   end
end

function BarrageState:keyPressed(key, unicode)
   if key == ' ' or key == 'return' then
      myBarrage:vanishAll()
      myBarrage:launchFile('barrage/' .. barrageFileList[barrageIndex], 320.0, 120.0)
   elseif key == 'left' or key == 'a' then
      barrageIndex = barrageIndex - 1
      if barrageIndex < 1 then
         barrageIndex = #barrageFileList
      end
   elseif key == 'right' or key == 'd' then
      barrageIndex = barrageIndex + 1
      if barrageIndex > #barrageFileList then
         barrageIndex = 1
      end
   elseif key == 'v' then
      myBarrage:vanishAll()
   elseif key == 'c' then
      viewCollisionBoxes = not viewCollisionBoxes
   elseif key == 'f' then
      frameAdvanceMode = not frameAdvanceMode
   elseif key == 'g' then
      advanceFrame = true
   end
end

function BarrageState:keyReleased(key, unicode)
end

function BarrageState:mousePressed(x, y, button)
end

function BarrageState:mouseReleased(x, y, button)
end

function BarrageState:focus()
   love.mouse.setVisible(false)
end

function BarrageState:quit()
   love.mouse.setVisible(true)
end

return BarrageState
