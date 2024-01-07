-----------------------------------------------------------------------------------------
--
-- picgame_start.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local sound_artist_memo1 = audio.loadSound("sound/종이 넘기는 소리 1.mp3")
    local sound_artist_memo2 = audio.loadSound("sound/종이 넘기는 소리 2.mp3")
    local buttonSound = buttonSound
    local buttonSound1 = buttonSound1 
    local buttonSound2 = buttonSound2
    local wrongSound = wrongSound

    audio.play(sound_artist_memo2)

    -- Background
    local background = display.newImage("image/배경/배경_저택_예술가의방.png", display.contentCenterX, display.contentCenterY)
    sceneGroup:insert(background)

    local memo = display.newImageRect("image/UI/메모지.png", 60, 80)
    memo.x, memo.y = 450, 180
    memo.alpha = 0.7
    memo.name = "memo"

    local button = display.newImageRect("image/UI/버튼.png", 50, 50)
    button.x, button.y = 1535, 220
    sceneGroup:insert(button)

    -- Images
    local picGroup = display.newGroup()
    local pic = {}
    local framGroup = display.newGroup()
    local fram = {}

    pic[1] = display.newImageRect("image/artist/예술가의방 그림 H.png", 200, 150)
    pic[1].x, pic[1].y = 1450, 700
    pic[2] = display.newImageRect("image/artist/예술가의방 그림 U.png", pic[1].width, pic[1].height)
    pic[2].x, pic[2].y = 500, 650
    pic[3] = display.newImageRect("image/artist/예술가의방 그림 N.png", pic[1].width, pic[1].height)
    pic[3].x, pic[3].y = 850, 500
    pic[4] = display.newImageRect("image/artist/예술가의방 그림 T.png", pic[1].width, pic[1].height)
    pic[4].x, pic[4].y = 1100, 880

    fram[1] = display.newImageRect("image/artist/오브제 액자.png", 200, 200)
    fram[2] = display.newImageRect("image/artist/오브제 액자.png", 200, 200)
    fram[3] = display.newImageRect("image/artist/오브제 액자.png", 200, 200)
    fram[4] = display.newImageRect("image/artist/오브제 액자.png", 200, 200)


    for i = 1, 4 do
        picGroup:insert(pic[i])
        fram[i].x, fram[i].y = 645 + (i - 1) * 250, 180
        framGroup:insert(fram[i])
    end

    sceneGroup:insert(memo)
    sceneGroup:insert(framGroup)
    sceneGroup:insert(picGroup)

    -- ↓그림 선택지 ----------------------------------------------------------------------------

    local selGroup = display.newGroup()
    local sel = {}

    local numSets = 4

    for i = 1, numSets do
        local num = (i - 1) * 2 + 1
        
        sel[num] = display.newImageRect("image/UI/대답박스 분리.png", 150, 45)
        sel[num].alpha = 0
        
        sel[num + 1] = display.newImageRect("image/UI/대답박스 분리.png", 150, 45)
        sel[num + 1].alpha = 0
    end

    -- H
    sel[1].x, sel[1].y = 1375, 598
    sel[2].x, sel[2].y = 1530, 598
    -- U
    sel[3].x, sel[3].y = 425, 550
    sel[4].x, sel[4].y = 580, 550
    -- N
    sel[5].x, sel[5].y = 770, 400
    sel[6].x, sel[6].y = 925, 400
    -- T
    sel[7].x, sel[7].y = 1020, 780
    sel[8].x, sel[8].y = 1175, 780

    for i = 1, numSets do
        local num = (i - 1) * 2 + 1

        sel[num].label = display.newText("자세히 보기", sel[num].x, sel[num].y+2, font_Speaker, 25)
        sel[num].label:setFillColor(0)

        sel[num + 1].label = display.newText("들기", sel[num + 1].x, sel[num + 1].y+2, font_Speaker, 25)
        sel[num + 1].label:setFillColor(0)

        sel[num].label.alpha = 0
        sel[num + 1].label.alpha = 0
    end


    for i = 1, 8 do    
        selGroup:insert(sel[i])
        selGroup:insert(sel[i].label)
    end

    -- ↑그림 선택지 ----------------------------------------------------------------------------

    local talkGroup = display.newGroup()
    local talk = {}

    talk[1] = display.newImage("image/UI/대화창 ui.png")
    talk[1].x, talk[1].y = display.contentWidth/2, display.contentHeight * 0.78
    
    talk[1].label = display.newText("스위치를 누를까?", display.contentWidth/2, display.contentHeight*0.78, font_Speaker, 50)
    talk[1].label:setFillColor(0)

    talk[1].alpha = 0
    talk[1].label.alpha = 0

    talkGroup:insert(talk[1])
    talkGroup:insert(talk[1].label)

    local sel_buttonGroup = display.newGroup()
    local sel_button = {}

    sel_button[1] = display.newImageRect("image/UI/대답박스 분리.png", 240, 80)
    sel_button[1].x, sel_button[1].y = 1640, 560
    
    sel_button[1].label = display.newText("아직 아니야", sel_button[1].x, sel_button[1].y, font_Speaker, 40)
    sel_button[1].label:setFillColor(0)

    sel_button[1].alpha = 0
    sel_button[1].label.alpha = 0
    
    
    sel_button[2] = display.newImageRect("image/UI/대답박스 분리.png", 240, 80)
    sel_button[2].x, sel_button[2].y = 1640, 650
    
    sel_button[2].label = display.newText("누르자", sel_button[2].x, sel_button[2].y, font_Speaker, 40)
    sel_button[2].label:setFillColor(0)

    sel_button[2].alpha = 0
    sel_button[2].label.alpha = 0

    sel_buttonGroup:insert(sel_button[1])
    sel_buttonGroup:insert(sel_button[1].label)
    sel_buttonGroup:insert(sel_button[2])
    sel_buttonGroup:insert(sel_button[2].label)

    sceneGroup:insert(talkGroup)
    sceneGroup:insert(sel_buttonGroup)

    -- 조작키 --------------------------------------

	local not_interaction = display.newImageRect("image/UI/빈원형.png", 130, 130)
	not_interaction.x, not_interaction.y = 1740, 680
	--not_interaction.alpha = 0

    local cursor = display.newImage("image/UI/커서.png")
	cursor.x, cursor.y = 1560, 810 

    local newCursor = display.newImage("image/UI/커서.png")
    newCursor.x, newCursor.y = 1560, 810 
    newCursor.alpha = 0

    local fingerGroup = display.newGroup()
    local finger = {}

    finger[1] = display.newImage("image/UI/포인터.png")
	finger[1].x, finger[1].y = 1560, 810
    finger[1].alpha = 0

    finger[2] = display.newImage("image/UI/포인터.png")
	finger[2].x, finger[2].y = 1560, 810
    finger[2].alpha = 0

    finger[3] = display.newImage("image/UI/포인터.png")
	finger[3].x, finger[3].y = 1560, 810
    finger[3].alpha = 0

    finger[4] = display.newImage("image/UI/포인터.png")
	finger[4].x, finger[4].y = 1560, 810
    finger[4].alpha = 0

    finger[5] = display.newImage("image/UI/포인터.png")
	finger[5].x, finger[5].y = 1560, 810
    finger[5].alpha = 0

    finger[6] = display.newImage("image/UI/포인터.png")
	finger[6].x, finger[6].y = 1560, 810
    finger[6].alpha = 0

    for i = 1, 6 do
        fingerGroup:insert(finger[i])
    end

	local interaction = display.newImageRect("image/UI/변형.png", 130, 130)
	interaction.x, interaction.y = 1740, 680
	interaction.alpha = 0

    local inventory = display.newImage("image/UI/인벤토리.png")
    inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	-- ↓ 방향키 --------------------------------------

	local up = display.newImage("image/UI/콘솔(상).png")
	up.x, up.y = 330, 696
	up.name  = "up"
	up.alpha = 0.5

	local right = display.newImage("image/UI/콘솔(우).png")
	right.x, right.y = 443, 810
	right.name = "right"
	right.alpha = 0.5

	local left = display.newImage("image/UI/콘솔(좌).png")
	left.x, left.y = 217, 810
	left.name = "left"
	left.alpha = 0.5

	local down = display.newImage("image/UI/콘솔(하).png")
	down.x, down.y = 330, 924
	down.name = "down"
	down.alpha = 0.5

	--  -----------
	local stopUp = display.newImage("image/UI/상_스트로크.png")
	stopUp.x, stopUp.y = 330, 697

	local stopRight = display.newImage("image/UI/우_스트로크.png")
	stopRight.x, stopRight.y = 442, 810

	local stopLeft = display.newImage("image/UI/좌_스트로크.png")
	stopLeft.x, stopLeft.y = 218, 810

	local stopDown = display.newImage("image/UI/하_스트로크.png")
	stopDown.x, stopDown.y = 330, 923

    -- ↑ ui정리 -------------------------------------------------------------------------------------------------

    -- ↓ 플레이어 ---------------------------------------------------------------------------------------------------
	local playerGroup = display.newGroup()
	local player = {} 

	for i = 1, 4 do
		player[i] = {}
	end

	-- 앞
	for i = 1, 4 do
		player[1][i] = display.newImageRect("image/캐릭터/pixil(앞)-"..(i - 1)..".png", 120, 120)
		player[1][i].x, player[1][i].y = 450, 240
		player[1][i].alpha = 0

		playerGroup:insert(player[1][i])
	end
	-- 뒤
	for i = 1, 4 do
		player[2][i] = display.newImageRect("image/캐릭터/pixil(뒤)-"..(i - 1)..".png", 120, 120)
		player[2][i].x, player[2][i].y = 450, 240
		player[2][i].alpha = 0

		playerGroup:insert(player[2][i])
	end
	-- 왼쪽
	for i = 1, 4 do
		player[3][i] = display.newImageRect("image/캐릭터/pixil(왼)-"..(i - 1)..".png", 120, 120)
		player[3][i].x, player[3][i].y = 450, 240
		player[3][i].alpha = 0

		playerGroup:insert(player[3][i])
	end
	-- 오른쪽
	for i = 1, 4 do
		player[4][i] = display.newImageRect("image/캐릭터/pixil(오른)-"..(i - 1)..".png", 120, 120)
		player[4][i].x, player[4][i].y = 450, 240 
		player[4][i].alpha = 0

		playerGroup:insert(player[4][i])
	end

	sceneGroup:insert(playerGroup)

	player[1][1].alpha = 1 -- 처음 모습

	local locationX = 1200
	local locationY = 700

    
	sceneGroup:insert(cursor)
    sceneGroup:insert(newCursor)
	sceneGroup:insert(fingerGroup)
	sceneGroup:insert(not_interaction)
	sceneGroup:insert(interaction)
	sceneGroup:insert(inventory)
	sceneGroup:insert(question)

	sceneGroup:insert(up)
	sceneGroup:insert(right)
	sceneGroup:insert(left)
	sceneGroup:insert(down)
	sceneGroup:insert(stopUp)
	sceneGroup:insert(stopRight)
	sceneGroup:insert(stopLeft)
	sceneGroup:insert(stopDown)

    -- ↑ 플레이어 ---------------------------------------------------------------------------------------------------

    local selT1 = false
    local selT2 = false
    local selT3 = false
    local selT4 = false

    -- ↓ 플레이어 이동 함수 정리 -------------------------------------------------------------------------------------------------

    local movingDirection = nil
    local moveSpeed = 4

    local d = 0
    local motionUp = 1
    local motionDown = 1
    local motionRight = 1
    local motionLeft = 1

    local function moveCharacter(event)
        if movingDirection == "up" then
            -- 이전 모습 삭제
            if motionUp == 1 then -- 1~4
                player[2][4].alpha = 0
            else
                player[2][motionUp - 1].alpha = 0
            end
            -- 현재 모습 
            player[2][motionUp].alpha = 1
        
            d = d + 0.2 -- 움직임 속도 조절
            if(d >= 1.2) then
                motionUp = motionUp + 1
                d = 0
            end
            if motionUp == 5 then
                motionUp = 1
            end

            if (playerGroup.y > 0) then -- 여기 숫자 각 맵에 맞게 조절하시면 됩니다. ex) -608
                playerGroup.y = playerGroup.y - moveSpeed
            end
            up.alpha = 0.7

        elseif movingDirection == "down" then
            -- 이전 모습 삭제
            if motionDown == 1 then -- 1~4
                player[1][4].alpha = 0
            else
                player[1][motionDown - 1].alpha = 0
            end
            -- 현재 모습 
            player[1][motionDown].alpha = 1

            d = d + 0.2 -- 움직임 속도 조절
            if(d >= 1.2) then
                motionDown = motionDown + 1
                d = 0
            end
            if motionDown == 5 then
                motionDown = 1
            end

            if (playerGroup.y < 668) then -- 숫자 조절
                playerGroup.y = playerGroup.y + moveSpeed
            end
            down.alpha = 0.7

        elseif movingDirection == "left" then
            -- 이전 모습 삭제
            if motionLeft == 1 then -- 1~4
                player[3][4].alpha = 0
            else
                player[3][motionLeft - 1].alpha = 0
            end
            -- 현재 모습 
            player[3][motionLeft].alpha = 1

            d = d + 0.2 -- 움직임 속도 조절
            if(d >= 1.4) then
                motionLeft = motionLeft + 1
                d = 0
            end
            if motionLeft == 5 then
                motionLeft = 1
            end

            if (playerGroup.x > -73) then -- 숫자 조절
                playerGroup.x = playerGroup.x - moveSpeed
            end
            left.alpha = 0.7

        elseif movingDirection == "right" then
            -- 이전 모습 삭제
            if motionRight == 1 then -- 1~4
                player[4][4].alpha = 0
            else
                player[4][motionRight - 1].alpha = 0
            end

            -- 현재 모습 
            player[4][motionRight].alpha = 1

            d = d + 0.2 -- 움직임 속도 조절
            if(d >= 1.4) then
                motionRight = motionRight + 1
                d = 0
            end
            if motionRight == 5 then
                motionRight = 1
            end

            if (playerGroup.x < 1104) then -- 숫자 조절
                playerGroup.x = playerGroup.x + moveSpeed
            end
            right.alpha = 0.7
        end

            --버튼
            if (-10 < playerGroup.y and playerGroup.y < 70 and 1030 < playerGroup.x and playerGroup.x < 1120) then
                finger[1].alpha = 1
                cursor.alpha = 0
        
            --메모
            elseif (-10 < playerGroup.y and playerGroup.y < 110 and -80 < playerGroup.x and playerGroup.x < 80) then
                finger[2].alpha = 1
                cursor.alpha = 0
        
            --그림 H
            elseif (350 < playerGroup.y and playerGroup.y < 510 and 905 < playerGroup.x and playerGroup.x < 1105) then
                finger[3].alpha = 1
                cursor.alpha = 0
        
                if selT1 then
                    newCursor.alpha = 1
                end
        
            --그림 U
            elseif (280 < playerGroup.y and playerGroup.y < 460 and -50 < playerGroup.x and playerGroup.x < 150) then
                finger[4].alpha = 1
                cursor.alpha = 0
        
                if selT2 then
                    newCursor.alpha = 1
                end
        
            --그림 N
            elseif (135 < playerGroup.y and playerGroup.y < 300 and 300 < playerGroup.x and playerGroup.x < 500) then
                finger[5].alpha = 1
                cursor.alpha = 0
        
                if selT3 then
                    newCursor.alpha = 1
                end
        
            --그림 T
            elseif (510 < playerGroup.y and playerGroup.y < 670 and 550 < playerGroup.x and playerGroup.x < 750) then
                finger[6].alpha = 1
                cursor.alpha = 0
        
                if selT4 then
                    newCursor.alpha = 1
                end
        

        else
            for i = 1, 6 do
                finger[i].alpha = 0
            end
            cursor.alpha = 1
            newCursor.alpha = 0

            for i = 1, numSets do
                local num = (i - 1) * 2 + 1

                sel[num].alpha = 0
                sel[num].label.alpha = 0
                sel[num+1].alpha = 0
                sel[num+1].label.alpha = 0
            end

            talk[1].alpha = 0
            talk[1].label.alpha = 0

            for i = 1, 2 do
                sel_button[i].alpha = 0
                sel_button[i].label.alpha = 0
            end
        end
    end

    local function touchEventListener(event)
        if event.phase == "began" or event.phase == "moved" then
            -- print("터치를 시작함")
            if event.target == up then
                movingDirection = "up"

                for i = 1, 4 do
                    if i ~= 2 then
                        for j = 1, 4 do
                            player[i][j].alpha = 0
                        end
                    end
                end
            elseif event.target == down then
                movingDirection = "down"

                for i = 2, 4 do
                    for j = 1, 4 do
                        player[i][j].alpha = 0
                    end
                end
            elseif event.target == left then
                movingDirection = "left"

                for i = 1, 4 do
                    if i ~= 3 then
                        for j = 1, 4 do
                            player[i][j].alpha = 0
                        end
                    end
                end
            elseif event.target == right then
                movingDirection = "right"

                for i = 1, 3 do
                    for j = 1, 4 do
                        player[i][j].alpha = 0
                    end
                end
            end

        elseif event.phase == "ended" or event.phase == "cancelled" then
            movingDirection = nil

            up.alpha = 1
            right.alpha = 1
            left.alpha = 1
            down.alpha = 1

            --print(playerGroup.x, playerGroup.y)
        end
    end

    up:addEventListener("touch", touchEventListener)
    down:addEventListener("touch", touchEventListener)
    left:addEventListener("touch", touchEventListener)
    right:addEventListener("touch", touchEventListener)

    Runtime:addEventListener("enterFrame", moveCharacter)

    local function stopMove ( event )
        if event.phase == "began" or event.phase == "moved" then
            movingDirection = nil

            up.alpha = 1
            right.alpha = 1
            left.alpha = 1
            down.alpha = 1
        end
    end

    stopUp:addEventListener("touch", stopMove)
    stopDown:addEventListener("touch", stopMove)
    stopLeft:addEventListener("touch", stopMove)
    stopRight:addEventListener("touch", stopMove)

    -- ↑ 플레이어 이동 함수 정리 -------------------------------------------------------------------------------------------------

    -- ↓ 인벤토리 함수 -------------------------------------------------------------------------------------------------

    local function inven( event )
        composer.showOverlay("inventoryScene", {isModal = true})
    end
    inventory:addEventListener("tap", inven)

    -- ↓ 메모 -------------------------------------------------------------------------------------------------

    local function memoTap(event)
        audio.play(buttonSound)
        audio.play(sound_artist_memo1)
    
        composer.showOverlay("artist_overlay_memo", {isModal = true})
    end
    

    finger[2]:addEventListener("tap", memoTap)


    -- ↓ 그림 선택/이동 -------------------------------------------------------------------------------------------------

    local function successScene(event)
        composer.gotoScene("artist_picgame_sucess")
    end

    local function failScene(event)

        for i = 1, #fram do
            display.remove(fram[i].currentPic) -- 제거된 currentPic
            display.remove(pic[i].currentPic)
        end
                
        composer.gotoScene("artist_picgame_re_1")
    end

    local pic_match = nill
    
    local imagePaths = {
        "image/artist/1.png",
        "image/artist/2.png",
        "image/artist/3.png",
        "image/artist/4.png"
    }

    local imageStates = {}  -- 각 이미지의 상태를 저장하는 테이블

    for i = 1, 4 do
        imageStates[i] = false  -- 초기에 모든 이미지의 상태를 false로 설정
    end
    
    local function drag( event )
        if( event.phase == "began" ) then
            display.getCurrentStage():setFocus( event.target )
            event.target.isFocus = true

            event.target.x0 = event.target.x
            event.target.y0 = event.target.y
            event.target:toFront()
            -- 드래그 시작할 때

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

                local x = event.target.x
                local y = event.target.y

                -- 드래그 끝났을 때
                for i = 1, #fram do
                    if fram[i] then
                        local frameX = fram[i].x
                        local frameY = fram[i].y


                        if frameX and frameY then
                            if (x > frameX - 70 and x < frameX + 70 and
                                y > frameY - 70 and y < frameY + 70) then

                                    timer.performWithDelay(1, function()
                                        local newPicGroup = display.newGroup()
                                        local newPic = {}
                                        newPic = fram[i].currentPic
                                            
                                        local index = event.target.myIndex
                                        local imagePath = imagePaths[index]
                                        fram[i].currentPic = display.newImageRect(newPicGroup, imagePath, 165, 165)
                                        fram[i].currentPic.x, fram[i].currentPic.y = frameX, frameY
                                        sceneGroup:insert(newPicGroup)
                                        sceneGroup:insert(playerGroup)
                                        
                                    display.remove(event.target)
                                    display.remove(fram[i])
    
                                    audio.play(buttonSound2)
    
                                    if i == index then
                                        imageStates[index] = true
    
                                        if imageStates[1] and imageStates[2] and imageStates[3] and imageStates[4] then
                                            pic_match = true
                                            --print("성공")
                                        end
                                    else
                                        pic_match = false
        
                                        --print("실패")
                                    end
                                end)
                                
                                break -- 이미 한 번 위치를 찾았으면 더 이상 확인할 필요 없음
                            end
                        end
                    end
                end                 
            else
                display.getCurrentStage():setFocus(nil)
                event.target.isFocus = false
            end
        end
    end
  
    -- ↓ 버튼 -------------------------------------------------------------------------------------------------

    local function keep(event)
        audio.play(buttonSound)
        --print("아직 아니야")

        not_interaction.alpha = 1
        up.alpha = 1
        down.alpha = 1
        left.alpha = 1
        right.alpha = 1
        stopDown.alpha = 1
        stopLeft.alpha = 1
        stopRight.alpha = 1
        stopUp.alpha = 1

        talk[1].alpha = 0
        talk[1].label.alpha = 0

        for i = 1, 2 do
            sel_button[i].alpha = 0
            sel_button[i].label.alpha = 0
        end

        sel_button[1]:removeEventListener("tap", keep)
        sel_button[2]:removeEventListener("tap", failScene)
        sel_button[2]:removeEventListener("tap", successScene)
        finger[1]:removeEventListener("tap", button)
    end

    local function button(event)
        audio.play(buttonSound)

        not_interaction.alpha = 0
        up.alpha = 0
        down.alpha = 0
        left.alpha = 0
        right.alpha = 0
        stopDown.alpha = 0
        stopLeft.alpha = 0
        stopRight.alpha = 0
        stopUp.alpha = 0

        talk[1].alpha = 1
        talk[1].label.alpha = 1

        for i = 1, 2 do
            sel_button[i].alpha = 1
            sel_button[i].label.alpha = 1
        end

        sel_button[1]:addEventListener("tap", keep)

        if pic_match then
            sel_button[2]:addEventListener("tap", successScene)
        else
            sel_button[2]:addEventListener("tap", failScene)
        end

    end

    finger[1]:addEventListener("tap", button)
                
    --그림 H -------------------------------------------------------------------------------------------------

    local function selTap_1(event)

        audio.play(buttonSound)

        for i = 1, 2 do
            sel[i].alpha = 1
            sel[i].label.alpha = 1
        end
    
        local function sel1(event)
            audio.play(buttonSound)
            composer.showOverlay("artist_overlayScene1", {isModal = true})
        end
    
        local function sel2(event)
            selT1 = true

            audio.play(buttonSound)
                
            for i = 1, 2 do
                display.remove(sel[i].label)
                display.remove(sel[i])
            end
    
            display.remove(pic[1])
    
            if not pic[1].currentPic then
                local imagePath = "image/artist/1.png"
                pic[1].currentPic = display.newImageRect(imagePath, 165, 165)
                pic[1].currentPic.x, pic[1].currentPic.y = pic[1].x, pic[1].y

                pic[1].currentPic.myIndex = 1
                pic[1].currentPic:addEventListener("touch", drag)
            end
    
            display.remove(finger[3])
    
            finger[3]:removeEventListener("tap", selTap_1)
        end
    
        sel[1]:addEventListener("tap", sel1)
        sel[2]:addEventListener("tap", sel2)
    end

    finger[3]:addEventListener("tap", selTap_1)

    --그림 U -------------------------------------------------------------------------------------------------

    local function selTap_2(event)
        audio.play(buttonSound)
        for i = 3, 4 do
            sel[i].alpha = 1
            sel[i].label.alpha = 1
        end
    
        local function sel3(event)
            audio.play(buttonSound)
            composer.showOverlay("artist_overlayScene2", {isModal = true})
        end
    
        local function sel4(event)
            selT2 = true

            audio.play(buttonSound)
                
            for i = 3, 4 do
                display.remove(sel[i].label)
                display.remove(sel[i])
            end
    
            display.remove(pic[2])
    
            if not pic[2].currentPic then
                local imagePath = "image/artist/2.png"
                pic[2].currentPic = display.newImageRect(imagePath, 165, 165)
                pic[2].currentPic.x, pic[2].currentPic.y = pic[2].x, pic[2].y
        
                pic[2].currentPic.myIndex = 2
                pic[2].currentPic:addEventListener("touch", drag)
            end
    
            display.remove(finger[4])
    
            finger[4]:removeEventListener("tap", selTap_2)
        end
    
        sel[3]:addEventListener("tap", sel3)
        sel[4]:addEventListener("tap", sel4)
    end

    finger[4]:addEventListener("tap", selTap_2)

    --그림 N -------------------------------------------------------------------------------------------------
    local function selTap_3(event)
        audio.play(buttonSound)
        for i = 5, 6 do
            sel[i].alpha = 1
            sel[i].label.alpha = 1
        end
    
        local function sel5(event)
            audio.play(buttonSound)
            composer.showOverlay("artist_overlayScene3", {isModal = true})
        end
    
        local function sel6(event)
            audio.play(buttonSound)
                
            for i = 5, 6 do
                display.remove(sel[i].label)
                display.remove(sel[i])
            end
    
            display.remove(pic[3])
    
            if not pic[3].currentPic then
                local imagePath = "image/artist/3.png"
                pic[3].currentPic = display.newImageRect(imagePath, 165, 165)
                pic[3].currentPic.x, pic[3].currentPic.y = pic[3].x, pic[3].y
        
                pic[3].currentPic.myIndex = 3
                pic[3].currentPic:addEventListener("touch", drag)
            end
    
            display.remove(finger[5])
    
            selT3 = true

            finger[5]:removeEventListener("tap", selTap_3)
        end
    
        sel[5]:addEventListener("tap", sel5)
        sel[6]:addEventListener("tap", sel6)
    end

    finger[5]:addEventListener("tap", selTap_3)

    --그림 T -------------------------------------------------------------------------------------------------
    local function selTap_4(event)
        audio.play(buttonSound)
        for i = 7, 8 do
            sel[i].alpha = 1
            sel[i].label.alpha = 1
        end
    
        local function sel7(event)
            audio.play(buttonSound)
            composer.showOverlay("artist_overlayScene4", {isModal = true})
        end
    
        local function sel8(event)
            selT4 = true

            audio.play(buttonSound)
                
            for i = 7, 8 do
                display.remove(sel[i].label)
                display.remove(sel[i])
            end
    
            display.remove(pic[4])
    
            if not pic[4].currentPic then
                local imagePath = "image/artist/4.png"
                pic[4].currentPic = display.newImageRect(imagePath, 165, 165)
                pic[4].currentPic.x, pic[4].currentPic.y = pic[4].x, pic[4].y
        
                pic[4].currentPic.myIndex = 4
                pic[4].currentPic:addEventListener("touch", drag)
            end
    
            display.remove(finger[6])
    
    
            finger[6]:removeEventListener("tap", selTap_4)
        end
    
        sel[7]:addEventListener("tap", sel7)
        sel[8]:addEventListener("tap", sel8)
    end

    finger[6]:addEventListener("tap", selTap_4)

    sceneGroup:insert(selGroup)
    
    playerGroup:toFront()
    talkGroup:toFront()

end


	----------------------------------------------------------------------------------------------------------


function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc.
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.

        composer.removeScene("artist_picgame_start")
    elseif phase == "did" then
        -- Called when the scene is now off screen
    end
end

function scene:destroy(event)
    local sceneGroup = self.view


    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc.
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
