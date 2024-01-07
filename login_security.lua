-----------------------------------------------------------------------------------------
--
-- login_security.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImageRect("image/네이버 로그인/security_bg.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local exit = display.newRect(display.contentWidth*0.969, display.contentHeight * 0.043, 63, 55)
    exit:setFillColor(1, 0, 0)
    exit.alpha = 0.01
	
	local button = display.newRect(display.contentWidth*0.685, display.contentHeight * 0.795, 110, 77)
    button:setFillColor(0, 0, 1)
    button.alpha = 0.01
    button:scale(1.35, 1.4)

    local num = math.random(1, 3)

	local codeImage= display.newImage("image/네이버 로그인/code/"..num..".png")
	codeImage.x, codeImage.y = display.contentWidth*0.5, display.contentHeight*0.596
	codeImage:scale(1.9, 1.9)

	local inputCode = native.newTextField(display.contentCenterX, display.contentCenterY, 621, 70)
	inputCode.x, inputCode.y = display.contentWidth * 0.442, display.contentHeight*0.795

	sceneGroup:insert(background)
	sceneGroup:insert(exit)
	sceneGroup:insert(button)
	sceneGroup:insert(codeImage)
	sceneGroup:insert(inputCode)

	function onNextButtonTap()
	    local code = inputCode.text

	    if num == 1 and code == "4Q81j523" then
	        print("1번코드 정답입니다!")
	        native.setKeyboardFocus(nil) 
	        display.remove(inputCode)
	        display.remove(codeImage)
	        button:removeEventListener("tap", onNextButtonTap)

	        composer.removeScene('login_security') 
	        composer.gotoScene("login_circle")
	    elseif num == 2 and code == "93P107k4" then 
	    	print("2번코드 정답입니다!")
	        native.setKeyboardFocus(nil) 
	        display.remove(inputCode)
	        display.remove(codeImage)
	        button:removeEventListener("tap", onNextButtonTap)

	        composer.removeScene('login_security') 
	        composer.gotoScene("login_circle")
	    elseif num == 3 and code == "L7pI1083" then 
	    	print("3번코드 정답입니다!")
	        native.setKeyboardFocus(nil)
	        display.remove(inputCode)
	        display.remove(codeImage)
	        button:removeEventListener("tap", onNextButtonTap)

	        composer.removeScene('login_security') 
	        composer.gotoScene("login_circle")
	    else
	        print("틀렸습니다. 다시 입력해주세요.")
	        inputCode.text = ""

	        display.remove(codeImage)

	        num = math.random(1, 3)

			local codeImage2= display.newImage("image/네이버 로그인/code/"..num..".png")
			codeImage2.x, codeImage2.y = display.contentWidth*0.5, display.contentHeight*0.596
			codeImage2:scale(1.9, 1.9)

			sceneGroup:insert(codeImage2)

	        local wrong = display.newText("보안 인증키를 잘못 입력했습니다.\n다시 입력해주세요.", display.contentWidth*0.79, display.contentHeight*0.41)
        	wrong.size = 38
			wrong:setFillColor(1, 0, 0)
			wrong.alpha = 1
			sceneGroup:insert(wrong)

 			local function hideText()
                wrong.isVisible = false
            end

            timer.performWithDelay(2000, hideText)

            audio.play(warningSound_short)
	    end
	end

	button:addEventListener("tap", onNextButtonTap)

	function back()
		display.remove(inputCode)
		button:removeEventListener("tap", onNextButtonTap)

		composer.removeScene('login_security') 
		composer.gotoScene("login_logIn")
	end

	exit:addEventListener("tap", back)

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
		composer.removeScene('login_security') 
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view

    for i = sceneGroup.numChildren, 1, -1 do
        local child = sceneGroup[i]
        if child then
            child:removeSelf()
        end
    end
	
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
