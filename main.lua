--[[
Notes:
 - Qbby drops one pixel down when walking
 - If he is within 5 pixels of a grid border and crouches,
   he will snap to the grid
]]--



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
	qbby_eyes_state = "normal"
	qbby_legs_state = "standing"
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
	love.graphics.setLineWidth(2)
	love.graphics.setLineStyle("rough")

	if ( qbby_eyes_state == "squint" )
	then
		love.graphics.line(9.5,7.5, 13,11)
		love.graphics.line(17.5,10.5, 21,7) -- have to -/+ 0.5 or there is weird fishtailing at 400x240
	else
		eyes_frame = frame % 270
		-- This sucks but a lookup table sucks more
		if ( eyes_frame == 1 or eyes_frame == 2 or eyes_frame == 5 or eyes_frame == 6)
		then
			-- Blink start/end
			love.graphics.rectangle("fill", 10,9, 2,1)
			love.graphics.rectangle("fill", 18,9, 2,1)
		elseif ( eyes_frame == 3 or eyes_frame == 4)
		then
			-- Blink middle
			love.graphics.rectangle("fill", 9,9, 3,1)
			love.graphics.rectangle("fill", 17,9, 3,1)
		else
			-- No blink
			love.graphics.rectangle("fill", 10,8, 2,2)
			love.graphics.rectangle("fill", 18,8, 2,2)
		end
	end

	-- Legs
	-- no animation yet, cba
	-- 5.5 in
	if ( qbby_legs_state == "walking" ) -- drops 1 pixel when walking
	then
	else
		love.graphics.line(5.5,24, 5.5, 30)
		love.graphics.line(18.5,24, 19.5, 30)
	end
	
	-- Switch back
    love.graphics.setCanvas()
end


function fakelevel()
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle("fill", 0,0, 24,24)
	love.graphics.rectangle("fill", 48,0, 24,24)
end
