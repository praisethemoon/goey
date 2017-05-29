class = require 'class'
Object = class 'Object'

function Object:initialize(params)
	self.name = 'obj'
	self.x = 0
	self.y = 0
	self.rot = 0

	for i, v in ipairs(params) do 
		self[i] = v
	end

end

function Object:render()
end

function Object:update(dt)
end

return Object