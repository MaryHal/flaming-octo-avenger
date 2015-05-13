local theta = 0

local test13
test13 = {
   main = function()
      launch(1, theta, 7, vanish)
      launch(2, -theta, 7, vanish)
      theta = theta + 7
   end
}

return test13
