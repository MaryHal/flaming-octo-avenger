local barrage = require 'barrageC'

local Game = require 'game'
local BarrageState = Game:addState('BarrageState')

local viewCollisionBoxes = false
local frameAdvanceMode = false
local advanceFrame = false
local hitThisFrame = false

local barrageIndex = 1
local barrageFileList = love.filesystem.getDirectoryItems('barrage')

function BarrageState:enteredState()
   self.font = self.fonts.dsf11

   self.myBarrage = barrage.newBarrage()
   self.sp = barrage.newSpacialPartition()

   self.px = 0
   self.py = 0

   self.barrageBatch = love.graphics.newSpriteBatch(self.images.bullet03, 1024)
   self.bulletQuads = {
      love.graphics.newQuad(0,  0, 32, 31, self.images.bullet03:getDimensions()),
      love.graphics.newQuad(32, 0, 32, 31, self.images.bullet03:getDimensions())
   }
   self.drawFunctions = {
      -- Static orientation
      function (x, y, vx, vy)
         self.barrageBatch:add(self.bulletQuads[1], x, y, 0, 0.5, 0.5, 16, 16)
      end,

      -- Directed bullets
      function (x, y, vx, vy)
         self.barrageBatch:add(self.bulletQuads[2], x, y, math.pi - math.atan2(vx, vy), 0.5, 0.5, 16, 16)
      end
   }
   self.sp:addModel(10, 10)

   love.mouse.setVisible(false)
end

function BarrageState:exitedState()
   self.font = nil

   self.myBarrage = nil
   self.sp = nil

   self.px = nil
   self.py = nil

   self.barrageBatch = nil
   self.bulletQuads = nil
   self.drawFunctions = nil

   love.mouse.setVisible(true)
end

function BarrageState:update(dt)
   self.px, self.py = love.mouse.getPosition()
   self.myBarrage:setPlayerPosition(self.px, self.py)

   if not frameAdvanceMode or advanceFrame then
      self.myBarrage:tick(self.sp, dt)
      advanceFrame = false
   end

   hitThisFrame = false
   if (self.sp:checkCollision(self.px, self.py, 4, 4)) then
      hitThisFrame = true
   end

   self.barrageBatch:clear()
   self.barrageBatch:bind()
   do
      self.myBarrage:resetHasNext()

      while self.myBarrage:hasNext() do
         local x, y, vx, vy, alpha, model = self.myBarrage:yield()

         self.barrageBatch:setColor(255, 255, 255, 255 * alpha)
         self.drawFunctions[model](x, y, vx, vy)
      end
   end
   self.barrageBatch:unbind()
end

function BarrageState:draw()
   love.graphics.draw(self.barrageBatch)

   if viewCollisionBoxes then
      love.graphics.setColor(0, 0, 255, 128)
      self.myBarrage:resetHasNext()

      while self.myBarrage:hasNext() do
         local x, y, vx, vy, alpha, model = self.myBarrage:yield()

         -- Adjust (x, y) so it is the corner of the hitbox.
         modelWidth, modelHeight = self.sp:getModel(model)
         x = x - modelWidth / 2
         y = y - modelHeight / 2
         if alpha == 1.0 then
            love.graphics.rectangle('fill', x, y, modelWidth, modelHeight)
         end
      end
   end

   love.graphics.setColor(0, 255, 255, 255)
   love.graphics.rectangle('fill', self.px - 2, self.py - 2, 4, 4)

   love.graphics.setFont(self.font)
   love.graphics.setColor(255, 255, 255)
   love.graphics.print(barrageFileList[barrageIndex] .. " (" .. self.myBarrage:getActiveCount() .. ")", 8, 8)
   love.graphics.print("FPS: " .. love.timer.getFPS(), 594, 8)
   love.graphics.print("Use Left/Right to switch files.\nPress Space to Launch.\n.", 8, 480 - 34)

   if advanceFrame then
      love.graphics.setColor(255, 255, 0, 255)
   else
      love.graphics.setColor(255, 255, 255, 255)
   end
   love.graphics.print("Advance Frame (o)", 514, 480 - 48)

   if frameAdvanceMode then
      love.graphics.setColor(255, 255, 0, 255)
   else
      love.graphics.setColor(255, 255, 255, 255)
   end
   love.graphics.print("Pause (P)", 514, 480 - 34)

   if viewCollisionBoxes then
      love.graphics.setColor(255, 255, 0, 255)
   else
      love.graphics.setColor(255, 255, 255, 255)
   end
   love.graphics.print("View Collision Boxes (C)", 514, 480 - 20)

   -- Display some text if you got hit.
   love.graphics.setColor(255, 255, 255, 255)
   if hitThisFrame then
      love.graphics.print("Hit!", 8, 22)
   end
end

function BarrageState:keyPressed(key, unicode)
   if key == ' ' or key == 'return' then
      self.myBarrage:vanishAll()
      self.myBarrage:launchFile('barrage/' .. barrageFileList[barrageIndex], 320.0, 120.0)
   elseif key == 'a' then
      barrageIndex = barrageIndex - 1
      if barrageIndex < 1 then
         barrageIndex = #barrageFileList
      end
   elseif  key == 'd' then
      barrageIndex = barrageIndex + 1
      if barrageIndex > #barrageFileList then
         barrageIndex = 1
      end
   elseif key == 'v' then
      self.myBarrage:vanishAll()
   elseif key == 'c' then
      viewCollisionBoxes = not viewCollisionBoxes
   elseif key == 'p' then
      frameAdvanceMode = not frameAdvanceMode
   elseif key == 'o' then
      frameAdvanceMode = true
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
