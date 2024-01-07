-----------------------------------------------------------------------------------------
--
-- 게임시작
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local composer = require("composer")

	-- -- 변수들 전체 초기화
	-- interactionNumber = 0
	-- isInteraction = {}
	-- for i = 1, 8 do
	-- 	isInteraction[i] = false
	-- end

	-- itemNum = {}

	-- for i = 1, 6 do
	-- 	itemNum[i] = false
	-- end

	-- cherry_interaction = 0
	-- game1 = 0 --거짓말쟁이방
	-- game2 = 1 --장미방
	-- game3 = 0 --예술가의방

	-- composer.setVariable("playerX", nil)
	-- composer.setVariable("playerY", nil)
	-- composer.setVariable("playerX2", nil)
	-- composer.setVariable("playerX2", nil)
	-- composer.setVariable("playerX_compass", nil)
	-- composer.setVariable("playerY_compass", nil)
	-- composer.setVariable("number", nil)
	-- composer.setVariable("security_restart", nil)
	-- composer.setVariable("interEnd", nil)
	-- composer.setVariable("next", nil)
	-- composer.setVariable("sim", nil)


	-- -- 2초뒤 이동
	-- local go = 2
	-- local function counter( event )
	-- 	go = go - 1
	-- 	if go == -1 then
	-- 		composer.gotoScene("start1", {effect = "fade"})
	-- 	end
	-- end

 	-- timer.performWithDelay(1000, counter, 3)

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
		composer.removeScene("startVideo1")
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