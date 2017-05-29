--[[
Control Class
]]

local class = require 'class'
local Control = 'Control'

function Control:initialize(name, enable)
	print("Creating control \"".. name .."\"")
	-- if enabled not self, then it's disabled by default
	if enable == nil then
		enable = true
	end

	self.name = name
	self.enabled = enable
	self.parent = nil

	self.updateFunc = nil
end

function Control:Update(dt)
	if self.updateFunc ~= nil and self.enabled then
		self.updateFunc(self, dt)
	end
end

function Control:Enable()
	self.enabled = true
end

function Control:Disable()
	self.enabled = false
end

function Control:Remove()
	self.parent:RemoveControl(self)
end

return Control