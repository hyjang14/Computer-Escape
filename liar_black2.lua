-----------------------------------------------------------------------------------------
--
-- clear_black.lua
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	background:setFillColor(0) -- 검정 화면
	sceneGroup:insert(background)

	game1 = 1
	local count = 2
	local function counter( event )
		count = count - 1
		print(count)

		if count == 1 then
			print("///////")
			audio.pause(3)
			audio.resume(8)
			composer.hideOverlay("black")
			if (game1 ==1 and game2 == 1 and game3 == 1) then
				composer.setVariable("num", 1)
				composer.gotoScene("2nd_floor_ending1", {effect = "fade"})
			else 
				composer.gotoScene("2nd_floor_lobby", {effect = "fade"})
			end
		end
		
	end
	timer.performWithDelay(1000, counter, 3)
--
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		composer.removeScene("liar_black2")
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene