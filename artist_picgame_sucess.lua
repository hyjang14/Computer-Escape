-----------------------------------------------------------------------------------------
--
-- picgame_sucess.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view


    -- Background
    local background = display.newImage("image/배경/배경_저택_예술가의방.png", display.contentCenterX, display.contentCenterY)
    sceneGroup:insert(background)

    local memo = display.newImageRect("image/UI/메모지.png", 60, 80)
    memo.x, memo.y = 450, 180
    memo.alpha = 0.7
    memo.name = "memo"  

    local button = display.newImageRect("image/UI/버튼.png", 50, 50)
    button.x, button.y = 1535, 180
    sceneGroup:insert(button)

    -- Images
    local framGroup = display.newGroup()
    local fram = {}


    fram[1] = display.newImageRect("image/artist/1.png", 165, 165)
    fram[2] = display.newImageRect("image/artist/2.png", fram[1].width, fram[1].height)
    fram[3] = display.newImageRect("image/artist/3.png", fram[1].width, fram[1].height)
    fram[4] = display.newImageRect("image/artist/4.png", fram[1].width, fram[1].height)


    for i = 1, 4 do
        fram[i].x, fram[i].y = 645 + (i - 1) * 250, 180
        framGroup:insert(fram[i])
    end

    local gun = display.newImageRect("image/자물쇠/총.png", 100, 100)
    gun.x = 1510
    gun.y = display.contentCenterY - 200

    local function showGunImage()
        audio.play(gameSuccess)

        gun.isVisible = true
    
        gun.x = 1510
        gun.y = -10
    
        -- 이미지 떨어지는 애니메이션
        local targetY = display.contentCenterY - 200  -- 이미지가 떨어질 목표 Y 좌표
        local fallTime = 1000  -- 애니메이션 시간 (밀리초)
    
        transition.to(gun, {y = targetY, time = fallTime, transition = easing.outQuad})
    end
    
    local isGunShown = false
    
    local function showGun(event)
        if not isGunShown then
            showGunImage()
            isGunShown = true
        end
    end
    
    Runtime:addEventListener("enterFrame", showGun)



    sceneGroup:insert(memo)
    sceneGroup:insert(framGroup)
    sceneGroup:insert(gun)


    -- 조작키 --------------------------------------

	local not_interaction = display.newImageRect("image/UI/빈원형.png", 130, 130)
	not_interaction.x, not_interaction.y = 1740, 680
	--not_interaction.alpha = 0

    local cursor = display.newImage("image/UI/커서.png")
	cursor.x, cursor.y = 1560, 810 

    local finger = display.newImage("image/UI/포인터.png")
	finger.x, finger.y = 1560, 810
    finger.alpha = 0

	local interaction = display.newImageRect("image/UI/변형.png", 130, 130)
	interaction.x, interaction.y = 1740, 680
	interaction.alpha = 0

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

    -- ↓ 인벤토리 함수 -------------------------------------------------------------------------------------------------

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
		player[1][i].x, player[1][i].y = 1540, 240
		player[1][i].alpha = 0

		playerGroup:insert(player[1][i])
	end
	-- 뒤
	for i = 1, 4 do
		player[2][i] = display.newImageRect("image/캐릭터/pixil(뒤)-"..(i - 1)..".png", 120, 120)
		player[2][i].x, player[2][i].y = 1540, 240
		player[2][i].alpha = 0

		playerGroup:insert(player[2][i])
	end
	-- 왼쪽
	for i = 1, 4 do
		player[3][i] = display.newImageRect("image/캐릭터/pixil(왼)-"..(i - 1)..".png", 120, 120)
		player[3][i].x, player[3][i].y = 1540, 240
		player[3][i].alpha = 0

		playerGroup:insert(player[3][i])
	end
	-- 오른쪽
	for i = 1, 4 do
		player[4][i] = display.newImageRect("image/캐릭터/pixil(오른)-"..(i - 1)..".png", 120, 120)
		player[4][i].x, player[4][i].y = 1540, 240 
		player[4][i].alpha = 0

		playerGroup:insert(player[4][i])
	end

	sceneGroup:insert(playerGroup)

	player[1][1].alpha = 1 -- 처음 모습

	local locationX = 1200
	local locationY = 700

	sceneGroup:insert(cursor)
	sceneGroup:insert(finger)
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

        if (playerGroup.y < 670) then -- 숫자 조절
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

        if (playerGroup.x > -1164) then -- 숫자 조절
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

        if (playerGroup.x < 20) then -- 숫자 조절
            playerGroup.x = playerGroup.x + moveSpeed
        end
        right.alpha = 0.7
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

        print(playerGroup.x, playerGroup.y)
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
local function getItem( event )
    audio.play(itemGetSound)
    display.remove(gun)
    if itemNum[5] == false then
        itemNum[5] = true
    end
    composer.gotoScene("artist_picgame_end")

end

gun:addEventListener("tap", getItem)

gun:toFront()

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
        composer.removeScene("artist_picgame_sucess")
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
