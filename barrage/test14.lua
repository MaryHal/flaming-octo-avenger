local test14 = {}

function test14.main()
   frame = getFrameCount()
   rank = getRank()
   if (math.fmod(frame, math.floor(120 * (1.2 - rank))) == 0) then
      launchCircle(DEFAULT_MODEL, 40, 3)
   end
end

return test14
