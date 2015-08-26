local test14 = {}

function test14.delayedVanish()
   if (getFrameCount() == 40) then
      vanish()
   end
end

function test14.subBurst()
   if (getFrameCount() == 20) then
      launchCircle(DEFAULT_MODEL, 15, 4, test14.delayedVanish)
      kill()
   end
end

function test14.main()
   local frame = getFrameCount()

   setPosition(320, 200)
   if (math.fmod(frame, 60) == 0) then
      launchCircle(DEFAULT_MODEL, 30, 3, test14.subBurst)
   end
end

return test14
