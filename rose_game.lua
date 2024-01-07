-----------------------------------------------------------------------------------------
--
-- rose_game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local function loadWaterSound()
	audio.play(wateringSound)
    print("물줌")
end
local function loadWitherSound()
	audio.play(witheringSound)
    print("시듦")
end
local function loadMoveSound()
	audio.play(movingSound)
    print("확인")
end
local function loadBugSound()
    audio.play(debuggingSound)
    print("벌레의 공격")
end

local function loadKillBugSound()
    audio.play(killBugSound)
    print("벌레 죽임")
end

--변수선언 ---------------------------------------------------------------------
local background
local memo --메모
local bigMemo = display.newImageRect("image/오브제/rose_memo.png", 1300,700)
bigMemo.x, bigMemo.y = display.contentCenterX, display.contentCenterY
bigMemo.alpha = 0
--기본 오브제
local pi
local pi2
local roseGroup
local rose = {}
local glass
local box
local pot
local bugL = display.newImageRect("image/오브제/bug_left.png", 300,200) 
bugL.alpha = 0
local bugR = display.newImageRect("image/오브제/bug_right.png", 300,200) 
bugR.alpha = 0

local boxText--박스 말풍선
local tapToStart
--setting
local gameTime = 50
local bugSpeed = 2
local gameStarted = false

local timeText --남은시간: ~

local gameTimer

local bugTimer
local roseTimer
local checkTimer

--상태확인
local isThirsty = false
local isAttacted = false
local isWorried = false

local isDied = false
--상태타이머
local wiltedTime = 0 --시든지 얼마나됐나
local worriedTime = 0 --걱정한지 얼마나됐나

--장미 함수 ---------------------------------------------------------------------------------

local function wither() --4초자동 무한루프
    loadWitherSound()
    rose[1].alpha = 0
    rose[2].alpha = 1
    isThirsty = true
end
local function healthy()
    rose[1].alpha = 1
    rose[2].alpha = 0
end

local function startWorry() --9초자동 무한루프
    boxText.alpha= 1
    isWorried = true
end
-- game_over함수 -----------------------------------------------------------------------------
local function game_over()

    gameStarted = false
    rose[2].alpha = 0
    rose[3].alpha = 1
    timer.cancel(roseTimer)
    timer.cancel(bugTimer)
    timer.cancel(checkTimer)
    timer.cancel(gameTimer)
        
    local function goToNextScene()
        local options = {
            effect = "fade", 
            time = 2000 
        }
        audio.pause(4)
        audio.resume(2)
        display.remove(bugL)
        display.remove(bugR)
        composer.setVariable("gameOverNumber", 4)
        composer.removeScene("rose_game", options)
        composer.gotoScene("gameOver", options)
    end
    goToNextScene()
end

--벌레 함수 -------------------------------------------------------------------------
local function createBug()

    --왼/오 랜덤결정
    local side = math.random(1,2) == 1 and "left" or "right" 
    --생성 위치에 따라 벌레 생성
    if side == "left" then 

        bugL.alpha = 1
        bugL.x, bugL.y = display.contentWidth*0.3, display.contentHeight/2+300

        transition.to(bugL, {
            x = display.contentWidth/2 - 150, -- 오른쪽으로 이동할 위치
            time = 2000, -- 이동하는 시간

            onComplete = function() --이동 완료 시,  
                if (bugL.alpha == 1) then --아직도 살아있으면,
                    wither()
                    isAttacted = true
                    timer.performWithDelay(1000,loadBugSound, 2) --갉아먹는소리
                end
            end
        })

    else 
        
        bugR.alpha = 1 
        bugR.x, bugR.y = display.contentWidth*0.7, display.contentHeight/2+300

        transition.to(bugR, {
            x = display.contentWidth/2 + 150, -- 왼쪽으로 이동할 위치
            time = 2000, -- 이동하는 시간

            onComplete = function() --이동 완료 시, 
                if (bugR.alpha == 1) then --아직도 살아있으면,
                    wither()
                    isAttacted = true
                    timer.performWithDelay(1000,loadBugSound, 2) --갉아먹는소리
                end
            end
        })
    end
    
