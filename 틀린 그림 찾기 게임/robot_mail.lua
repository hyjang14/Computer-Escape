-----------------------------------------------------------------------------------------
--
-- mail.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- 배경 & 메일 버튼 생성 -----------------------------------------------------------------------------------
	
	local background = display.newImageRect("image/로봇이 아닙니다/bg1_mail.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local mail_button = display.newRect(display.contentWidth*0.1785, display.contentHeight*0.594, 110, 62)
	mail_button:setFillColor(0.8, 0.8, 0.8, 0.01) 
	mail_button:scale(1.5, 1.5)

	sceneGroup:insert(background)
	sceneGroup:insert(mail_button)
	
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
	sceneGroup:insert(text)

    hourText:toFront()
    minuteText:toFront()

    local pi = display.newImage("image/로봇이 아닙니다/pixil(앞)-0.png", display.contentWidth * 0.95, display.contentHeight * 0.77)
    pi:scale(0.3, 0.3)
	sceneGroup:insert(pi)

    -- ↑ 시간 -------------------------------------------------------------------------------------------------

	-- ↓ 메일 누르는 이벤트 함수 시작 -------------------------------------------------------------------------------------

	local function tapMail( event )

		local bg2 = display.newImageRect("image/로봇이 아닙니다/bg2_mail.png", display.contentWidth, display.contentHeight)
		bg2.x, bg2.y = display.contentWidth/2, display.contentHeight/2

		local point = display.newRect(display.contentWidth*0.592, display.contentHeight*0.378, 1050, 230)
	    point:setFillColor(0, 0, 0, 0) 
	    point:setStrokeColor(0.6, 0.6, 0.6) --사각형 태두리 색상
	    point.strokeWidth = 10
	    point:scale(0.65, 0.65)
	    point.alpha = 1

	    sceneGroup:insert(bg2)
    	sceneGroup:insert(point)

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


		-- 사각형 깜빡이는 함수
		function blink()
		    point.alpha = point.alpha == 0 and 1 or 0
		end

		timer.performWithDelay(500, blink, 0)

		local mail_list = display.newRect(display.contentWidth*0.592, display.contentHeight*0.38, 680, 150)
		mail_list:setFillColor(0.8, 0.8, 0.8, 0.01) 

		-- 메일 목록에서 첫번째 누르면 -> check로 이동 
		function letter( event )
			mail_list.alpha = 0
 			composer.gotoScene('robot_check')
 		end

 		mail_list:addEventListener("tap", letter) 
 	end

 	-- ↑ 메일 누르는 이벤트 함수 끝 -------------------------------------------------------------------------------------------------

 	mail_button:addEventListener("tap", tapMail) 

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
		composer.removeScene( "robot_mail" )

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