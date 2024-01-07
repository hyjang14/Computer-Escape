-----------------------------------------------------------------------------------------
--
-- robot_check.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local check
local notRobot

function scene:create( event )
    local sceneGroup = self.view

    local background = display.newImageRect("image/로봇이 아닙니다/game_bg.png", display.contentWidth, display.contentHeight)
    background.x, background.y = display.contentWidth/2, display.contentHeight/2

    notRobot = display.newImage("image/로봇이 아닙니다/notRobot_image.png")
    notRobot.x, notRobot.y = display.contentWidth*0.648, display.contentHeight*0.533
    notRobot:scale(1, 1)

    check = display.newRect(display.contentWidth*0.505, display.contentHeight*0.657, 48, 48)
    check:setFillColor(0.8, 0.8, 0.8, 0.01)
    check:scale(1.7, 1.7)

    sceneGroup:insert(background)
    sceneGroup:insert(notRobot)
    sceneGroup:insert(check)

	-- ↓ 시간 -------------------------------------------------------------------------------------------------

    local hour = os.date( "%I" )
    local minute = os.date( "%M" )

    local hourText = display.newText(hour, display.contentWidth*0.919, display.contentHeight*0.972, font_Speaker)
    hourText.size = 46
    hourText:setFillColor(0)
    local minuteText = display.newText(minute, display.contentWidth*0.975, display.contentHeight*0.972, font_Speaker)
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

    hourText:toFront()
	minuteText:toFront()

    -- ↑ 시간 -------------------------------------------------------------------------------------------------

    local selectedNum
    local selectedIndex = 0

    --체크빈칸 누르면 로봇판단하는 게임 & 초시계 뜨게하는 함수 
    local function tapCheck( event )
        audio.play(questSound)
        notRobot.alpha = 0 
        check.alpha = 0
        display.remove(notRobot)
        notRobot = nil
        display.remove(check)
        check = nil

        local notRobot_check = display.newImage("image/로봇이 아닙니다/check.png")
        notRobot_check.x, notRobot_check.y = display.contentWidth*0.63, display.contentHeight*0.53
        notRobot_check:scale(1, 1)

        transition.to(notRobot_check, {time = 1000, x = notRobot_check.x - 730, width = notRobot_check.width * 1, height = notRobot_check.height * 1, transition = easing.outSine})

        local game = display.newImage("image/로봇이 아닙니다/game.png")
        game.x, game.y = display.contentWidth * 0.72, display.contentHeight * 0.53
        game:scale(1, 1)

        game.alpha = 0

        transition.to(game, {time = 500, alpha = 1, delay = 1000})

        sceneGroup:insert(notRobot_check)
        sceneGroup:insert(game)

        -- ↓ 시간 -------------------------------------------------------------------------------------------------

        local hour = os.date( "%I" )
        local minute = os.date( "%M" )

        local hourText = display.newText(hour, display.contentWidth*0.919, display.contentHeight*0.972, font_Speaker)
        hourText.size = 46
        hourText:setFillColor(0)
        local minuteText = display.newText(minute, display.contentWidth*0.975, display.contentHeight*0.972, font_Speaker)
        minuteText.size = 46
        minuteText:setFillColor(0)
        local text = display.newText(":", display.contentWidth*0.946, display.contentHeight*0.96, font_Speaker)
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

        hourText:toFront()
        minuteText:toFront()

        -- ↑ 시간 -------------------------------------------------------------------------------------------------

        transition.to(game, {time = 1000, onComplete = function()
            composer.gotoScene("robot_findGame")
        end})
	end

    check:addEventListener("tap", tapCheck) 

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

        composer.removeScene( "robot_check" )

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
