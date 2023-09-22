-----------------------------------------------------------------------------------------
--
-- login_logIn.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local button1 
local findPassword


function scene:create( event )
	local sceneGroup = self.view

	
	local background = display.newImageRect("image/네이버 로그인/logIn_bg.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local exit = display.newRect(display.contentWidth*0.969, display.contentHeight * 0.043, 63, 55)
    exit:setFillColor(1, 0, 0)
    exit.alpha = 0.01

	local inputPassword = native.newTextField(display.contentCenterX, display.contentCenterY, 540, 59)
	inputPassword.x, inputPassword.y = display.contentWidth * 0.531, display.contentHeight*0.6099

	findPassword = display.newRect(display.contentWidth*0.5, display.contentHeight*0.795, 210, 60)
	findPassword:setFillColor(0.8, 0.8, 0.8, 0.01) 
	findPassword:scale(1.0, 1.0)

	button1 = display.newRect(display.contentWidth*0.4995, display.contentHeight * 0.715, 834, 68)
    button1:setFillColor(0, 0, 1)
    button1.alpha = 0.01

    local erase = display.newCircle(display.contentWidth*0.696, display.contentHeight*0.61, 25, 25)
	erase:setFillColor(0.9, 0.9, 0.9) 
	erase.number = 0
	erase.alpha = 0.01

	sceneGroup:insert(background)
	sceneGroup:insert(exit)
	sceneGroup:insert(inputPassword)
	sceneGroup:insert(findPassword)
	sceneGroup:insert(button1)
	sceneGroup:insert(erase)


	local wrongCount = 0

	function eraseAll()
		inputPassword.text = ""
	end

	erase:addEventListener("tap", eraseAll)


	function onNextButtonTap()
	    local passWord = inputPassword.text

	    if passWord == "등잔밑이어둡다" then
	        print("정답입니다!")
	        native.setKeyboardFocus(nil) 
	        display.remove(inputPassword)
	        composer.removeScene('login_logIn') 
	        -- audio.stop() --로그인 성공하면 loading으로 이동하면서 bgm 정지
	        audio.play(gameSuccess)
			composer.gotoScene("robot_mail")
	    else
	        print("틀렸습니다. 다시 입력해주세요.")
			composer.showOverlay("login_script", {isModal = true})
			
	        inputPassword.text = ""
		end
	        
	end
	button1:addEventListener("tap", onNextButtonTap)

	local function passWord( event )
		display.remove(background)
        display.remove(inputPassword)
		composer.removeScene('login_logIn') 
		composer.gotoScene('login_passwordFind')
	end
	findPassword:addEventListener("tap", passWord)

	local function hide( event )
		audio.play(buttonSound)
    	composer.gotoScene("computerScreen")
	end
	exit:addEventListener("tap", hide)


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
		composer.removeScene('login_logIn') -- 추가
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