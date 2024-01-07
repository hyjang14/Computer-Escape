-----------------------------------------------------------------------------------------
--
-- fail_escape.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newImage("image/컴퓨터화면.png",display.contentCenterX, display.contentCenterY)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	
	sceneGroup:insert(background)

	

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	-- ↓ 휴지통 속 배경  ----------------------------------------------------------------------------------------------------

	local trashcan_bg = display.newImage("image/서브창/폴더창.png",display.contentCenterX, display.contentCenterY)
	trashcan_bg.x, trashcan_bg.y = display.contentWidth/2, display.contentHeight/2

	local trashcan_content = display.newImage("image/서브창/휴지통내부.png",display.contentCenterX, display.contentCenterY)
	trashcan_content.x, trashcan_content.y = display.contentWidth/2 - 5, display.contentHeight/2 + 70

	local exit = display.newRect(display.contentCenterX * 1.705, display.contentCenterY * 0.31, 50, 50)
    exit:setFillColor(1, 0, 0) 
    exit.alpha = 0.01

	sceneGroup:insert(trashcan_bg)
	sceneGroup:insert(trashcan_content)
	sceneGroup:insert(exit)

	-- exit 눌러서 휴지통 나가기--------------------------------

	local function back( event )
		audio.play( buttonSound )

		composer.removeScene("compass_fail")
		composer.gotoScene("compass_computerScreen")
	end
	exit:addEventListener("tap", back)

	----------------------------------------------------------

	-- ↑ 휴지통 속 배경 ----------------------------------------------------------------------------------------------------

	sceneGroup:insert(inventory)
	sceneGroup:insert(question)

   
	-- ↓ 시간 -------------------------------------------------------------------------------------------------

    local hour = os.date( "%I" )
    local minute = os.date( "%M" )

    local hourText = display.newText(hour, display.contentWidth * 0.919, display.contentHeight * 0.972, font_Speaker)
    hourText.size = 46
    hourText:setFillColor(0)
    local minuteText = display.newText(minute, display.contentWidth * 0.975, display.contentHeight * 0.972, font_Speaker)
    minuteText.size = 46
    minuteText:setFillColor(0)
    local text = display.newText(":", display.contentWidth * 0.946, display.contentHeight * 0.96, font_Speaker)
    text.size = 100
    text:setFillColor(0)

    local function counter( event )
        hour = os.date( "%I" )
        hourText.text = hour
        minute = os.date( "%M" )
        minuteText.text = minute
    end

    timer.performWithDelay(1000, counter, -1)

    sceneGroup:insert(hourText)
    sceneGroup:insert(minuteText)
    sceneGroup:insert(text)

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
		composer.removeScene( "compass_fail" )
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
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