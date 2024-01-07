-----------------------------------------------------------------------------------------
--
-- gameround1_black.lua
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local heartGroup = composer.getVariable( "heartGroup")
	local personGroup = display.newGroup();
	local person = {}
	local w = {0.24, 0.37, 0.5, 0.63, 0.76}
	local selectedIndices = {0, 0, 0, 0, 0}  -- 이전에 선택한 인덱스를 저장하는 테이블  1이면 이전에 선택한 인덱스임

	for i = 1, 5 do
		local randomIndex
		repeat
			randomIndex = math.random(#w)  -- 랜덤 인덱스 선택
		until not (selectedIndices[randomIndex] == 1)  -- 선택된 인덱스가 이전에 선택된 값과 겹치지 않도록 반복

		person[i] = display.newImageRect(personGroup, "image/거짓말쟁이방/liar" .. i .. ".png", 120, 120)
		person[i].x, person[i].y = display.contentWidth * w[randomIndex], display.contentHeight * 0.3
		selectedIndices[randomIndex] = 1
	end
	-- 레이어 정리
	sceneGroup:insert(personGroup)

	composer.setVariable( "personGroup2", personGroup )

	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	background:setFillColor(0) -- 검정 화면

	local gameText = display.newText("Round 2", display.contentWidth/2, display.contentHeight*0.4, font_Speaker)
    gameText.size = 200
	

	sceneGroup:insert(heartGroup)
	sceneGroup:insert(background)
	sceneGroup:insert(gameText)

	local count = 2
	local function counter( event )
		count = count - 1
		print(count)

		if count == 1 then
			print("///////")
			composer.hideOverlay("liar_gameround1_black")
			composer.setVariable( "heartGroup" , heartGroup)
			composer.gotoScene("liar_gameround2")
		end
		
	end
	timer.performWithDelay(1000, counter, 3)

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
		composer.removeScene("liar_gameround1_black")
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
composer.recycleOnSceneChange = true
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene