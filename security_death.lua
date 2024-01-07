-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newImageRect("image/컴퓨터화면.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	sceneGroup:insert(inventory)
	sceneGroup:insert(question)

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	local vaccine = display.newImageRect("image/보안/백신.png", 220, 220)
	vaccine.alpha = 0
	vaccine.x, vaccine.y = 1570, 220
	local player = display.newImageRect("image/캐릭터/pixil(앞)-"..(0)..".png", 170, 170)
	player.x, player.y = display.contentWidth*0.46, display.contentHeight*0.63
	
	sceneGroup:insert(vaccine)
	sceneGroup:insert(player)


	-- ↓ 함수 정리 -------------------------------------------------------------------------------------------

	local go = 8
	local function counter( event )
		if go == 7 then -- 백신 등장
			vaccine.alpha = 1
		end
		if go == 5 then -- 백신 파이 뒤 이동
			vaccine.width = 300
			vaccine.height = 300
			vaccine.x, vaccine.y = display.contentWidth*0.5, display.contentHeight*0.5
		end
		if go == 4 then -- 백신 확대
			vaccine.width = 700
			vaccine.height = 700
			vaccine.x, vaccine.y = display.contentWidth*0.5, display.contentHeight*0.56
		end
		if go == 3 then -- 파이 먹음
			vaccine.y = display.contentHeight*0.63
			player.alpha = 0
		end


		go = go - 1
		if(go == -1) then
			if interactionNumber > 3 then
				interactionNumber = 5

				composer.setVariable("playerX", 0)
				composer.setVariable("playerY", 0)
				-- composer.setVariable("security_restart", true)
				composer.setVariable("gameOverNumber", 1)
			else
				interactionNumber = 0
				for i = 1, 8 do
					isInteraction[i] = false
				end
				composer.setVariable("playerX", 0)
				composer.setVariable("playerY", 0)
				composer.setVariable("security_restart", true)
				composer.setVariable("gameOverNumber", 1)
			end

			composer.gotoScene( "gameOver" )
		end

	end

 	timer.performWithDelay(600, counter, 9)

	-- ↓ 시간 -------------------------------------------------------------------------------------------------

	local hour = os.date( "%I" )
	local minute = os.date( "%M" )

	local hourText = display.newText(hour, display.contentWidth*0.919, display.contentHeight*0.972, "font/PF스타더스트 Bold.ttf")
	hourText.size = 46
	hourText:setFillColor(0)
	local minuteText = display.newText(minute, display.contentWidth*0.975, display.contentHeight*0.972, "font/PF스타더스트 Bold.ttf")
	minuteText.size = 46
	minuteText:setFillColor(0)

	local text = display.newText(":", display.contentWidth*0.946, display.contentHeight*0.96, font_Speaker)
    text.size = 100
    text:setFillColor(0)
	sceneGroup:insert(text)

	local function counter( event )
		hour = os.date( "%I" )
		hourText.text = hour
		minute = os.date( "%M" )
		minuteText.text = minute
	end

	timer.performWithDelay(1000, counter, -1)

	sceneGroup:insert(hourText)
	sceneGroup:insert(minuteText)

	-- ↑ 시간 -------------------------------------------------------------------------------------------------



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
		composer.removeScene( "security_death" )
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