end
--터치 제거 이벤트----------------------------------------------------
local function onBugLTouch(event) --벌레 터치 시 제거하기
    if event.phase == "ended" then
        print("벌레 터치")
        loadKillBugSound()
        bugL.alpha = 0
        if bugR.alpha == 0 and bugL.alpha == 0 then
            isAttacted = false
        end
    end
end
local function onBugRTouch(event)
    if event.phase == "ended" then
        print("벌레 터치")
        loadKillBugSound()
        bugR.alpha = 0

        if bugR.alpha == 0 and bugL.alpha == 0 then
            isAttacted = false
        end
    end
end

---------------------------------------------------------------
bugR:addEventListener("touch", onBugRTouch) --터치하면 제거됨
bugL:addEventListener("touch", onBugLTouch) --터치하면 제거됨




--물뿌리개 함수 --------------------------------------------------------------------------------

--물주는 애니메이션 함수 ----------
local function watering(object)

    transition.to(object, {
        
        rotation = -90,  -- 왼쪽으로 90도 회전
        time = 500, --회전시간
    
        onComplete = function() --회전완료하면,
            -- 기울인 상태로 1초간 유지하기
            timer.performWithDelay(500, function()
                transition.to(object, {
                    rotation = 0,  -- 초기 회전 상태로 복귀
                    time = 500
                    })
                end
            )
        end
    })
end

--드래그 이벤트 함수 --------------
local function onPotTouch(event) --드래그해서 장미에 놓으면, 물완료,장미정상 이벤트
    
    if( event.phase == "began" ) then
        display.getCurrentStage():setFocus( event.target )
        event.target.isFocus = true
        -- 드래그 시작할 때

        event.target.x0 = event.target.x
        event.target.y0 = event.target.y

    elseif( event.phase == "moved" ) then
        
        if ( event.target.isFocus ) then
            -- 드래그 중일 때
            local newX = event.target.x0 + event.x - event.xStart
            local newY = event.target.y0 + event.y - event.yStart
			event.target.x = newX
            event.target.y = newY
        end

    elseif ( event.phase == "ended" or event.phase == "cancelled") then
        if ( event.target.isFocus ) then
            display.getCurrentStage():setFocus( nil )
            event.target.isFocus = false

            if ( event.target.x > display.contentCenterX - 150 and event.target.x < display.contentCenterX + 150
 					and event.target.y > display.contentCenterY - 150 and event.target.y < display.contentCenterY + 150
                    and isThirsty == true) then -- 해당범위안에 드래그 놓았을때 && 장미가 목마름 상태일때,

                    watering(pot) --물주는 애니메이션
                    loadWaterSound() --물주는 효과음

                    event.target.x = event.target.x0
					event.target.y = event.target.y0
                    isThirsty = false --장미 정상화 스위치
                    healthy()
            else --장미 위 아니면,
                event.target.x = event.target.x0
				event.target.y = event.target.y0
 			end

        else
            display.getCurrentStage():setFocus( nil )
            event.target.isFocus = false
        end

    end
end




--C H E C K-------------------------------------------------------------

--CHECK isAttacted 상태 감지 >> 장미 목마름상태로 변경
local function checkAttacted()
    if isAttacted then
        isThirsty = true
    end
end

--CHECK isWorried 시간 감지
local function checkWorried() --1초마다 / if isWorried, 카운트3초
    if isWorried then
        worriedTime = worriedTime + 1
        
        if (worriedTime >= 4) then
            print("게임 시간 10초 추가")
            gameTime = gameTime + 10
            boxText.alpha = 0
            isWorried = false
        end

    else
        worriedTime = 0
    end

end

