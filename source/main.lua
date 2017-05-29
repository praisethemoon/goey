--require 'lovedebug'
local engine = require 'Engine':new()

function love.load()
  engine:load()
end

function love.update(dt)
  engine:update(dt)
end

function love.draw()
  engine:render()
end

function love.exit()
  engine:quit()
end

function love.keypressed(key, scanCode, isRepeat)
	engine:keyPressed(key, scanCode, isRepeat)
end

function love.keyreleased(key, scanCode)
	engine:keyReleased(key, scanCode)
end


function love.mousepressed(x, y, button, isTouch)
	engine:mousePressed(x, y, button, isTouch)
end


function love.mousereleased(x, y, button, isTouch)
	engine:mouseReleased(x, y, button, isTouch)
end

function love.textinput(t)
	engine:textInput(t)
end

function love.resize(w, h)

end

function love.quit()
	engine:quit()
end