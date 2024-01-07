-----------------------------------------------------------------------------------------
--
-- compass_script2.lua
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

	local chatBox = display.newImage("image/UI/대화창 ui.png")
	chatBox.x, chatBox.y = display.contentWidth/2, display.contentHeight * 0.78

	sceneGroup:insert(inventory)
	sceneGroup:insert(question)

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	local image = display.newImage("image/캐릭터/파이 당황.png")
	image.x, image.y = display.contentWidth*0.2, display.contentHeight*0.5

	local speaker = display.newText("파이", display.contentWidth*0.25, display.contentHeight*0.76, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker)
	speaker:setFillColor(0)
	speaker.size = 50

	local content = display.newText("여기서 얻을 수 있는건 더 없는 것 같아.", display.contentWidth*0.5, display.contentHeight*0.902, display.contentWidth*0.7, display.contentHeight*0.2, font_Content , 45)
	content:setFillColor(0)

	sceneGroup:insert(image)
	sceneGroup:insert(chatBox)
	sceneGroup:insert(content)
	sceneGroup:insert(speaker)


	local function nextScript( event )
		composer.gotoScene( "compass_trashcan" ) 
	end
	chatBox:addEventListener("tap", nextScript)

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
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		composer.removeScene( "compass_script2" )
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
