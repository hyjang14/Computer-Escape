-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80
	sceneGroup:insert(inventory)

	local back = display.newImageRect("image/UI/인벤토리창.png", 777.5, 415)
	back.x, back.y = display.contentWidth * 0.275 , display.contentHeight * 0.332
	sceneGroup:insert(back)

	local body = display.newImageRect("image/자물쇠/열쇠표시.png", 592.8, 229.6)
	body.x, body.y = 500, 440
	sceneGroup:insert(body)

	local key = {}
	for i = 1, 3 do
		key[i] = display.newImageRect("image/자물쇠/열쇠심 하나.png", 43, 55)
		key[i].x, key[i].y = display.contentWidth*0.14 + i*170, display.contentHeight*0.26

		sceneGroup:insert(key[i])
	end
	key[2].width, key[2].height = 45, 86
	key[3].width, key[3].height = 45, 115

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	-- ↓ 함수 정리 ------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
	
	-- ↓ 열쇠 만들기 --------------------------------------------------------------------
	-- local correct = 0

	local function dragKey( event )
		if( event.phase == "began" ) then
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true
			-- 드래그 시작할 때
			event.target.x0 = event.target.x
            event.target.y0 = event.target.y

		elseif( event.phase == "moved" ) then

			if ( event.target.isFocus ) then
				-- 드래그 중일 때
				local newX = event.target.x0 + event.x - event.xStart
                local newY = event.target.y0 + event.y - event.yStart
				event.target.x = newX
                event.target.y = newY
			end

		elseif ( event.phase == "ended" or event.phase == "cancelled") then
			if ( event.target.isFocus ) then
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false
				-- 드래그 끝났을 때
			else
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false
			end
		end
	end

	for i = 1, 3 do
		key[i]:addEventListener("touch", dragKey)
	end

	-- ↑ 열쇠 만들기 --------------------------------------------------------------
	
	-- ↓ 뒤로가기 ---------------------------------------------------------------------
	local function backKey( event )
		local correct = 0

		if(key[1].x > 550 and key[1].x < 581 and key[1].y > 385 and key[1].y < 439) then
			correct = correct + 1
		end
		if(key[2].x > 714 and key[2].x < 751 and key[2].y > 375 and key[2].y < 440) then
			correct = correct + 1
		end
		if(key[3].x > 600 and key[3].x < 640 and key[3].y > 365 and key[3].y < 440) then
			correct = correct + 1
		end

		composer.setVariable("correct", correct)
		composer.showOverlay("inventoryScene")
	end
	inventory:addEventListener("tap", backKey)

	-- ↑ 뒤로가기 --------------------------------------------------------------------


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
		composer.setVariable("correct", correct)
		composer.removeScene( "key_making" )
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
