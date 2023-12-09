--[[
	Contains drawing code for qbby and his boxes
Notes:
 - Qbby drops one pixel down when walking
 - If he is within 5 pixels of a grid border and crouches,
   he will snap to the grid
]]--

function init_qbby()
	qbby = {}
	qbby["canvas"] = love.graphics.newCanvas(24, 30)
	qbby["xpos"] = 24
	qbby["ypos"] = 24
	qbby["direction"] = "right"
	qbby["eyes_state"] = "normal" -- normal / squint
	qbby["legs_state"] = "standing" -- standing / walking / none
	qbby["walk_frame"] = 0
end

function update_qbby_sprite()
	-- Switch to canvas
    love.graphics.setCanvas(qbby["canvas"])
    -- Clear canvas
    love.graphics.clear(0, 0, 0, 0)
    
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

	if ( qbby["eyes_state"] == "squint" )
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
	-- 5.5 in
	if ( qbby["legs_state"] == "walking" ) -- drops 1 pixel when walking
	then
		qbby["walk_frame"] = qbby["walk_frame"] + 1 
		local walk_frame = qbby["walk_frame"] % 30
		-- I am aware this sucks
		-- Ill fix it later
		if ( walk_frame < 15 )
		then
			love.graphics.line(5.5,24, 7 - ( 0.25 * walk_frame ),27)
			love.graphics.line(18.5,24, 16 + ( 0.25 * walk_frame ),27)
		else
			love.graphics.line(5.5,24, 4 + ( 0.25 * ( walk_frame - 15 ) ),27)
			love.graphics.line(18.5,24, 20 - ( 0.25 * ( walk_frame - 15 ) ),27)
		end

	elseif ( qbby["legs_state"] == "standing")
	then
		qbby["walk_frame"] = 0
		love.graphics.line(5.5,24, 5.5, 30)
		love.graphics.line(18.5,24, 18.5, 30)
	end

	-- Switch back
    love.graphics.setCanvas()
end
