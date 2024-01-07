-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view

	audio.setVolume( 0.3, { channel=6 } )
	
	--배경
	local background = display.newImageRect("image/시작화면2_2.png", 1920,1080)
	background.x, background.y = display.contentCenterX, display.contentCenterY
	--시작하기버튼
	local startButton = display.newImageRect("image/start.png", 500, 120)
	startButton.x, startButton.y = display.contentWidth*0.42, display.contentHeight*0.54
	--끝내기버튼
	local quitButton = display.newImageRect("image/quit.png", 280, 110)
	quitButton.x, quitButton.y = display.contentWidth*0.365, display.contentHeight*0.62
	--제목
	local textOptions = {
		text = "COMPUTER ".." \t ".." ESCAPE",
		x = display.contentWidth*0.435,
		y = display.contentHeight*0.35,
		font = "font/PF스타더스트.ttf", -- 폰트 경로 지정
		fontSize = 80,
		align = "left"
	}
	local textObject= display.newText(textOptions)
	textObject:setFillColor(1)

	-- ↓ 시간 -------------------------------------------------------------------------------------------------

    local hour = os.date( "%I" )
    local minute = os.date( "%M" )

    local hourText = display.newText(hour, display.contentWidth*0.784, display.contentHeight*0.79, font_Speaker)
    hourText.size = 45
    hourText:setFillColor(0)

    local minuteText = display.newText(minute, display.contentWidth*0.829, display.contentHeight*0.79, font_Speaker)
    minuteText.size = 45
    minuteText:setFillColor(0)

    local text = display.newText(":", display.contentWidth*0.808, display.contentHeight*0.783, font_Speaker)
    text.size = 80
    text:setFillColor(0)
    sceneGroup:insert(text)

    local function counter( event )
        hour = os.date( "%I" )
        hourText.text = hour
        minute = os.date( "%M" )
        minuteText.text = minute
    end

    timer.performWithDelay(1000, counter, -1)

    

    -- ↑ 시간 -------------------------------------------------------------------------------------------------

	sceneGroup:insert(background)
	sceneGroup:insert(startButton)
	sceneGroup:insert(quitButton)
	sceneGroup:insert(textObject)
	
	sceneGroup:insert(hourText)
    sceneGroup:insert(minuteText)
	sceneGroup:insert(text)

	--제목_ typing 애니메이션------------------------------------------------------------------------
	local typingSpeed = 200 --글자당 밀리초

	local function createTextObj()
		textObject= display.newText(textOptions)
		textObject:setFillColor(1)
	end
		
	local function typeText(index) --타이핑애니메이션효과

        local textToShow = textOptions.text:sub(1, index)
        textObject.text = textToShow

        if index <= #textOptions.text then
            timer.performWithDelay(typingSpeed, 
				function()
                	typeText(index + 1) --1~text길이만큼 타이핑딜레이주면서 한글자씩 나타내기
            	end	
			)
			if index == #textOptions.text then --text글자수만큼 애니메이션 한바퀴 끝나면,
				
				local function gotoSceneWithDelay(event) --3초마다 제목display없애고 재생성후 애니메이션 다시
					display.remove(textObject)--지우고
					createTextObj()--재생성하고
					typeText(1) --재귀
				end
				timer.performWithDelay(3000, gotoSceneWithDelay) --3초후 gotoSceneWithDelay() 호출
			end
        end
    end
	typeText(1) --타이핑애니메이션 시작
	-------------------------------------------------------------------------------------------------


	--게임 시작 함수 ----------------------------------------------------------------------------------
	local function startGame(event) --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
		print("게임시작")
		
		local function deleteText(event)
			textObject.alpha = 0
			display.remove(textObject)
		end

		transition.to(textObject, {time = 1500, alpha = 0, onComplete = deleteText})
		--timer.performWithDelay(1500, display.remove(textObject))

		audio.play(insertItem)
		audio.pause(6)
		timer.cancelAll()
		composer.gotoScene("startVideo1", { effect = "fade" , time = 1500}) -->>시작 파일명 적어주세요!!
	end
	--------------------------------------------------------------------------------------------------


	--프로그램 종료 함수 ------------------------------------------------------------------------------
	local function exitProgram(event)
		if event.phase == "began" then
			if system.getInfo("platformName") == "Win" or system.getInfo("platformName") == "Mac OS X" then
				-- 윈도우 및 macOS에서는 시뮬레이터를 종료할 수 없음
				print("프로그램을 종료할 수 없습니다.")
				audio.play(insertItem)
			else
				-- 기기에서 실행 중인 경우 프로그램 종료
				os.exit(0)
				audio.play(insertItem)
				audio.pause(6)
			end
		end	
		


	end
	--------------------------------------------------------------------------------------------------

	startButton:addEventListener("tap", startGame)
	quitButton:addEventListener("touch", exitProgram)
	
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
		display.remove(textObject)
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		composer.removeScene("start2")
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
