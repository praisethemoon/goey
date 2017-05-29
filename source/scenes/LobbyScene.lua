local class = require 'class'
local Scene = require 'Scene'
local Engine = require 'Engine'
local Matrix = require 'math.Matrix'
local socket = require 'socket'
local md5 = require 'md5.md5'
local suit = require 'suit'
local lunajson = require 'lunajson'

local LobbyScene = class('LobbyScene', Scene)

local udp = Game.udp

function LobbyScene:initialize()
	Scene.initialize(self, "LobbyScene")
end

function LobbyScene:load()
  Scene.load(self)
end

function LobbyScene:close()
  Scene.close(self)
end

function LobbyScene:update(dt)
    suit.layout:reset(100, 100)
    suit.layout:padding(5,5)
    
    if suit.Button("JoinGame", suit.layout:row(300,50)).hit then
		local msg = {cmd = 'joinQueue', session = Game.session}
		udp:send(lunajson.encode(msg))
		self.exceptResp = true
    end
end

function LobbyScene:mousePressed(x, y, button, isTouch)

end

function LobbyScene:render()
	Scene.render(self)
end

return LobbyScene