local class = require 'class'
local Engine = class 'Engine'
local suit = require 'suit'

-- When the engine was first constructed
function Engine:initialize()
	print("Starting game engine ..")

	-- only one Engine instance is allowed
	assert(Engine.static.instance == nil)
	Engine.static.instance = self
end

-- Static method to return engine instance
function Engine.getInstance()
	return Engine.static.instance
end

function Engine:load()
	self.scene = nil
	self.zoom = 1
	self.rot = 0

	self.width = love.graphics.getWidth()
	self.height = love.graphics.getHeight()
	print(string.format("Resolution: %dx%d", self.width, self.height))

	print("Loading initial scene")
	self.scene = require 'scenes.IntroScene':new()
	self.scene:load()
	print("Engine loading complete")
end

function Engine:loadScene(scene)
	self.scene:close()
	self.scene = scene
	self.scene:load()
end

function Engine:update(dt)
	self.scene:update(dt)
end

function Engine:render()
  	love.graphics.push()
	self.scene:render()
	love.graphics.pop()


    suit.draw()
end

function Engine:onEvent(evt)
	self.scene:propagateEvent(evt)
end

function Engine:quit()
	print("shutting down engine ..")
end

function Engine:resize()
	self.width = love.graphics.getWidth()
	self.height = love.graphics.getHeight()
	print(string.format"Updated resolution: %nx%n", self.width, self.height)
end

function Engine:keyPressed(key, scanCode, isRepeat)
    suit.keypressed(key)
	self.scene:keyPressed(key, scanCode, isRepeat)
    suit.keypressed(key)
end

function Engine:keyReleased(key, scanCode)
	self.scene:keyReleased(key, scanCode)
end


function Engine:mousePressed(x, y, button, isTouch)
	self.scene:mousePressed(x, y, button, isTouch)
end


function Engine:mouseReleased(x, y, button, isTouch)
	self.scene:mouseReleased(x, y, button, isTouch)
end

function Engine:textInput(t)
	suit.textinput(t)
end

return Engine