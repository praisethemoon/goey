local class = require 'class'
local Object = require 'Object'
local Matrix = require 'math.Matrix'
local GoBoard = class('GoBoard', Object)

local pb = love.graphics.newImage 'assets/players/go_black_s.png'
local pw = love.graphics.newImage 'assets/players/go_white_s.png'
local pf = love.graphics.newImage 'assets/players/go_forbidden_s.png'
local bg = love.graphics.newImage 'assets/go_board.png'

local pos_x = pb:getWidth()/2
local pos_y = pb:getHeight()/2

function GoBoard:initialize()
  	Object.initialize(self, {})
	self.x = 19
	self.y = 19
	self.gameGrid = Matrix:new(self.x, self.y)

	self.v = 1

end

function GoBoard:render()
    love.graphics.setColor(250, 255, 255, 255)
    love.graphics.draw(bg, 0, 0)

    love.graphics.setColor(0,0,0)    
    for i = 1, self.x do
    	love.graphics.line(Game.gridSize*i, Game.gridSize, Game.gridSize*i, self.y*Game.gridSize)
    end

    for i = 1, self.y do
    	love.graphics.line(Game.gridSize, Game.gridSize*i, self.x*Game.gridSize, i*Game.gridSize)
    end

    love.graphics.setColor(250, 255, 255, 255)

    for i = 1, self.x do
    	for j = 1, self.y do
    		local v = self.gameGrid:get(j,i)
    		
			if v == 1 then
	    		--love.graphics.setColor(150, 150, 150)
				--love.graphics.circle('fill', Game.gridSize*px, Game.gridSize*py, 20)
				love.graphics.draw(pb, Game.gridSize*i, Game.gridSize*j, 0, 1, 1, pos_x, pos_y)
			elseif v == 2 then
	    		--love.graphics.setColor(0, 0, 0)
	   			--love.graphics.circle('fill', Game.gridSize*px, Game.gridSize*py, 20)
				love.graphics.draw(pw, Game.gridSize*i, Game.gridSize*j, 0, 1, 1, pos_x, pos_y)
	   		end
    	end
    end

    local x, y = love.mouse.getPosition()
		
	px = math.floor((x / Game.gridSize)+0.5)
	py = math.floor((y / Game.gridSize)+0.5)

    if (px <= self.x) and (py <= self.y) and (px > 0) and (py > 0) then
	
    	love.graphics.setColor(250, 255, 255, 150)
    	if self.gameGrid:get(py, px) ~= 0 then
			love.graphics.draw(pf, Game.gridSize*px, Game.gridSize*py, 0, 1, 1, pos_x, pos_y)
		elseif self.v == 1 then
			--love.graphics.circle('fill', Game.gridSize*px, Game.gridSize*py, 20)
			love.graphics.draw(pb, Game.gridSize*px, Game.gridSize*py, 0, 1, 1, pos_x, pos_y)
		elseif self.v == 2 then
   			--love.graphics.circle('fill', Game.gridSize*px, Game.gridSize*py, 20)
			love.graphics.draw(pw, Game.gridSize*px, Game.gridSize*py, 0, 1, 1, pos_x, pos_y)
   		end
    end
    
	love.graphics.setColor(0,0,0,255)
end

function GoBoard:place(x, y)
	--print(x, y, self.gameGrid:get(y, x))
	if self.gameGrid:get(y, x) == 0 then
		local captures = self.gameGrid:place(y, x, self.v)

		if self.v == 1 then
			self.v = 2
			Game.blackScore = Game.blackScore + captures
		else
			self.v = 1
			Game.whiteScore = Game.whiteScore + captures
		end
	end
end

return GoBoard