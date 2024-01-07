-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local vaccineLeft = display.newImageRect("image/캐릭터/백신좌향 0.png", 180, 180)
	vaccineLeft.x, vaccineLeft.y = display.contentWidth*0.89, display.contentHeight*0.44
	vaccineLeft.alpha = 0
	local vaccineDown  = display.newImageRect("image/캐릭터/백신 정면0.png", 180, 180)
	vaccineDown.x, vaccineDown.y = display.contentWidth*0.918, display.contentHeight*0.44
	local vaccineUp = display.newImageRect("image/캐릭터/백신뒤0.png", 180, 180)
	vaccineUp.x, vaccineUp.y = display.contentWidth*0.918, display.contentHeight*0.44
	vaccineUp.alpha = 0
	-- vaccineLeft.fill = {type = "image", filename = "image/캐릭터/백신좌향 0.png"}
	-- vaccineDown.fill = {type = "image", filename = "image/캐릭터/백신 정면0.png"}
	-- vaccineUp.fill = {type = "image", filename = "image/캐릭터/백신뒤0.png"}

	local function moveDown()
		--파이: 2초간, x축 -1000px 이동

		transition.to(vaccineDown, {
			time = 1000,
			y = vaccineDown.y + 200,
			onComplete = function() --끝나면
				vaccineDown.y = display.contentHeight*0.44 + 1000
			end	
		})	
	end
	
	local function moveLeft()
		--파이: 2초간, x축 -1000px 이동

		transition.to(vaccineLeft, {
			time = 4000,
			x = vaccineDown.x - 1400,
			onComplete = function() --끝나면
				vaccineDown.x = display.contentWidth*0.918 - 3000
			end
		})	
	end
	
	local function moveUp()
		--파이: 2초간, x축 -1000px 이동

		transition.to(vaccineUp, {
			time = 1000,
			y = vaccineUp.y - 480,
			onComplete = function() --끝나면
				vaccineUp.y = display.contentHeight*0.918 - 3000
			end	
		})	
	end

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newImageRect("image/컴퓨터화면.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	-- local restart = display.newImage("image/UI/세모.png")
	-- restart.x, restart.y = 1820, 80

	-- local inventory = display.newImage("image/UI/인벤토리.png")
	-- inventory.x, inventory.y = 240, 80

	-- local question = display.newImage("image/UI/물음표.png")
	-- question.x, question.y = 100, 80

	-- sceneGroup:insert(restart)
	-- sceneGroup:insert(inventory)
	-- sceneGroup:insert(question)

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	local vaccine = display.newImageRect("image/보안/백신.png", 220, 220)
	vaccine.alpha = 0
	vaccine.x, vaccine.y = 1570, 220
	local player = display.newImageRect("image/캐릭터/pixil(앞)-"..(0)..".png", 170, 170)
	player.x, player.y = display.contentWidth*0.876, display.contentHeight*0.45
	
	sceneGroup:insert(vaccine)
	sceneGroup:insert(player)


	-- ↓ 함수 정리 -------------------------------------------------------------------------------------------

	local go = 8
	local function counter( event )
		go = go - 1
		print(go)

		if (go == 7)then
			moveDown()
		end
		if go == 6 then
			vaccineLeft.y = vaccineDown.y
			vaccineLeft.alpha = 1
			vaccineDown.alpha = 0
			moveLeft()
		end
		if go == 2 then
			vaccineLeft.alpha = 0
			vaccineUp.alpha = 1
			vaccineUp.x, vaccineUp.y = vaccineLeft.x, vaccineLeft.y
			moveUp()
		end

		if(go == 0) then
			vaccineUp.alpha = 0
			composer.gotoScene( "mainScript7" )
		end

	end

 	timer.performWithDelay(1000, counter, 9)

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
