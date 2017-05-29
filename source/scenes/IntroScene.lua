require 'game.Game'

local class = require 'class'
local Scene = require 'Scene'
local Engine = require 'Engine'
local IntroScene = class('IntroScene', Scene)
local suit = require 'suit'
local socket = require 'socket'
local md5 = require 'md5.md5'
local lunajson = require 'lunajson'


local login = {label = "login", text=""}
local pwd = {label= "password", password = true, text=""}


local address, port = "localhost", 12345
local udp = socket.udp()
udp:settimeout(0)
udp:setpeername(address, port)

Game.udp = udp

function IntroScene:initialize()
  Scene.initialize(self, "IntroScene")

  self.logo = love.graphics.newImage("assets/igo_logo_md.png")

  self.timer = require 'engine.Timer':new(5000)

  self.font3 = love.graphics.newFont('assets/fonts/exo/Exo-Light.otf', 22)
  
  self.logoDrawX = self.logo:getWidth() / 2 
  self.logoDrawY = self.logo:getHeight() / 2 

  self.exceptResp = false

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
	-- Put a button on the screen. If hit, show a message.
    
    local midx, midy = love.graphics.getWidth()/2, (love.graphics.getHeight()/3)*2

    suit.layout:reset(midx-150,midy)
    -- put 10 extra pixels between cells in each direction
    suit.layout:padding(10,10)
    suit.Input(login, {id="login"}, suit.layout:row(300,50))
    suit.Input(pwd, {id="pwd"}, suit.layout:row(300,50))


    if suit.Button("Login", suit.layout:row(300,50)).hit then
      local msg = {cmd = 'login', user = login.text, password = md5.sumhexa(pwd.text)}
			udp:send(lunajson.encode(msg))
      self.exceptResp = true
    end

    if self.exceptResp then
      local data, msg = udp:receive()
      if data ~= nil then
        local resp = lunajson.decode(data)
        print(data)
        if resp.success then
          Game.session = resp.session
          print(Engine.getInstance():loadScene(require 'scenes.LobbyScene' : new()))
        else
          print("login failed")
        end
        self.exceptResp = false
      end
    end
end

function IntroScene:render()
  --if self.timer.active then
    local midx, midy = love.graphics.getWidth()/2, love.graphics.getHeight()/3
    love.graphics.setBackgroundColor(255, 255, 255)

    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.logo, midx, midy, 0, 1, 1, self.logoDrawX, self.logoDrawY)

    
    love.graphics.setFont(self.font3)
  --else
  --  love.graphics.print("By praisethemoon", 100, 100)
  --end  
end

function IntroScene:keyReleased(key, scanCode)
end

return IntroScene