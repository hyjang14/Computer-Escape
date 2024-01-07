-----------------------------------------------------------------------------------------
--
-- 백신5
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newImageRect("image/배경/배경_저택_2층로비.png", 1900, 1210)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2 - 50

	local pi = display.newImageRect("image/캐릭터/pixil(앞)-0.png", 120, 120)
	pi.x, pi.y = display.contentWidth/2, display.contentHeight/2

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local explanation = display.newImage("image/UI/물음표.png")
	explanation.x, explanation.y = 100, 80

	local talk1 = display.newImage("image/UI/대화창 ui.png")
	talk1.x, talk1.y = display.contentWidth/2, display.contentHeight * 0.78

	local bullet = display.newImageRect("image/총알.png", 80, 80)
	bullet.x, bullet.y = display.contentWidth/2, display.contentHeight/2 
	bullet.alpha = 0

	sceneGroup:insert(background)
	sceneGroup:insert(pi)
	sceneGroup:insert(inventory)
	sceneGroup:insert(explanation)

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	local dialog = display.newGroup()

	local speaker = display.newText(dialog, "파이", display.contentWidth*0.25, display.contentHeight*0.76, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker, 50)
	speaker:setFillColor(0)
	
	local content = display.newText(dialog, "제발 이거 맞고 사라져라...!", display.contentWidth*0.5, display.contentHeight*0.902, display.contentWidth*0.7, display.contentHeight*0.2, font_Content, 45)
	content:setFillColor(0)

	sceneGroup:insert(dialog)
	sceneGroup:insert(talk1)
	sceneGroup:insert(speaker)
	sceneGroup:insert(content)


	-- json에서 정보 읽기
	local Data = jsonParse("2nd_floor_Vaccine_json/Vaccine5.json")

	-- json에서 읽은 정보 적용하기

	local function nextScript( event )
		composer.gotoScene( "2nd_floor_ending3" ) 
	end
	talk1:addEventListener("tap", nextScript)

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
		composer.removeScene( "2nd_floor_Vaccine5" )
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
