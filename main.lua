function love.load()
	-- Window setup
	window_width = 400
	window_height = 240
	draw_scale = 1
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.window.setMode(window_width * draw_scale, window_height * draw_scale, {resizable=false, fullscreen=false, centered=true, vsync=true})

	-- Game state stuff
	frame = 1


	-- Setup for sprite
	qbby = love.graphics.newCanvas(24, 30)
	qbby_eyes_state = "squint"
end

function love.update()
	frame = frame + 1
end

function love.draw()
	-- Save settings and set scale
	love.graphics.push()
	love.graphics.scale(draw_scale)
	love.graphics.setBackgroundColor(255, 255, 255, 1)

	-- Qbby
	update_qbby_sprite()
	love.graphics.draw(qbby, 0,0)

	love.graphics.pop()
end

function update_qbby_sprite()
	-- Switch to canvas
    love.graphics.setCanvas(canvasboy)
	-- Outline
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle("fill", 0,0, 24,24, 2,2)
		
	-- Infill
	love.graphics.setColor(255, 255, 255, 1)
	love.graphics.rectangle("fill", 2,2, 20,20)

	-- Eyes
	love.graphics.setColor(0, 0, 0, 1)
	if ( qbby_eyes_state == "squint" )
	then
		love.graphics.setLineWidth(2)
		love.graphics.setLineStyle("rough")
		love.graphics.line(10,8, 13,11)
		love.graphics.line(18,10, 21,7)
	else
		love.graphics.rectangle("fill", 10,8, 2,2)
		love.graphics.rectangle("fill", 18,8, 2,2)
	end
	-- Switch back
    love.graphics.setCanvas()
end


function fakelevel()
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle("fill", 0,0, 24,24)
	love.graphics.rectangle("fill", 48,0, 24,24)
end
