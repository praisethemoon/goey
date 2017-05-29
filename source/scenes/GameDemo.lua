local class = require 'class'
local Scene = require 'Scene'
local Engine = require 'Engine'
local Matrix = require 'math.Matrix'
local socket = require 'socket'
local md5 = require 'md5.md5'
local suit = require 'suit'

local GameDemo = class('GameDemo', Scene)

function GameDemo:initialize()
	Scene.initialize(self, "GameDemo")
	self.board = require 'game.GoBoard':new()
	self:addChild(self.board)
end

function GameDemo:load()
  Scene.load(self)
end

function GameDemo:close()
  Scene.close(self)
end

function GameDemo:update(dt)
    suit.layout:reset(1000, 25)
    suit.layout:padding(5,5)
		suit.Label("Black Captures: "..Game.blackScore, suit.layout:row(300,30))
		suit.Label("White Captures: "..Game.whiteScore, suit.layout:row(300,30))
end

function GameDemo:mousePressed(x, y, button, isTouch)
	if (button == 1) and (x > 0) and (x < self.board.x*Game.gridSize + 25) and (y > 0) and (y < self.board.y * Game.gridSize + 25) then
		px = math.floor((x / Game.gridSize)+0.5)
		py = math.floor((y / Game.gridSize)+0.5)

		self.board:place(px, py)
	end
end

function GameDemo:render()
	Scene.render(self)
	love.graphics.setBackgroundColor(0,0,0)

	love.graphics.setColor(0,0,0,255)
end

return GameDemo