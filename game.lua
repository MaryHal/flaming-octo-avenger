local class = require 'lib/middleclass'
local stateful = require 'lib/stateful'

local Game = class('Game'):include(stateful)

local debug_ = true
local fps_ = 0
-- local paused_ = false
-- local screenwidth, screenheight = 1280,720

--------------------------------------------------------------------------------
-- don't change this, put your code into the baseXXX functions !!!!
-- Also include "default safe" methods for the callbacks
-- This way we don't have to define "mousepressed" on the states that don't need it
--------------------------------------------------------------------------------
function Game:update(dt)
end
function Game:draw()
end
function Game:keyPressed(key,unicode)
end
function Game:keyReleased(key,unicode)
end
function Game:mousePressed(x, y, button)
end
function Game:mouseReleased(x, y, button)
end
function Game:focus()
end
function Game:quit()
end

--------------------------------------------------------------------------------
-- main functions
--------------------------------------------------------------------------------
function Game:initialize()
   love.graphics.setDefaultFilter('nearest', 'nearest')

   -- self:gotoState('BarrageState')
   self:gotoState('MenuState')
end

function Game:baseUpdate(dt)
   fps_ = love.timer.getFPS()

   -- call standard
   self:update(dt)
end

function Game:baseDraw()
   -- draw game
   self:draw()
end

-- by default, exit when pressing 'escape'
function Game:baseKeypressed(key, code)
   self:log('Game:baseKeypressed', key)

   if key == 'escape' then
      self:exit()
   elseif key == 'f12' then
      self:gotoState('MenuState')
   end

   -- call standard
   self:keyPressed(key, unicode)
end

function Game:baseKeyreleased(key, code)
   -- call standard
   self:keyReleased(key, unicode)
end

function Game:baseMousepressed(x, y, button)
   -- call standard
   self:mousePressed(x, y, button)
end

function Game:baseMousereleased(x, y, button)
   -- call standard
   self:mouseReleased(x, y, button)
end

function Game:baseFocus(f)
   -- call standard
   self:focus()
end

function Game:baseQuit()
   -- call standard
   self:quit()
end

--------------------------------------------------------------------------------
-- Include the methods available in all states here
--------------------------------------------------------------------------------

-- -- Screen Options
-- function Game:GetScreenwidth()
--    return screenwidth
-- end

-- function Game:GetScreenheight()
--    return screenheight
-- end

-- Prints output in the console
function Game:log(...)
   if debug_ then
      print(...)
   end
end

function Game:exit()
   self:log("Goodbye!")
   love.event.push('quit')
end

return Game
