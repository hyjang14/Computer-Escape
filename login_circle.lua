-----------------------------------------------------------------------------------------
--
-- login_circle.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImageRect("image/네이버 로그인/circle_bg.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local exit = display.newRect(display.contentWidth*0.969, display.contentHeight * 0.043, 63, 55)
    exit:setFillColor(1, 0, 0)
    exit.alpha = 0.01

	--색깔 원 그룹 
	local object = {}
	local bound = {}

	object[1] = display.newCircle(display.contentWidth*0.299, display.contentHeight*0.802, 91, 91)
	object[1]:setFillColor(0.5, 1, 1) 
	object[1].number = 1
	object[1]:scale(0.65, 0.65)
	object[1].alpha = 0.01

	bound[1] = display.newCircle(display.contentWidth*0.3, display.contentHeight*0.802, 91, 91)
    bound[1]:setFillColor(0, 0, 0, 0) 
    bound[1]:setStrokeColor(0, 0, 0)    -- 기본 태두리 색상
    bound[1].strokeWidth = 10
    bound[1]:scale(0.65, 0.65)
    bound[1].alpha = 0

	object[2] = display.newCircle(display.contentWidth*0.4, display.contentHeight*0.802, 91, 91)
	object[2]:setFillColor(0, 1, 0) 
	object[2].number = 2
	object[2]:scale(0.65, 0.65)
	object[2].alpha = 0.01

	bound[2] = display.newCircle(display.contentWidth*0.4, display.contentHeight*0.802, 91, 91)
    bound[2]:setFillColor(0, 0, 0, 0) 
    bound[2]:setStrokeColor(0, 0, 0)    -- 기본 태두리 색상
    bound[2].strokeWidth = 10
    bound[2]:scale(0.65, 0.65)
    bound[2].alpha = 0

	object[3] = display.newCircle(display.contentWidth*0.5, display.contentHeight*0.802, 91, 91)
	object[3]:setFillColor(1, 1, 0) 
	object[3].number = 3
	object[3]:scale(0.65, 0.65)
	object[3].alpha = 0.01

	bound[3] = display.newCircle(display.contentWidth*0.5, display.contentHeight*0.802, 91, 91)
    bound[3]:setFillColor(0, 0, 0, 0) 
    bound[3]:setStrokeColor(0, 0, 0)   -- 기본 태두리 색상
    bound[3].strokeWidth = 10
    bound[3]:scale(0.65, 0.65)
    bound[3].alpha = 0

	object[4] = display.newCircle(display.contentWidth*0.6, display.contentHeight*0.802, 91, 91)
	object[4]:setFillColor(1, 0, 0) 
	object[4].number = 4
	object[4]:scale(0.65, 0.65)
	object[4].alpha = 0.01

	bound[4] = display.newCircle(display.contentWidth*0.6, display.contentHeight*0.802, 91, 91)
    bound[4]:setFillColor(0, 0, 0, 0) 
    bound[4]:setStrokeColor(0, 0, 0)   -- 기본 태두리 색상
    bound[4].strokeWidth = 10
    bound[4]:scale(0.65, 0.65)
    bound[4].alpha = 0

	object[5] = display.newCircle(display.contentWidth*0.7, display.contentHeight*0.802, 91, 91)
	object[5]:setFillColor(1, 0.8, 0) 
	object[5].number = 5
	object[5]:scale(0.65, 0.65)
	object[5].alpha = 0.01

	bound[5] = display.newCircle(display.contentWidth*0.7, display.contentHeight*0.802, 91, 91)
    bound[5]:setFillColor(0, 0, 0, 0) 
    bound[5]:setStrokeColor(0, 0, 0)   -- 기본 태두리 색상
    bound[5].strokeWidth = 10
    bound[5]:scale(0.65, 0.65)
    bound[5].alpha = 0

	--하얀 원
	baseCircle = display.newCircle(display.contentWidth*0.5, display.contentHeight*0.619, 73, 75)
	baseCircle:setFillColor(0.9, 0.9, 0.9) 
	baseCircle.number = 0
	baseCircle.alpha = 0.01
	baseCircle:scale(1.22, 1.22)

	--문제 원 그룹 
	local prob = {}

	prob[1] = display.newImage("image/네이버 로그인/circle1.png", display.contentWidth*0.5, display.contentHeight*0.619, 50, 50)
	prob[1].number = 1
	prob[1]:scale(1.3, 1.3)
	prob[1].alpha = 0

	prob[2] = display.newImage("image/네이버 로그인/circle2.png", display.contentWidth*0.5, display.contentHeight*0.619, 50, 50)
	prob[2].number = 2
	prob[2]:scale(1.3, 1.3)
	prob[2].alpha = 0

	prob[3] = display.newImage("image/네이버 로그인/circle3.png", display.contentWidth*0.5, display.contentHeight*0.619, 50, 50)
	prob[3].number = 3
	prob[3]:scale(1.3, 1.3)
	prob[3].alpha = 0

	prob[4] = display.newImage("image/네이버 로그인/circle4.png", display.contentWidth*0.5, display.contentHeight*0.619, 50, 50)
	prob[4].number = 4
	prob[4]:scale(1.3, 1.3)
	prob[4].alpha = 0

	prob[5] = display.newImage("image/네이버 로그인/circle5.png", display.contentWidth*0.5, display.contentHeight*0.619, 50, 50)
	prob[5].number = 5
	prob[5]:scale(1.3, 1.3)
	prob[5].alpha = 0

	sceneGroup:insert(background)
	sceneGroup:insert(exit)
	sceneGroup:insert(baseCircle)

	for i = 1, 5 do
	    sceneGroup:insert(object[i])
	end
	for i = 1, 5 do
	    sceneGroup:insert(prob[i])
	end
	for i = 1, 5 do
	    sceneGroup:insert(bound[i])
	end

	local function tapCircle() 
		baseCircle.alpha = 0

		for i = 1, 5 do
			prob[i].alpha = 0
		end

		--랜덤 숫자 생성
		local num = {}

		for i = 1, 5 do
			num[i] = math.random(5)
			print(num[i])
		end

		--눌린 원이랑 맞는지 정답 채크하는 함수 
		local function checkAnswer()

        	for i = 1, 5 do
            	if selectedOrder[i] ~= num[i] then
                	print("틀렸다!")

                	local wrong = display.newText("틀렸습니다. 다시 시도해보세요.", display.contentWidth*0.7, display.contentHeight*0.615)
		        	wrong.size = 40
					wrong:setFillColor(1, 0, 0)
					wrong.alpha = 1
					sceneGroup:insert(wrong)

					local function hideText()
                		wrong.isVisible = false 
            		end

            		timer.performWithDelay(2000, hideText) 

            		--경고음 
            		audio.play(warningSound_short)
            		baseCircle.alpha = 0.01

                	return 
            	end
        	end
        		
        	print("정답입니다!")
        	for i = 1, 5 do
				display.remove(object[i])
		        --object[i]:removeEventListener("touch", onCircleTouch)
		    end

        	composer.removeScene('login_circle') 
        	composer.gotoScene('login_hint')
    	end

		local function showCircles()
			for i = 1, 5 do
    			prob[i].alpha = 1
			end

			print("원 이벤트를 실행합니다.")
		end

		-- 원 깜빡이는 애니메이션
		for i = 1, 5 do
    		local function setAlphaToZero()
        		prob[num[i]].alpha = 0 
    		end

    		local function setAlphaToOne()
        		prob[num[i]].alpha = 1 
        		timer.performWithDelay(200, setAlphaToZero) 
    		end

    		timer.performWithDelay((i) * 1000, setAlphaToOne) 
		end

		timer.performWithDelay(6000, function()
		
		local selectedIndex = 1
		selectedOrder = {} 

		local function hideBorder(circle)
		    circle.alpha = 0
		end

		--원 터치 이벤트 
		local function onCircleTouch(event)

			local selectedNum = event.target.number 

			if event.phase == "ended" and selectedIndex <= 5 then
            	selectedOrder[selectedIndex] = selectedNum 
            	selectedIndex = selectedIndex + 1
            	print(selectedNum)
            	bound[selectedNum].alpha = 1
		        
		        -- 일정 시간이 지난 후에 테두리 숨기기
		        timer.performWithDelay(150, function()
		            hideBorder(bound[selectedNum])
		        end)

                -- 모든 원을 선택한 경우, 정답을 판별
                if selectedIndex > 5 then
                    checkAnswer()
                end
        	end
   	 	end

    	for i = 1, 5 do
        	object[i]:addEventListener("touch", onCircleTouch)
    	end
		end)
	end
	
	baseCircle:addEventListener("tap", tapCircle)

	function back()
		baseCircle:removeEventListener("touch", tapCircle)
		display.remove(baseCircle)

		for i = 1, 5 do
			display.remove(object[i])
            --object[i]:removeEventListener("touch", onCircleTouch)
        end

		composer.removeScene('login_circle') 
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
		composer.removeScene('login_circle') 
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
