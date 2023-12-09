function init_boxes()
	boxes = {}
	boxes["canvas"] = love.graphics.newCanvas(11 * 24, 11 * 24) -- enough for 5 in each direction
	boxes["list"] = { "right", "right", "right", "up"}
	boxes["qbby"] = true -- if boxes are still connected
end

function update_boxes_sprite()
	-- Switch to an clear canvas
	love.graphics.setCanvas(boxes["canvas"])
	love.graphics.clear(0, 0, 0, 0)

    
    -- Start in middle
    local boxes_xpos = 6
    local boxes_ypos = 6

	-- Iterate over list
	for index, direction in pairs(boxes["list"]) do
		if ( direction == "up" )
		then
			boxes_ypos = boxes_ypos - 1 
		end
		if ( direction == "down" )
		then
			boxes_ypos = boxes_ypos + 1 
		end
		if ( direction == "left" )
		then
			boxes_xpos = boxes_xpos - 1 
		end
		if ( direction == "right" )
		then
			boxes_xpos = boxes_xpos + 1 
		end
		-- Outline
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.rectangle("fill", boxes_xpos * 24,boxes_ypos * 24, 24,24, 2,2)
		
		-- Infill
		love.graphics.setColor(191, 191, 191, 1)
		love.graphics.rectangle("fill", ( boxes_xpos * 24 ) + 2,( boxes_ypos * 24 ) + 2, 20,20)
	end
	
    -- Restore stuff
    love.graphics.setCanvas()
end
