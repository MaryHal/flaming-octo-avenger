local Game = require 'game'
local LoadingState = Game:addState('LoadingState')

local loader = require 'lib/love-loader'

local finishedLoading = false

function LoadingState:enteredState()
   loader.newImage(self.images, 'bullet01', 'assets/images/bullet01.png')
   loader.newImage(self.images, 'bullet02', 'assets/images/bullet02.png')
   loader.newImage(self.images, 'bullet03', 'assets/images/bullet03.png')
   loader.newFont(self.fonts, 'dsf11', 'assets/font/DroidSansFallback.ttf', 11)
   loader.newFont(self.fonts, 'dsf14', 'assets/font/DroidSansFallback.ttf', 14)

   loader.start(
      -- Callback for when everything is done loading.
      function ()
         finishedLoading = true
      end

      -- -- Callback for when a single resource is done loading.
      -- function ()
      --    print (loader.loadedCount .. '/' .. loader.resourceCount)
      -- end
   )
end

function LoadingState:exitedState()
end

function LoadingState:update(dt)
   if not finishedLoading then
      loader.update()
   else
      self:gotoState('MenuState')
   end
end

function LoadingState:draw()
   -- Loading bar
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.rectangle('line', 100, 234, 440, 10)
   love.graphics.rectangle('fill', 100, 234, 440 * loader.loadedCount / loader.resourceCount , 10)
end

function LoadingState:keyPressed(key, unicode)
end

function LoadingState:keyReleased(key, unicode)
end

function LoadingState:mousePressed(x, y, button)
end

function LoadingState:mouseReleased(x, y, button)
end

function LoadingState:focus()
end

function LoadingState:quit()
end

return LoadingState
