-----------------------------------------------------------------------------------------
--
-- login_passwordFind.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local exit
local inputPassword1
local inputPassword2
local button

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/네이버 로그인/passwordFind_bg.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	exit = display.newRect(display.contentWidth*0.969, display.contentHeight * 0.043, 63, 55)
    exit:setFillColor(1, 0, 0)
    exit.alpha = 0.01

	button = display.newRect(display.contentWidth*0.707, display.contentHeight * 0.63, 140, 195)
    button:setFillColor(0, 0, 1)
    button.alpha = 0.01

	inputPassword1 = native.newTextField(display.contentCenterX, display.contentCenterY, 580, 66)
	inputPassword1.x, inputPassword1.y = display.contentWidth * 0.485, display.contentHeight*0.573

	inputPassword2 = native.newTextField(display.contentCenterX, display.contentCenterY, 580, 66)
	inputPassword2.x, inputPassword2.y = display.contentWidth * 0.485, display.contentHeight*0.687

	sceneGroup:insert(background)
	sceneGroup:insert(exit)
	sceneGroup:insert(button)
	sceneGroup:insert(inputPassword1)
	sceneGroup:insert(inputPassword2)

	function onNextButtonTap()
	    local id = inputPassword1.text
	    local name = inputPassword2.text

	    if id == "pi00" and name == "파이" then
	        print("정답입니다!")
	        enteredID = id
	        enteredName = name
	        native.setKeyboardFocus(nil) 
	        display.remove(inputPassword1)
	        display.remove(inputPassword2)

	        button:removeEventListener("tap", onNextButtonTap)
	        composer.removeScene('login_passwordFind') 
	        composer.gotoScene("login_security")
	    else
	        print("틀렸습니다. 다시 입력해주세요.")
	        inputPassword1.text = ""
	        inputPassword2.text = ""

	        local wrong = display.newText("아이디 또는 이름을 잘못 입력했습니다.\n다시 입력해주세요.", display.contentWidth*0.43, display.contentHeight*0.8)
        	wrong.size = 40
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


	local function back()
		button:removeEventListener("tap", onNextButtonTap)
		display.remove(inputPassword1)
	    display.remove(inputPassword2)
		
		composer.removeScene('login_passwordFind') 
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

local function clearScene()
    display.remove(inputPassword1)
    display.remove(inputPassword2)
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		clearScene()
		composer.removeScene('login_passwordFind') 
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