--CHECK isThirsty 시간 감지
local function checkThirsty() --1초마다 / if isThirsty, 카운트3초 , 
    if isThristy or rose[2].alpha == 1 then
        wiltedTime = wiltedTime + 1
        
        if (wiltedTime >= 5) then
            print("방치했다.. 게임오버")
            game_over()
        end

    else
        wiltedTime = 0
    end
end


------------------------------------------------------------------------



--상자 함수-------------------------------------------------------------------------------------

--상자_파이 이벤트함수 ------------------------------------------
local function box_pi()

    local initX = 960
    local initY = 1100
    --파이 원위치로
    local function removePi() 
        pi.x, pi.y = initX, initY
    end
        --파이 이동+원위치 애니메이션
    transition.to(pi, { 
        x = display.contentWidth*0.14, 
        y = display.contentHeight*0.4,
        time = 500, -- 이동하는 시간
        onComplete = function()
            timer.performWithDelay(1500, removePi)
        end
    })
    
end


--상자 함수 -----------------------------------------------------
local function onBoxTouch(event) --박스 터치시, 이벤트
    if event.phase == "ended" or event.phase == "canceled" then
    
        boxText.alpha = 0
        isWorried = false
        box_pi()
        
    end
end



--유리덮개사라질때 애니메이션 -------------------------------------------
local function removeObjAnimation(obj)
    transition.to ( obj, {
        alpha = 0,
        time = 500,
        onComplete = function()
            display.remove(obj)
        end
    })
end
--메모 확대 축소 -------------------------------------------------------
local function helloMemo(event)
    bigMemo.alpha = 1
end

local function byeMemo(event)
    bigMemo.alpha = 0
end




