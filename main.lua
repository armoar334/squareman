--[[
		Game Logic
]]--


function love.load()
	require("qbby")
	require("boxes")
	-- Window setup
	window_width = 400
	window_height = 240
	love.window.setMode(window_width, window_height, {resizable=false, fullscreen=false, centered=true, vsync=true})

	-- Game state stuff
	frame = 1

	-- Setup for sprites
	init_qbby()
	init_boxes()

	--[[ Level
	build_stage_lookup()
	init_level(20, 20)
	update_level_canvas()
	]]--
end

function love.update()
	frame = frame + 1
	-- Movement test, will swap out for proper physics later
	qbby["legs_state"] = "standing"
	if love.keyboard.isDown( "s" ) then
		qbby["legs_state"] = "none"
	end
	if love.keyboard.isDown( "a" ) then
		qbby["direction"] = "left"
		qbby["legs_state"] = "walking"
		qbby["xpos"] = qbby["xpos"] - 1
	end
	if love.keyboard.isDown( "d" ) then
		qbby["direction"] = "right"
		qbby["legs_state"] = "walking"
		qbby["xpos"] = qbby["xpos"] + 1
	end
	if love.keyboard.isDown( "q" ) then
		love.event.quit()
	end
end

--[[
		Graphics
]]--

function love.draw()
	-- Draw to canvases
	update_qbby_sprite()
	love.graphics.setColor(255, 255, 255, 1)
	update_boxes_sprite()
	love.graphics.setColor(255, 255, 255, 1)

	-- Draw to screen
	love.graphics.setBackgroundColor(255, 255, 255, 1)	
	if ( qbby["legs_state"] == "walking")
	then
		qbby_draw_offset = 1
	elseif ( qbby["legs_state"] == "none" )
	then
		qbby_draw_offset = 6
	else
		qbby_draw_offset = 0
	end

	if ( qbby["direction"] == "left" )
	then
		love.graphics.draw(qbby["canvas"], qbby["xpos"], qbby["ypos"] + qbby_draw_offset, 0, -1, 1, 24)
	else
		love.graphics.draw(qbby["canvas"], qbby["xpos"], qbby["ypos"] + qbby_draw_offset)
	end
	love.graphics.draw(boxes["canvas"], qbby["xpos"] - 144, qbby["ypos"] - 144) -- minus 120 so qbby is in middle
end
