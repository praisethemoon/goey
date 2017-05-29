local class = require 'class'
local Timer = class 'Timer'

function Timer:initialize(duration, func)
  -- Overall timer duration
  self.duration = duration
  
  -- elapsed time
  self.currentTicker = 0
  
  -- is timer active? Can be paused/resumed
  self.active= false
  
  -- On finish function (optional)
  self.onFinish = func or false
  
  -- Has the timer ended already
  self.done = true
end

function Timer:start()
  assert(self.done)
  self.active = true
  self.done = false
end

function Timer:update(dt)
  if not self.active then return end
  self.currentTicker = self.currentTicker + dt*1000
  if self.currentTicker >= self.duration then
    self.active = false
    self.done = true
    if self.onFinish then
      self.onFinish()
    end
  end
end

function Timer:pause()
  assert(not self.done)
  self.active = false
end

function Timer:resume()
  assert(not self.done)
  self.active = true
end

return Timer