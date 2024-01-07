-----------------------------------------------------------------------------------------
--
-- intro.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

--메인함수 -------------------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view

	audio.play(sound_rose, { channel=4, loops = -1 })
	audio.setVolume( 0.5, { channel=4 } )
	audio.resume(4)

	--장미 상호작용공간
	local interact01 = display.newRect(display.contentWidth/2, display.contentHeight*0.66,150,70)
	interact01:setFillColor(0)
	sceneGroup:insert(interact01)
	--배경화면
	local background = display.newImageRect("image/background.png", 1300,1000)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)
	--장미
	local rose = display.newImageRect("image/오브제/rose0_glass.png", 300,300)
	rose.x, rose.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(rose)
	--박스
	local box = display.newImageRect("image/오브제/box.png", 300,300)
	box.x, box.y = display.contentWidth*0.3, display.contentHeight*0.2
	sceneGroup:insert(box)
	--주전자
	local pot = display.newImageRect("image/오브제/pot.png", 150,150)
	pot.x, pot.y = display.contentWidth*0.7, display.contentHeight*0.25
	sceneGroup:insert(pot)
	--죽은장미들 오브제
	local deads01 = display.newImageRect("image/오브제/deads01.png", 400,260)
	deads01.x, deads01.y = display.contentWidth*0.73, display.contentHeight*0.75
	sceneGroup:insert(deads01)
	local deads02 = display.newImageRect("image/오브제/deads02.png", 500,280)
	deads02.x, deads02.y = display.contentWidth*0.28, display.contentHeight*0.75
	sceneGroup:insert(deads02)
	--참고메모
	local memo = display.newImageRect("image/오브제/rose_memo.png", 100,100)
	memo.x, memo.y = display.contentWidth/2 + 250, display.contentHeight*0.12
	sceneGroup:insert(memo)

	local cursor = display.newImage("image/UI/커서.png")
	cursor.x, cursor.y = 1560, 810 

	local finger = display.newImage("image/UI/포인터.png")
	finger.x, finger.y = 1560, 840
	finger.alpha = 0

	local not_interaction = display.newImageRect("image/UI/빈원형.png", 130, 130)
	not_interaction.x, not_interaction.y = 1740, 680
	-- not_interaction.alpha = 0

	local interaction = display.newImageRect("image/UI/변형.png", 130, 130)
	interaction.x, interaction.y = 1740, 680
	interaction.alpha = 0

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	-- 방향키 --------------------------------------

	local up = display.newImage("image/UI/콘솔(상).png")
	up.x, up.y = 330, 696
	up.name  = "up"

	local right = display.newImage("image/UI/콘솔(우).png")
	right.x, right.y = 443, 810
	right.name = "right"

	local left = display.newImage("image/UI/콘솔(좌).png")
	left.x, left.y = 217, 810
	left.name = "left"

	local down = display.newImage("image/UI/콘솔(하).png")
	down.x, down.y = 330, 924
	down.name = "down"

	-- 방향키틀 -----------
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
	local player = {} -- 앞

	for i = 1, 4 do
		player[i] = {}
	end

	-- 앞
	for i = 1, 4 do
		player[1][i] = display.newImageRect("image/캐릭터/pixil(앞)-"..(i - 1)..".png", 120, 120)
		player[1][i].alpha = 0
		player[1][i].x, player[1][i].y = display.contentCenterX , 900

		playerGroup:insert(player[1][i])
	end
	-- 뒤
	for i = 1, 4 do
		player[2][i] = display.newImageRect("image/캐릭터/pixil(뒤)-"..(i - 1)..".png", 120, 120)
		player[2][i].alpha = 0
		player[2][i].x, player[2][i].y = display.contentCenterX , 900

		playerGroup:insert(player[2][i])
	end
	-- 왼쪽
	for i = 1, 4 do
		player[3][i] = display.newImageRect("image/캐릭터/pixil(왼)-"..(i - 1)..".png", 120, 120)
		player[3][i].alpha = 0
		player[3][i].x, player[3][i].y = display.contentCenterX , 900

		playerGroup:insert(player[3][i])
	end
	-- 오른쪽
	for i = 1, 4 do
		player[4][i] = display.newImageRect("image/캐릭터/pixil(오른)-"..(i - 1)..".png", 120, 120)
		player[4][i].alpha = 0
		player[4][i].x, player[4][i].y = display.contentCenterX , 900
		playerGroup:insert(player[4][i])
	end

	sceneGroup:insert(playerGroup)

	player[2][1].alpha = 1 -- 처음 모습


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

        if movingDirection == "up" then -----------------------------------
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

			if (playerGroup.y > -200) then 
				playerGroup.y = playerGroup.y - moveSpeed
			end
			up.alpha = 0.7
			
			if (playerGroup.x <= 80 and playerGroup.x >= -80 and playerGroup.y <= -184 and playerGroup.y >= -260 ) then --장미상호작용구간
				isRose = true
				cursor.alpha = 0
				finger.alpha = 1
			else
				cursor.alpha = 1
				finger.alpha = 0
				isRose = false
				isDoor = false
			end
        elseif movingDirection == "down" then ---------------------
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

			if (playerGroup.y < 0) then -- 숫자 조절
				playerGroup.y = playerGroup.y + moveSpeed
			end
			down.alpha = 0.7

			if (playerGroup.x <= 80 and playerGroup.x >= -80 and playerGroup.y <= -184 and playerGroup.y >= -260 ) then --장미상호작용구간
				isRose = true
				cursor.alpha = 0
				finger.alpha = 1
			else
				cursor.alpha = 1
				finger.alpha = 0
				isRose = false
				isDoor = false
			end
        elseif movingDirection == "left" then -------------------------
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

			if (playerGroup.x > -200) then -- 숫자 조절
		 		playerGroup.x = playerGroup.x - moveSpeed
			end
			
			left.alpha = 0.7

			if (playerGroup.x <= 80 and playerGroup.x >= -80 and playerGroup.y <= -184 and playerGroup.y >= -260 ) then --장미상호작용구간
				isRose = true
				cursor.alpha = 0
				finger.alpha = 1
			else
				cursor.alpha = 1
				finger.alpha = 0
				isRose = false
				isDoor = false
			end
        elseif movingDirection == "right" then -----------------------------
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

			if (playerGroup.x < 260) then -- 숫자 조절
		 		playerGroup.x = playerGroup.x + moveSpeed
			end
			right.alpha = 0.7

			if (playerGroup.x <= 80 and playerGroup.x >= -80 and playerGroup.y <= -184 and playerGroup.y >= -260 ) then --장미상호작용구간
				isRose = true
				cursor.alpha = 0
				finger.alpha = 1
			else
				cursor.alpha = 1
				finger.alpha = 0
				isRose = false
				isDoor = false
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

			-- print(playerGroup.x, playerGroup.y, background.y)
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
	---------------------------------------------------------------------------------------
	
	-->다음씬 보내기
	local function gotoGame(event)
		if finger.alpha == 1 then
			display.remove(interact01) --상호작용공간직사각형 제거
			composer.gotoScene("rose_intro_dialog", { effect = "fade", time = 500 })
			
		end
	end
	--커서누르면 현재좌표출력
	local function onButtonPress(event)
		if event.phase == "ended" then
			-- 플레이어의 x, y 좌표 출력
			print("Player X:", playerGroup.x)
			print("Player Y:", playerGroup.y)
		end
	end

	finger:addEventListener("tap", gotoGame)
	cursor:addEventListener("touch", onButtonPress)

	
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	-- Called prior to the removal of scene's "view" (sceneGroup)
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene