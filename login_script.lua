-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local chatBox = display.newImage("image/UI/대화창 ui.png")
	chatBox.x, chatBox.y = display.contentWidth/2, display.contentHeight * 0.78

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------
	local number = composer.getVariable("loginNumber")

	if(number == nil) then
		number = 1
	elseif(number == 3) then
		number = 1 
	else
		number = number + 1
	end
	print(number)

	-- json에서 정보 읽기
	local Data = jsonParse("json/login_script.json")

	local image = display.newImage(Data[number].image)
	image.x, image.y = display.contentWidth*0.2, display.contentHeight*0.5

	local speaker = display.newText("파이", display.contentWidth*0.25, display.contentHeight*0.76, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker)
	speaker:setFillColor(0)
	speaker.size = 50

	local content = display.newText(Data[number].content, display.contentWidth*0.5, display.contentHeight*0.902, display.contentWidth*0.7, display.contentHeight*0.2, font_Content , 45)
	content:setFillColor(0)

	sceneGroup:insert(image)
	sceneGroup:insert(chatBox)
	sceneGroup:insert(content)
	sceneGroup:insert(speaker)

	if number == 1 then
        local wrong = display.newText("비밀번호를 잘못 입력했습니다.\n남은 기회: 2회", display.contentWidth*0.648, display.contentHeight*0.44)
    	wrong.size = 35
		wrong:setFillColor(1, 0, 0)
		wrong.alpha = 1
		sceneGroup:insert(wrong)

		local function hideText()
        	wrong.isVisible = false 
    	end

        timer.performWithDelay(1800, hideText) 

        audio.play(warningSound_short)

	end

	if number == 2 then
        local wrong = display.newText("비밀번호를 잘못 입력했습니다.\n남은 기회: 1회", display.contentWidth*0.648, display.contentHeight*0.44)
    	wrong.size = 35
		wrong:setFillColor(1, 0, 0)
		wrong.alpha = 1
		sceneGroup:insert(wrong)

		local function hideText()
        	wrong.isVisible = false 
    	end

			timer.performWithDelay(1800, hideText) 

        audio.play(warningSound_short)
	end

	if number == 3 then
        local wrong = display.newText("비밀번호가 틀렸습니다.\n자동 보안시스템이 작동됩니다.", display.contentWidth*0.648, display.contentHeight*0.44)
    	wrong.size = 35
		wrong:setFillColor(1, 0, 0)
		wrong.alpha = 1
		sceneGroup:insert(wrong)

		audio.stop() --로그인 3번 실패하면 긴 경고음 울리면서 bgm 정지

		audio.play(warningSound)

		-- ******************경고음 무한 재생 코드*********************
		-- *********무한 재생할 시 아래 코드 주석 해제해서 사용**********
		
		-- composer.gotoScene() 하기 전에 audio.stop() 필수

		-- audio.play(warningSound, { channel = 1, loops = -1 })
	end

	
	local function nextScript( event )
		composer.setVariable("loginNumber", number)

		if number == 3 then
			composer.gotoScene("login_death")
		end
		composer.hideOverlay("login_script")
	end
	chatBox:addEventListener("tap", nextScript)


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
		composer.removeScene( "login_script" )
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
