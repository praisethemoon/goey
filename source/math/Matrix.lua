local class = require 'class'
local Matrix = class 'Matrix'

function Matrix:initialize(sx, sy)
	self.data = {{}}
	self.sx = sx
	self.sy = sy

	for i= 1, sx do
		self.data[i] = {}
		for j = 1, sy do
			self.data[i][j] = 0
		end
	end
end

function Matrix:place(x, y, v)
	assert((v == 1) or (v == 2))
	assert(self.data[x][y] == 0)
	assert(x <= self.sx)
	assert(x > 0)
	assert(y <= self.sy)
	assert(y > 0)
	
	self.data[x][y] = v

	-- TODO: check if move is suicidal
	
	local i = x
	local j = y

	local v2 = 1

	if v == 1 then
		v2 = 2
	end

	captures = 0

	if i-1 >0 then
		captures = captures + self:findCandidate(i-1, j, v2)
	end

	if j-1 > 0 then
		captures = captures + self:findCandidate(i, j-1, v2)
	end

	if j + 1 <= self.sy then
		captures = captures + self:findCandidate(i, j+1, v2)
	end

	if i+1 <= self.sx then
		captures = captures + self:findCandidate(i+1, j, v2)
	end

	return captures
end

function Matrix:findCandidate(i, j, v)
	local captures = 0
	--print("searching at ", i, j, "have", self:get(i, j))
	if self:get(i, j) == v then
		--print("found candidate at ", i , j)
		local list = {}
		local l = self:parcoursLiberty(i, j, v, list)
		--print("liberties: ", l)

		if l == 0 then
			for i, v in ipairs(list) do
				self.data[v[1]][v[2]] = 0
			end
			captures = #list
		end

	end

	return captures
end

function Matrix:parcoursLiberty(i, j, v, list)

	for _, v in ipairs(list) do
		if (v[1] == i) and (v[2] == j) then
			return 0
		end
	end


	table.insert(list, {i, j})

	local left, right, up, down = 0, 0, 0, 0

	if i-1 > 0 then
		local t = self:get(i-1, j) 
		if t == 0 then
			up = 1
		elseif t == v then
			up = self:parcoursLiberty(i-1, j, v, list)
		end
	end

	if j-1 > 0 then
		local t = self:get(i, j-1) 
		if t == 0 then
			left = 1
		elseif t == v then
			left = self:parcoursLiberty(i, j-1, v, list)
		end
	end

	if j + 1 <= self.sy then
		local t = self:get(i, j+1) 
		if t == 0 then
			right = 1
		elseif t == v then
			right = self:parcoursLiberty(i, j+1, v, list)
		end
	end

	if i+1 <= self.sx then
		local t = self:get(i+1, j) 
		if t == 0 then
			down = 1
		elseif t == v then
			down = self:parcoursLiberty(i+1, j, v, list)
		end
	end

	return left + right + up + down
end

function Matrix:get(x, y)
	return self.data[x][y]
end


return Matrix
