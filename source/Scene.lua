local class = require 'class'
local Scene = class 'Scene'

function Scene:initialize(name)
  self.name = name
  self.children = {}
end

-- Called when the scene was loaded by the engine
function Scene:load()
  print(string.format("Loading scene \'%s\'", self.name))
end

-- Called when the engine closes this scene (generally to load another one)
function Scene:close()
  print(string.format("Closing scene \'%s\'", self.name))
end

-- Updates the scene
function Scene:update(dt)
	for _, v in ipairs(self.children) do
		v:update(dt)
	end
end

-- The drawing method
function Scene:render()
	for _, v in ipairs(self.children) do
		v:render()
	end
end

function Scene:addChild(obj)
  table.insert(self.children, obj)
end

function Scene:removeChild(obj)
  table.remove(self.children, obj)
end

-- Events

function Scene:keyPressed(key, scanCode, isRepeat)
	
end

function Scene:keyReleased(key, scanCode)
	
end


function Scene:mousePressed(x, y, button, isTouch)
	
end


function Scene:mouseReleased(x, y, button, isTouch)

end


return Scene