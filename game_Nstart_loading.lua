-----------------------------------------------------------------------------------------
--
-- 저택 게임 로딩창
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- ↓ 보안창 ----------------------------------------------------------------------------------------------------------------------------
	local background = display.newImage("image/로딩창/게임로딩바.png")
	background.x, background.y = display.contentCenterX, display.contentHeight * 0.5

	local loading = display.newImageRect("image/로딩창/로딩바만.png", 190, 65)
	loading.x, loading.y = display.contentWidth * 0.252, display.contentHeight * 0.745
	loading.anchorX = -1

	sceneGroup:insert(background)
	sceneGroup:insert(loading)

	-- ↑ 오브젝트 정리 ---------------------------------------------------------------------------------------------------------------------

	-- ↓ 함수 정리 -------------------------------------------------------------------------------------------

	local go = 5
	local function counter( event )
		if go > 1 then
			loading.width = (7 - go) * 190
		end
		go = go - 1
		if(go == -1) then
			composer.gotoScene( "screen_noTransfer" )
		end

	end

 	timer.performWithDelay(1000, counter, 6)

	
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
		timer.cancelAll()
		composer.removeScene( "game_Nstart_loading" )
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
