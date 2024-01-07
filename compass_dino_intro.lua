-----------------------------------------------------------------------------------------
--
-- dino_intro.lua
-- : 윈도우 터치-> 파이느낌표->파이이동->디노토크->말풍선 터치시 화면암전 후 본게임파일로
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--창(배경)
	local window = display.newImageRect("image/디노/DINO_window_.png", display.contentWidth, display.contentHeight)
	window.x, window.y = display.contentCenterX, display.contentCenterY
	--게임칸
	local background = display.newImageRect("image/디노/game_background.png", 1500,450)
	background.x, background.y =  display.contentWidth/2, display.contentHeight*0.41
	background:setFillColor(1)
	--작업표시줄
	local window_bar = display.newImage("image/UI/하단바 와이파이 오프.png")
	window_bar.x, window_bar.y = display.contentCenterX, display.contentHeight*0.968
	
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

	local exit = display.newRect(display.contentWidth*0.958, display.contentHeight * 0.043, 120, 60)
    exit:setFillColor(1, 0, 0)
    exit.alpha = 0.01

	local num = composer.getVariable("sceneNum")
	-- 나가기
	local function go (event)
		if(num == 1) then
			composer.gotoScene("compass_computerScreen")
		else
			composer.gotoScene("compass_trashcan")
		end
	end
	exit:addEventListener("tap", go)

    -- ↑ 시간 -------------------------------------------------------------------------------------------------
	--오브제들
	local ground
	local pi
	local dino

	local oh--느낌표
	local balloon--말풍선
	local font--폰트
	local ok--수락버튼
	local dinoText --디노텍스트
	local loading --로딩아이콘
	

	sceneGroup:insert( window )
	sceneGroup:insert( background )
	sceneGroup:insert(window_bar)
	sceneGroup:insert(hourText)
    sceneGroup:insert(minuteText)
	sceneGroup:insert(text)
	sceneGroup:insert(exit)

	--게임 인트로----------------------------------------------------------------------------------
	
	--왼쪽이동시 이미지변경용(구현아직못함)--------------------------------------------------
	local sideImages = {
		"pixil(왼)-0.png",
		"pixil(왼)-1.png",
		"pixil(왼)-2.png",
		"pixil(왼)-3.png"
	}
	--이미지모션변경함수
	local currentSide = 1
	local function changeMotionImage()
		local nextSide = currentSide + 1
		if nextSide > #sideImages then --다음모션 인덱스 1~4 반복하기
			nextSide = 1
		end
		pi.fill = {type = "image", filename = sideImages[currenSide]}
	end	
	-----------------------------------------------------------------------
	--파이_왼쪽이동함수
	local function moveLeft()
		--파이: 2초간, x축 -1000px 이동

		transition.to(pi, {
			time = 1000,
			x = pi.x - 400,
			onComplete = function() --끝나면
				pi.x = display.contentWidth*0.8 - 1000
				ok.x, ok.y = pi.x + 100, pi.y - 80
				ok.alpha = 1
			end	
		})	
	end
	--------------------------------------------------------------------------
	--디노 talk

	local function dinoTalk()
		--말풍선
		balloon = display.newImageRect("image/디노/balloon.png", 500, 280)
		balloon.x, balloon.y = display.contentWidth*0.2, display.contentHeight*0.3
		sceneGroup:insert( balloon )
		--느낌표
		oh = display.newImageRect("image/디노/oh.png", 40,60)
		oh.x, oh.y = pi.x + 60, pi.y - 50
		oh.alpha = 0
		sceneGroup:insert( oh )
		--수락버튼
		ok = display.newImageRect("image/디노/ok.png", 150, 105)
		ok.x, ok.y = pi.x + 100, pi.y - 80
		ok.alpha = 0
		sceneGroup:insert( ok )

		--텍스트설정
		local textOptions = {
            text = "살... 빼고싶어!! \n도와줘!!!",
            x = balloon.x,
            y = balloon.y,
            width = balloon.width - 20, -- 말풍선 내부 폭에 맞게 조절
            font = font_Content,
            fontSize = 60,
            align = "center"
        }
		dinoText = display.newText(textOptions) --디노텍스트 객체생성
		dinoText:setFillColor(0)
		sceneGroup:insert(dinoText)

		local typingSpeed = 70 --글자당 밀리초
		
		local function typeText(index) --타이핑애니메이션효과
            local textToShow = textOptions.text:sub(1, index)
            dinoText.text = textToShow

            if index <= #textOptions.text then
                timer.performWithDelay(typingSpeed, 
					function()
                    	typeText(index + 1) --1~text길이만큼 타이핑딜레이주면서 한글자씩 나타내기
                	end
					
				)
				if index == #textOptions.text and pi.x == display.contentCenterX then
					oh.alpha = 0.7	--디노말 끝날때까지 터치x시, 파이옆 느낌표
				end
            end
        end
		typeText(1) --타이핑애니메이션 시작

	end

	
	
	--수락버튼 이벤트-----------------------------------------------------------------------
	local function nextScene()
		
	 	composer.gotoScene("dino_game", options) --options뒤에 test.lua로 이동
	end
	
	local function rotateLoading() -- 로딩창 회전시키는 함수
		transition.to(loading, {
			rotation = loading.rotation + 720, --2바퀴 회전
			x = display.contentCenterX,
			y = display.contentCenterY,
			time = 3000, --3초간
			onComplete = nextScene --회전끝나면, nextScene함수로 이동
			}
		)
	end
	
	local function okTap(event) --(수락버튼 이벤트함수)로딩창 뜨고 본게임으로 씬 넘기기
		
		display.remove(ok)
		display.remove(balloon)
		display.remove(dinoText)
		pi.fill = {type = "image", filename = "image/캐릭터/pixil(앞)-0.png"}

		loading = display.newImageRect("image/로딩창/loading.png", 160, 160)
		loading.x, loading.y = display.contentCenterX, display.contentCenterY
		sceneGroup:insert( loading )

		rotateLoading()
	end
	
	--main------------------------------------------------------------------------

	--파이 탭 이벤트함수
	local function piTap (event)
		

		if event.phase == "began" then --파이 탭하면
			display.remove(oh) --느낌표 삭제
			oh = nil
			moveLeft() --파이가 왼쪽이동
		elseif event.phase == "ended" then --끝나면
			pi:removeEventListener("touch", piTap) --이벤트 제거
			
		end
	end


	--인트로 메인함수
	local function introGame()
		--지면
		ground = display.newRect(display.contentWidth*0.2, display.contentHeight*0.5, 180,5)
		ground:setFillColor(0)
		--디노
		dino = display.newImageRect("image/디노/디노0.png", 120,120)
		dino.x , dino.y = display.contentWidth*0.2, display.contentHeight*0.45
		--파이
		pi = display.newImageRect("image/캐릭터/pixil(왼)-0.png", 120, 120)
		pi.x, pi.y = display.contentWidth*0.5, display.contentHeight*0.45
		
		sceneGroup:insert( ground )
		sceneGroup:insert( dino )
		sceneGroup:insert( pi )
		

		dinoTalk()
		pi:addEventListener("touch", piTap)
		ok:addEventListener("tap", okTap)
		
	end
	

	--게임시작
    introGame()
	--터치하면 파이 움직이고 디노의 대사가 나온 후 암전되고 게임화면으로 돌아가기
	
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
		composer.removeScene("compass_dino_intro")

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