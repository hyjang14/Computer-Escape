-----------------------------------------------------------------------------------------
--
--compass_prevScript.lua
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- compass_end.lua(개구멍 들어간 이후 씬-영상 대체될 것)에서 배경음악 끔 ----------------------------------------

	audio.play( mainBackgroundMusic, { channel = 1 , loops = -1})
	audio.setVolume( 0.2, { channel=1 } )

	-------------------------------------------------------------------------------------------------------------

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newImageRect("image/컴퓨터화면.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80
	sceneGroup:insert(inventory)

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80
	sceneGroup:insert(question)

	local talk1 = display.newImage("image/UI/대화창 ui.png")
	talk1.x, talk1.y = display.contentWidth/2, display.contentHeight * 0.78
	
	-- ↑ ui정리 -------------------------------------------------------------------------------------------------


	local dialog = display.newGroup()

	local image_pi1 = display.newImage("image/캐릭터/파이 안도.png")
	image_pi1.x, image_pi1.y = display.contentWidth*0.2, display.contentHeight*0.5
	image_pi1.name = "파이"
	image_pi1.alpha = 1

	local image_pi2 = display.newImage("image/캐릭터/파이 결심.png")
	image_pi2.x, image_pi2.y = display.contentWidth*0.2, display.contentHeight*0.5
	image_pi2.name = "파이"
	image_pi2.alpha = 0

	local speaker = display.newText(dialog, "파이", display.contentWidth*0.25, display.contentHeight*0.76, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker)
	speaker:setFillColor(0)
	speaker.size = 50
	
	local content = display.newText(dialog, "휴... 나오긴 나왔는데, 이제 어떻게 하지...", display.contentWidth*0.5, display.contentHeight*0.902, display.contentWidth*0.7, display.contentHeight*0.2, font_Content)
	content:setFillColor(0)
	content.size = 40

	sceneGroup:insert(dialog)
	sceneGroup:insert(image_pi1)
	sceneGroup:insert(image_pi2)
	sceneGroup:insert(talk1)
	sceneGroup:insert(speaker)
	sceneGroup:insert(content)

	-- json에서 정보 읽기
	local Data = jsonParse("json/compass_prevScript.json")

	-- json에서 읽은 정보 적용하기
	local index = 0

	local function nextScript( event )
		index = index + 1

		if(index > #Data) then 
			composer.gotoScene( "compass_computerScreen" ) 
			return
		end
		
		speaker.text = Data[index].speaker
		content.text = Data[index].content

		if(index == 1) then
			image_pi1.alpha = 0
			image_pi2.alpha = 1
		end
	end

	talk1:addEventListener("tap", nextScript)

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
		composer.setVariable("compassGrag", true)
		composer.removeScene( "compass_prevScript" )
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
