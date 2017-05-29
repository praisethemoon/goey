local class = require 'class'
local Scene = require 'Scene'

local IntroScene = class('IntroScene', Scene)

function IntroScene:initialize()
  Scene.initialize(self, "IntroScene")

  self.logo = love.graphics.newImage("assets/igo-logo-s.png")

  self.timer = require 'engine.Timer':new(5000)

  self.font = love.graphics.newFont("assets/fonts/jk-go-l-1.00/JKG-L_3.ttf", 55)
  self.font2 = love.graphics.newFont('assets/fonts/exo/Exo-Light.otf', 32)
  
  self.logoDrawX = self.logo:getWidth() / 2 
  self.logoDrawY = self.logo:getHeight() / 2 + self.font:getHeight()/2 + 25

  self.logoDrawX2 = self.font:getWidth("OK GO") / 2
  self.logoDrawY2 = self.font:getHeight() / 2 - self.logo:getHeight()/2
end

function IntroScene:load()
  Scene.load(self)
  self.timer:start()
end

function IntroScene:close()
  Scene.close(self)
end

function IntroScene:update(dt)
  self.timer:update(dt)  
end

function IntroScene:render()
  --if self.timer.active then
    local midx, midy = love.graphics.getWidth()/2, love.graphics.getHeight()/2
    love.graphics.setBackgroundColor(240, 255, 240)

    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.logo, midx, midy, 0, 1, 1, self.logoDrawX, self.logoDrawY)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(self.font)
    love.graphics.print("OK GO", midx, midy, 0, 1, 1, self.logoDrawX2, self.logoDrawY2)
    
  --else
  --  love.graphics.print("By praisethemoon", 100, 100)
  --end  
end

function IntroScene:keyReleased(key, scanCode)
  if key == 'return' then
    print(getEngineInstance())
  end
end

return IntroScene