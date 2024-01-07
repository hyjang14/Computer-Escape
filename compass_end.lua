-----------------------------------------------------------------------------------------
--
-- compass_end.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	audio.stop() -- 밝은브금.bgm 끄기

	local composer = require("composer")

	local video
	
	local function videoListener(event)
		print("Event phase: " .. event.phase)
		if event.errorCode then
			native.showAlert("Video Error", event.errorMessage, { "OK" })
		end
	
		if event.phase == "ended" then
			-- 비디오 재생이 끝나면 다음 씬으로 이동
			display.remove(video)

			--2초뒤 이동
			local go = 2
			local function counter( event )
				go = go - 1
				if go == -1 then
					composer.gotoScene("initialization")
				end
			end

 			timer.performWithDelay(1000, counter, 3)
		end
	end
	
	-- Load a video
	video = native.newVideo(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	video:load("video/기본엔딩+크레딧_3.mp4", system.ResourceDirectory)
	
	-- Add video event listener
	video:addEventListener("video", videoListener)
	
	-- Play video
	video:play()
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
		composer.removeScene( "compass_end" )
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