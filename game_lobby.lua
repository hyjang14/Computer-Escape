-----------------------------------------------------------------------------------------
--
-- 게임1층로비
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local tempBackground = display.newRect(display.contentCenterX, display.contentCenterY, 1920, 1080)
	tempBackground:setFillColor(0)
	sceneGroup:insert(tempBackground)

	local background = display.newImageRect("image/배경/배경_저택_1층.png", 2000,2000)
	background.x, background.y = display.contentWidth/2, display.contentHeight*0.08
	sceneGroup:insert(background)

	--벽
	--local wall1 = display.newRect(background.x * 0.5, background.y, 550,280)
	--local wall2 = display.newRect(background.x * 1.5, background.y, 550,280)

	-- 체리
	local cherry = display.newImageRect("image/캐릭터/체리_도트_기본모습.png", 120, 120)
	cherry.x, cherry.y = display.contentWidth/2, 380

	local nearCherry = 0

	local obsGroup = display.newGroup()

	-- 액자
	local frame = {}
	for i = 1, 4 do
		frame[i] = display.newImageRect("image/저택그림/액자"..i..".png", 130, 130)
		sceneGroup:insert(frame[i])
		obsGroup:insert(frame[i])
	end
	frame[1].x, frame[1].y =  display.contentWidth * 0.16, -600
	frame[2].x, frame[2].y =  display.contentWidth * 0.29, -600
	frame[3].x, frame[3].y =  display.contentWidth * 0.72, -600
	frame[4].x, frame[4].y =  display.contentWidth * 0.85, -600

	--obsGroup:insert(wall1)
	--obsGroup:insert(wall2)
	obsGroup:insert(cherry)
	--obsGroup:insert(desk)

	local cursor = display.newImage("image/UI/커서.png")
	cursor.x, cursor.y = 1560, 840 

	local finger = display.newImage("image/UI/포인터.png")
	finger.x, finger.y = 1560, 840
	finger.alpha = 0

	local finger_key = display.newImage("image/UI/포인터.png")
	finger_key.x, finger_key.y = 1560, 840
	finger_key.alpha = 0

	local finger_picture = display.newImage("image/UI/포인터.png")
	finger_picture.x, finger_picture.y = 1560, 840
	finger_picture.alpha = 0

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
	local player = {} -- 앞

	for i = 1, 4 do
		player[i] = {}
	end

	-- 앞
	for i = 1, 4 do
		player[1][i] = display.newImageRect("image/캐릭터/pixil(앞)-"..(i - 1)..".png", 120, 120)
		player[1][i].alpha = 0
		player[1][i].x, player[1][i].y = display.contentCenterX , 1000

		playerGroup:insert(player[1][i])
	end
	-- 뒤
	for i = 1, 4 do
		player[2][i] = display.newImageRect("image/캐릭터/pixil(뒤)-"..(i - 1)..".png", 120, 120)
		player[2][i].alpha = 0
		player[2][i].x, player[2][i].y = display.contentCenterX , 1000

		playerGroup:insert(player[2][i])
	end
	-- 왼쪽
	for i = 1, 4 do
		player[3][i] = display.newImageRect("image/캐릭터/pixil(왼)-"..(i - 1)..".png", 120, 120)
		player[3][i].alpha = 0
		player[3][i].x, player[3][i].y = display.contentCenterX , 1000

		playerGroup:insert(player[3][i])
	end
	-- 오른쪽
	for i = 1, 4 do
		player[4][i] = display.newImageRect("image/캐릭터/pixil(오른)-"..(i - 1)..".png", 120, 120)
		player[4][i].alpha = 0
		player[4][i].x, player[4][i].y = display.contentCenterX , 1000
		playerGroup:insert(player[4][i])
	end

	sceneGroup:insert(obsGroup)
	sceneGroup:insert(playerGroup)

	player[2][1].alpha = 1 -- 처음 모습

	sceneGroup:insert(cursor)
	sceneGroup:insert(finger)
	sceneGroup:insert(finger_key)
	sceneGroup:insert(finger_picture)
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
	
	--화면 이동 함수-----------------------------------
	local function moveCamera( dy )

		--배경끝이 스크린끝과 같으면 배경이동멈추고 계단전까지만 주인공 이동
		-----------------------if ()
		background.y = background.y - dy
		obsGroup.y = obsGroup.y - dy

		-- 배경 이동 처리 (위, 아래 이동)
        
	end
	--------------------------------------------------
	-- ↓ 그림 상호작용 함수 -------------------------------------------------------------------------------------------------
	local pic = 1
	local function picture( event )
		if pic == 1 then
			composer.setVariable("backgroundY", background.y)
			composer.setVariable("pictureY", frame[1].y + obsGroup.y)
			composer.setVariable("pi_X", display.contentCenterX + playerGroup.x)
			composer.showOverlay( "picturejson")
			cursor.alpha = 1
			finger_picture.alpha = 0
			pic = pic + 1
		end
	end

	finger_picture:addEventListener("tap", picture)

	-- ↓ 열쇠 상호작용 함수 -------------------------------------------------------------------------------------------------
	local keyPicture 
	local function interKey( event )
		
		composer.setVariable("next", 0)
		composer.setVariable("backgroundY", background.y)
		if keyPicture == 1 then
			composer.showOverlay("key_lockingImage_1")
		elseif  keyPicture == 2 then
			composer.gotoScene("key_lockingImage_2")
		elseif  keyPicture == 3 then
			composer.showOverlay("key_lockingImage_3")
		elseif  keyPicture == 4 then
			composer.showOverlay("key_lockingImage_4")
		end 
	end
	finger_key:addEventListener("tap", interKey)

	-- ↓ 체리 상호작용 함수 -------------------------------------------------------------------------------------------------

	local function interCherry( event )
		nearCherry = nearCherry + 1

		composer.setVariable("finger", finger)
		composer.setVariable("backgroundY", background.y)
		composer.setVariable("pi_X", display.contentCenterX + playerGroup.x)
		-- 파이 y좌표는 항상 playerGroup 0임 == 초기위치 800

		--체리 위치 / x좌표는 항상 화면 중앙
		composer.setVariable("cherry_Y", cherry.y + obsGroup.y)

		if nearCherry == 6 then
			composer.showOverlay( "cherry_distractor" )
		else
			composer.showOverlay( "cherryInteraction" )
		end
	end
	finger:addEventListener("tap", interCherry)


	-- ↓ 인벤토리 함수 -------------------------------------------------------------------------------------------------

	local function inven( event )
		composer.showOverlay("inventoryScene", {isModal = true})
	end
	inventory:addEventListener("tap", inven)

	-- ↓ 플레이어 이동 함수 정리 -------------------------------------------------------------------------------------------------

    local movingDirection = nil
    local moveSpeed = 4
	local d = 0
	local motionUp = 1
	local motionDown = 1
	local motionRight = 1
	local motionLeft = 1

    local function moveCharacter(event)

		--playerx,y최대값 정하기(틀안넘게)

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
			if(d == 1.2 or d > 1.2) then
				motionUp = motionUp + 1
				d = 0
			end
			if motionUp == 5 then
				motionUp = 1
			end
			
			--print(playerGroup.x, playerGroup.y, background.x, background.y)
			if ( playerGroup.y < -420 and background.y < 998) then -- 여기 숫자 각 맵에 맞게 조절하시면 됩니다. ex) -608
				if ( (playerGroup.y == -424 or playerGroup.y == -428) and playerGroup.x > -192 and playerGroup.x < 200) then
					if ( playerGroup.x > -64 and playerGroup.x < 64) then
						if(background.y > 398 or background.y < 202)then
							moveCamera(-moveSpeed)
						end
					else
						moveCamera(-moveSpeed)
					end
				elseif ( background.y < 434 ) then
						moveCamera(-moveSpeed)
				elseif ((playerGroup.y == -424 or playerGroup.y == -428) and background.y > 850 and background.y < 998) then
					moveCamera(-moveSpeed)
				end
			elseif ( playerGroup.x < -192 or playerGroup.x > 200) then
				if (playerGroup.y > -600) then
					playerGroup.y = playerGroup.y - moveSpeed
				end
			elseif (playerGroup.y >= -700) then
				playerGroup.y = playerGroup.y - moveSpeed
			end

			up.alpha = 0.7

			if(playerGroup.x > -100 and playerGroup.x < 80 and background.y > 90 and background.y < 210) then-- 체리 상호작용 위치
				cursor.alpha = 0
				finger.alpha = 1
			elseif (-740 < playerGroup.x and playerGroup.x < -572 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 1
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif (-488 < playerGroup.x and playerGroup.x < -304 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 2
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif (332 < playerGroup.x and playerGroup.x < 504 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 3
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif (588 < playerGroup.x and playerGroup.x < 764 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 4
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif ( playerGroup.y == -424 or playerGroup.y == -428) then
				if pic == 1 then
					if ( background.y > 770 and background.y < 878) then
						cursor.alpha = 0
						finger_picture.alpha = 1
						finger.alpha = 0
						finger_key.alpha = 0
					else
						cursor.alpha = 1
						finger_picture.alpha = 0
						finger.alpha = 0
						finger_key.alpha = 0
					end
				end
			else
				cursor.alpha = 1
				finger.alpha = 0
				finger_key.alpha = 0
				finger_picture.alpha = 0
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
			if(d == 1.2 or d > 1.2) then
				motionDown = motionDown + 1
				d = 0
			end
			if motionDown == 5 then
				motionDown = 1
			end

			if (background.y > 90 and playerGroup.y > -430) then -- 여기 숫자 각 맵에 맞게 조절하시면 됩니다. ex) -608
				if ( playerGroup.x < -188 or playerGroup.x > 196 ) then
					if( background.y > 854 ) then
						moveCamera(moveSpeed)
					elseif ( background.y < 462) then
						moveCamera(moveSpeed)
					end
				else
					if ( playerGroup.x > -64 and playerGroup.x < 64) then
						if(background.y > 402 or background.y < 206)then
							moveCamera(moveSpeed)
						end
					else
						moveCamera(moveSpeed)
					end
				end
			elseif ( playerGroup.y < 0 ) then
				if ( playerGroup.x < -188 or playerGroup.x > 196 ) then
					if( playerGroup.y < -136 ) then
						playerGroup.y = playerGroup.y + moveSpeed
					end
				else
					playerGroup.y = playerGroup.y + moveSpeed
				end
			end

			down.alpha = 0.7

			if(playerGroup.x > -100 and playerGroup.x < 80 and background.y > 90 and background.y < 210) then-- 체리 상호작용 위치
				cursor.alpha = 0
				finger.alpha = 1
			elseif (-740 < playerGroup.x and playerGroup.x < -572 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 1
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif (-488 < playerGroup.x and playerGroup.x < -304 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 2
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif (332 < playerGroup.x and playerGroup.x < 504 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 3
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif (588 < playerGroup.x and playerGroup.x < 764 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 4
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif ( playerGroup.y == -424 or playerGroup.y == -428) then
				if pic == 1 then
					if ( background.y > 770 and background.y < 878) then
						cursor.alpha = 0
						finger_picture.alpha = 1
						finger.alpha = 0
						finger_key.alpha = 0
					else
						cursor.alpha = 1
						finger_picture.alpha = 0
						finger.alpha = 0
						finger_key.alpha = 0
					end
				end
			else
				cursor.alpha = 1
				finger.alpha = 0
				finger_key.alpha = 0
				finger_picture.alpha = 0
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
			if(d == 1.4 or d > 1.4) then
				motionLeft = motionLeft + 1
				d = 0
			end
			if motionLeft == 5 then
				motionLeft = 1
			end

			if ( playerGroup.y > -136 or ( playerGroup.y == -424 and background.y > 466 and background.y < 846 )) then
				if (playerGroup.x > -188) then -- 숫자 조절
					playerGroup.x = playerGroup.x - moveSpeed
				end
			elseif (playerGroup.x > -780) then -- 숫자 조절
				if (playerGroup.y == -424 and (background.y > 206 and background.y < 398)) then
					if (playerGroup.x < -64 or playerGroup.x > 64) then
						playerGroup.x = playerGroup.x - moveSpeed
					end
				else	
					playerGroup.x = playerGroup.x - moveSpeed
				end
			end

			left.alpha = 0.7

			if(playerGroup.x > -100 and playerGroup.x < 80 and background.y > 90 and background.y < 210) then-- 체리 상호작용 위치
				cursor.alpha = 0
				finger.alpha = 1
			elseif (-740 < playerGroup.x and playerGroup.x < -572 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 1
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif (-488 < playerGroup.x and playerGroup.x < -304 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 2
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif (332 < playerGroup.x and playerGroup.x < 504 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 3
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif (588 < playerGroup.x and playerGroup.x < 764 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 4
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif ( playerGroup.y == -424 or playerGroup.y == -428) then
				if pic == 1 then
					if ( background.y > 770 and background.y < 878) then
						cursor.alpha = 0
						finger_picture.alpha = 1
						finger.alpha = 0
						finger_key.alpha = 0
					else
						cursor.alpha = 1
						finger_picture.alpha = 0
						finger.alpha = 0
						finger_key.alpha = 0
					end
				end
			else
				cursor.alpha = 1
				finger.alpha = 0
				finger_key.alpha = 0
				finger_picture.alpha = 0
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
			if(d == 1.4 or d > 1.4) then
				motionRight = motionRight + 1
				d = 0
			end
			if motionRight == 5 then
				motionRight = 1
			end
			
			if ( playerGroup.y > -136 or ( playerGroup.y == -424 and background.y > 466 and background.y < 846 )) then
				if (playerGroup.x < 196) then -- 숫자 조절
					playerGroup.x = playerGroup.x + moveSpeed
				end
			elseif (playerGroup.x < 780) then -- 숫자 조절
				if (playerGroup.y == -424 and (background.y > 206 and background.y < 398)) then
					if (playerGroup.x < -68 or playerGroup.x > 60) then
						playerGroup.x = playerGroup.x + moveSpeed
					end
				else	
					playerGroup.x = playerGroup.x + moveSpeed
				end
			end

			right.alpha = 0.7

			if(playerGroup.x > -100 and playerGroup.x < 80 and background.y > 90 and background.y < 210) then-- 체리 상호작용 위치
				cursor.alpha = 0
				finger.alpha = 1
			elseif (-740 < playerGroup.x and playerGroup.x < -572 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 1
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif (-488 < playerGroup.x and playerGroup.x < -304 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 2
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif (332 < playerGroup.x and playerGroup.x < 504 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 3
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif (588 < playerGroup.x and playerGroup.x < 764 and playerGroup.y < -460) then --열쇠 게임 그림 상호작용
				keyPicture = 4
				cursor.alpha = 0
				finger_key.alpha = 1
			elseif ( playerGroup.y == -424 or playerGroup.y == -428) then
				if pic == 1 then
					if ( background.y > 770 and background.y < 878) then
						cursor.alpha = 0
						finger_picture.alpha = 1
						finger.alpha = 0
						finger_key.alpha = 0
					else
						cursor.alpha = 1
						finger_picture.alpha = 0
						finger.alpha = 0
						finger_key.alpha = 0
					end
				end
			else
				cursor.alpha = 1
				finger.alpha = 0
				finger_key.alpha = 0
				finger_picture.alpha = 0
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


			if(playerGroup.y == -704 ) then
				composer.removeScene("game_lobby")
				composer.gotoScene("2nd_monologue", {effect = "fade", time=1000})
			end
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

    -- ↑ 플레이어 이동 함수 정리 ---------------------------------------------------------------------------------------

    -- ↑ 플레이어 이동 함수 정리 ------------------------------------------------------------------------------------------
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