--메인 함수 -----------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view
    --배경
	background = display.newImageRect("image/background2.png",1850, 1100)
    background.x, background.y = display.contentCenterX, display.contentCenterY
    --메모
    memo = display.newImageRect("image/오브제/rose_memo.png", 300,200)
	memo.x, memo.y = display.contentWidth/2+600, display.contentHeight*0.12
    --파이
    pi = display.newImageRect("image/캐릭터/pixil(뒤)-0.png", 450,450)
    pi.x, pi.y = 960,1100
    pi.alpha = 1
    --유리덮개장미
    glass = display.newImageRect("image/오브제/rose0_glass.png", 700,900)
    glass.x, glass.y = display.contentCenterX, display.contentCenterY-20
    --터치해서 시작
    tapToStart = display.newText({
        text = "START", -- 표시할 텍스트
        x = display.contentCenterX + 23, -- x 좌표
        y = display.contentCenterY + 500, -- y 좌표
        width = 2100, -- 텍스트 영역의 가로 크기
        height = 1100, -- 텍스트 영역의 세로 크기
        font = "font/PF스타더스트.ttf", -- 사용할 폰트
        fontSize = 70, -- 폰트 크기
        align = "center" -- 정렬 방식 ("left", "center", "right")
    })
     --장미
    roseGroup = display.newGroup()
    for i = 1, 3 do
        rose[i] = display.newImageRect("image/오브제/rose"..(i-1)..".png", 700, 900)
        rose[i].x, rose[i].y = display.contentCenterX, display.contentCenterY
        rose[i].alpha = 0
        roseGroup:insert(rose[i])
	end
    --상자
    box = display.newImageRect("image/오브제/box2.png", 680,680)
    box.x, box.y = display.contentWidth*0.13, display.contentHeight*0.36
    --주전자
    pot = display.newImageRect("image/오브제/pot.png", 400,320)
    pot.x, pot.y = display.contentWidth*0.86, display.contentHeight*0.4
    --박스_말풍선
    boxText = display.newImageRect("image/오브제/checkSheep.png", 300, 270)
    boxText.x , boxText.y = display.contentWidth*0.61, display.contentHeight*0.2
    boxText.alpha = 0
    --게임남은시간
    timeText=  display.newText("", display.contentWidth*0.1, display.contentHeight*0.05)
    timeText.size = 70
    timeText:setFillColor(0)
    timeText.alpha = 0.8
    timeText = display.newText({
        text = "",
        x = display.contentWidth*0.85,
        y = display.contentHeight*0.1,
        font = "font/PF스타더스트.ttf", 
        fontSize = 80
    })

    sceneGroup:insert(background)
    sceneGroup:insert(memo)
    sceneGroup:insert(roseGroup)
    sceneGroup:insert(glass)
    sceneGroup:insert(box)
    sceneGroup:insert(pot)
    sceneGroup:insert(pi)
    sceneGroup:insert(boxText)
    sceneGroup:insert(timeText)
    sceneGroup:insert(tapToStart)

    --start game- (유리덮개 누르면 게임시작)---------------------------------------------------------
    local function onTouchStart(event)
        if not gameStarted then
            removeObjAnimation(glass)
            glass.alpha = 0
            memo.alpha = 0
            bigMemo.alpha = 0
            display.remove(tapToStart)
            rose[1].alpha = 1
            gameStarted = true --GAME _ START  POINT *****
        end
    end
    
    --시간업데이트 함수 ------------------------------------------------------------------------------
    local function updateTime()
        if (gameTime > -1) then
            gameTime = gameTime - 1
            print(gameTime)
        end

        timeText.text = "time: " .. gameTime
        if (gameTime <= 0) then --깨면
            gameStarted = false
            local function goToNextScene()
                local options = {
                    effect = "fade", 
                    time = 2000 
                }
                display.remove(bugL)
                display.remove(bugR)
                timer.cancel(roseTimer)
                timer.cancel(bugTimer)
                timer.cancel(checkTimer)
                timer.cancel(gameTimer)
                Runtime:removeEventListener("enterFrame", isGameStarted)

                composer.removeScene("rose_game",options)
                composer.gotoScene("rose_outro_dialog", options)
            end 
            goToNextScene()    
        end
    end


    --게임루프함수 (타이머돌리기)
    local function gameLoop() --1초마다 감지
        updateTime() --시간 업데이트
        
        checkAttacted() --isAttacted감지 >목마름유지
        checkWorried() --isWorried감지 >3초:게임시간+10
        checkThirsty() --isThirsty감지 >3초:게임오버
        
    end


    --게임시작됐는지 runtime확인함수
    local function isGameStarted(event)
        
        if not gameStarted then
            if (bigMemo.alpha == 1) then
                glass.alpha = 0
            elseif(bigMemo.alpha == 0) then
                glass.alpha = 1
            end
        end

        if gameStarted and not isDied then
            Runtime:removeEventListener("enterFrame", isGameStarted) --한번시작하면 runtime감지 끝내기
            --1초마다 체크루프
            gameTimer = timer.performWithDelay(1000, gameLoop, 0) --1초마다 게임오버/시간업뎃
            --이벤트 생성루프
            roseTimer = timer.performWithDelay(4000, wither, 0) --4초마다 시들기
            bugTimer = timer.performWithDelay(7000, createBug, 0) --7초마다 벌레생성
            checkTimer = timer.performWithDelay(9000, startWorry, 0) --9초마다 양 확인
        end
    end
    memo:addEventListener("tap", helloMemo)
    bigMemo:addEventListener("tap", byeMemo)

    pot:addEventListener("touch", onPotTouch) --pot 물주는 터치이벤트
    box:addEventListener("touch", onBoxTouch) --box 파이이동, 체크완료 터치이벤트
	
    glass:addEventListener("tap", onTouchStart) --유리덮개 누르면 게임시작

    Runtime:addEventListener("enterFrame", isGameStarted)
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
        
        
	elseif phase == "did" then
		-- Called when the scene is now on screen
        --timer.performWithDelay(1000, updateTimer, gameTime) --남은시간타이머
	end	
end


function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
        
        --Runtime:addEventListener("enterFrame", updateTime)
        timer.cancel(roseTimer)
        timer.cancel(bugTimer)
        timer.cancel(checkTimer)
        timer.cancel(gameTimer)

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