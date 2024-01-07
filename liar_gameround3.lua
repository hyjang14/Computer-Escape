-----------------------------------------------------------------------------------------
--
-- gameround3.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
-- ↓ 시작화면 배치 -----------------------------------------------------------------------------------------------

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	background:setFillColor(0.1, 1) -- 전체 화면

	local room = display.newImage( "image/배경/배경_저택_거짓말쟁이 스포트라이트.png", display.contentWidth*0.5, display.contentHeight*0.5)
	room:scale(0.9, 0.9)

	local explanation = display.newImage("image/UI/물음표.png")
	explanation.x, explanation.y = 100, 80

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local item_Change = display.newImage("image/UI/빈원형.png")
	item_Change.x, item_Change.y = 1740, 680

	local personGroup = composer.getVariable( "personGroup3")
	--local truth_teller = math.random(1, 5)
	local truth_teller3 = 5
	composer.setVariable( "truth_teller3", truth_teller3 )
	-- ↓ 하트 ----------------------------------------------------------------------------------------------------
	
	local heartGroup = composer.getVariable( "heartGroup")

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

	-- 레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(room)
	sceneGroup:insert(personGroup)
	sceneGroup:insert(heartGroup)
	sceneGroup:insert(explanation)
	sceneGroup:insert(inventory)
	sceneGroup:insert(item_Change)

-- ↑ 시작화면 배치 ---------------------------------------------------------------------------------------------

-- ↓ 상호작용 버튼 영역 ---------------------------------------------------------------------------------------------------
	local interact_extentGroup = display.newGroup()
	local interact_extent = {}
	local w = {0.24, 0.37, 0.5, 0.63, 0.76}

	for i = 1, 5 do
		interact_extent[i] = display.newRect(interact_extentGroup, display.contentCenterX, display.contentCenterY, 100, 100)
		interact_extent[i].x, interact_extent[i].y = display.contentWidth * w[i], display.contentHeight * 0.375
		interact_extent[i].alpha = 0
	end

	sceneGroup:insert(interact_extentGroup)
-- ↑ 상호작용 버튼 영역 ---------------------------------------------------------------------------------------------------

-- ↓ 상호작용 버튼 ---------------------------------------------------------------------------------------------------
	local interact_button = {}

	interact_button[1] = display.newImage("image/UI/커서.png")
	interact_button[1].x, interact_button[1].y = 1560, 810
	interact_button[1].alpha = 0
	sceneGroup:insert(interact_button[1])
	for i = 2, 6 do
		interact_button[i] = display.newImage("image/UI/포인터.png")
		interact_button[i].x, interact_button[i].y = 1560, 810
		interact_button[i].alpha = 0

		sceneGroup:insert(interact_button[i])
	end

	interact_button[1].alpha = 0.5 -- 처음 모습
-- ↑ 상호작용 버튼 ---------------------------------------------------------------------------------------------------


-- ↓ 플레이어 ---------------------------------------------------------------------------------------------------
	local playerGroup = display.newGroup()
	local player = {} 

	for i = 1, 4 do
		player[i] = {}
	end

	-- 앞
	for i = 1, 4 do
		player[1][i] = display.newImageRect("image/캐릭터/pixil(앞)-"..(i - 1)..".png", 120, 120)
		player[1][i].x, player[1][i].y = display.contentWidth*0.5, display.contentHeight*0.55 
		player[1][i].alpha = 0

		playerGroup:insert(player[1][i])
	end
	-- 뒤
	for i = 1, 4 do
		player[2][i] = display.newImageRect("image/캐릭터/pixil(뒤)-"..(i - 1)..".png", 120, 120)
		player[2][i].x, player[2][i].y = display.contentWidth*0.5, display.contentHeight*0.55 
		player[2][i].alpha = 0

		playerGroup:insert(player[2][i])
	end
	-- 왼쪽
	for i = 1, 4 do
		player[3][i] = display.newImageRect("image/캐릭터/pixil(왼)-"..(i - 1)..".png", 120, 120)
		player[3][i].x, player[3][i].y = display.contentWidth*0.5, display.contentHeight*0.55 
		player[3][i].alpha = 0

		playerGroup:insert(player[3][i])
	end
	-- 오른쪽
	for i = 1, 4 do
		player[4][i] = display.newImageRect("image/캐릭터/pixil(오른)-"..(i - 1)..".png", 120, 120)
		player[4][i].x, player[4][i].y = display.contentWidth*0.5, display.contentHeight*0.55 
		player[4][i].alpha = 0

		playerGroup:insert(player[4][i])
	end

	sceneGroup:insert(playerGroup)

	player[1][1].alpha = 1 -- 처음 모습

	local locationX = 1200
	local locationY = 700

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
			if(d == 0.8 or d > 0.8) then
				motionUp = motionUp + 1
				d = 0
			end
			if motionUp == 5 then
				motionUp = 1
			end

			if playerGroup.y > room.contentHeight - playerGroup.contentHeight * 10 then
				playerGroup.y = playerGroup.y - moveSpeed
			end

			up.alpha = 0.3

			print(playerGroup.x, interact_extentGroup[1].contentWidth, playerGroup.contentWidth)
			if (playerGroup.y < interact_extentGroup[1].contentHeight - playerGroup.contentHeight * 2.28) then
				if (playerGroup.x < interact_extentGroup[1].contentHeight - playerGroup.contentHeight * 4.7) then
					interact_button[1].alpha = 0
					interact_button[2].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[2].contentWidth - playerGroup.contentWidth * 3.27) and (playerGroup.x < interact_extentGroup[2].contentWidth - playerGroup.contentWidth * 2.6) then
					interact_button[1].alpha = 0
					interact_button[3].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[3].contentWidth - playerGroup.contentWidth * 1.4) and (playerGroup.x < interact_extentGroup[3].contentWidth - playerGroup.contentWidth * 0.53) then
					interact_button[1].alpha = 0
					interact_button[4].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[4].contentWidth + playerGroup.contentWidth * 0.93) and (playerGroup.x < interact_extentGroup[4].contentWidth + playerGroup.contentWidth * 1.6) then
					interact_button[1].alpha = 0
					interact_button[5].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[5].contentWidth + playerGroup.contentWidth * 3) then
					interact_button[1].alpha = 0
					interact_button[6].alpha = 1

				else
					interact_button[1].alpha = 0.5
					interact_button[2].alpha = 0
					interact_button[3].alpha = 0					
					interact_button[4].alpha = 0					
					interact_button[5].alpha = 0					
					interact_button[6].alpha = 0
				end
			else
				interact_button[1].alpha = 0.5
				interact_button[2].alpha = 0
				interact_button[3].alpha = 0					
				interact_button[4].alpha = 0					
				interact_button[5].alpha = 0					
				interact_button[6].alpha = 0
			end

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
			if(d == 0.8 or d > 0.8) then
				motionDown = motionDown + 1
				d = 0
			end
			if motionDown == 5 then
				motionDown = 1
			end

			if playerGroup.y < room.contentHeight - playerGroup.contentHeight * 6 then
				playerGroup.y = playerGroup.y + moveSpeed
			end
			down.alpha = 0.3
			
			if (playerGroup.y < interact_extentGroup[1].contentHeight - playerGroup.contentHeight * 2.28) then
				if (playerGroup.x < interact_extentGroup[1].contentHeight - playerGroup.contentHeight * 4.7) then
					interact_button[1].alpha = 0
					interact_button[2].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[2].contentWidth - playerGroup.contentWidth * 3.27) and (playerGroup.x < interact_extentGroup[2].contentWidth - playerGroup.contentWidth * 2.6) then
					interact_button[1].alpha = 0
					interact_button[3].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[3].contentWidth - playerGroup.contentWidth * 1.4) and (playerGroup.x < interact_extentGroup[3].contentWidth - playerGroup.contentWidth * 0.53) then
					interact_button[1].alpha = 0
					interact_button[4].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[4].contentWidth + playerGroup.contentWidth * 0.93) and (playerGroup.x < interact_extentGroup[4].contentWidth + playerGroup.contentWidth * 1.6) then
					interact_button[1].alpha = 0
					interact_button[5].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[5].contentWidth + playerGroup.contentWidth * 3) then
					interact_button[1].alpha = 0
					interact_button[6].alpha = 1

				else
					interact_button[1].alpha = 0.5
					interact_button[2].alpha = 0
					interact_button[3].alpha = 0					
					interact_button[4].alpha = 0					
					interact_button[5].alpha = 0					
					interact_button[6].alpha = 0
				end
			else
				interact_button[1].alpha = 0.5
				interact_button[2].alpha = 0
				interact_button[3].alpha = 0					
				interact_button[4].alpha = 0					
				interact_button[5].alpha = 0					
				interact_button[6].alpha = 0
			end

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
			if(d == 1 or d > 1) then
				motionLeft = motionLeft + 1
				d = 0
			end
			if motionLeft == 5 then
				motionLeft = 1
			end
			
			if playerGroup.x > room.contentWidth - playerGroup.contentWidth * 18.8 then
				playerGroup.x = playerGroup.x - moveSpeed
			end
			left.alpha = 0.3

			if (playerGroup.y < interact_extentGroup[1].contentHeight - playerGroup.contentHeight * 2.28) then
				if (playerGroup.x < interact_extentGroup[1].contentHeight - playerGroup.contentHeight * 4.7) then
					interact_button[1].alpha = 0
					interact_button[2].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[2].contentWidth - playerGroup.contentWidth * 3.27) and (playerGroup.x < interact_extentGroup[2].contentWidth - playerGroup.contentWidth * 2.6) then
					interact_button[1].alpha = 0
					interact_button[3].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[3].contentWidth - playerGroup.contentWidth * 1.4) and (playerGroup.x < interact_extentGroup[3].contentWidth - playerGroup.contentWidth * 0.53) then
					interact_button[1].alpha = 0
					interact_button[4].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[4].contentWidth + playerGroup.contentWidth * 0.93) and (playerGroup.x < interact_extentGroup[4].contentWidth + playerGroup.contentWidth * 1.6) then
					interact_button[1].alpha = 0
					interact_button[5].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[5].contentWidth + playerGroup.contentWidth * 3) then
					interact_button[1].alpha = 0
					interact_button[6].alpha = 1

				else
					interact_button[1].alpha = 0.5
					interact_button[2].alpha = 0
					interact_button[3].alpha = 0					
					interact_button[4].alpha = 0					
					interact_button[5].alpha = 0					
					interact_button[6].alpha = 0
				end
			else
				interact_button[1].alpha = 0.5
				interact_button[2].alpha = 0
				interact_button[3].alpha = 0					
				interact_button[4].alpha = 0					
				interact_button[5].alpha = 0					
				interact_button[6].alpha = 0
			end

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
			if(d == 1 or d > 1) then
				motionRight = motionRight + 1
				d = 0
			end
			if motionRight == 5 then
				motionRight = 1
			end

			if playerGroup.x < room.contentWidth - playerGroup.contentWidth * 10 then
				playerGroup.x = playerGroup.x + moveSpeed
			end
			right.alpha = 0.3

			if (playerGroup.y < interact_extentGroup[1].contentHeight - playerGroup.contentHeight * 2.28) then
				if (playerGroup.x < interact_extentGroup[1].contentHeight - playerGroup.contentHeight * 4.7) then
					interact_button[1].alpha = 0
					interact_button[2].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[2].contentWidth - playerGroup.contentWidth * 3.27) and (playerGroup.x < interact_extentGroup[2].contentWidth - playerGroup.contentWidth * 2.6) then
					interact_button[1].alpha = 0
					interact_button[3].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[3].contentWidth - playerGroup.contentWidth * 1.4) and (playerGroup.x < interact_extentGroup[3].contentWidth - playerGroup.contentWidth * 0.53) then
					interact_button[1].alpha = 0
					interact_button[4].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[4].contentWidth + playerGroup.contentWidth * 0.93) and (playerGroup.x < interact_extentGroup[4].contentWidth + playerGroup.contentWidth * 1.6) then
					interact_button[1].alpha = 0
					interact_button[5].alpha = 1

				elseif (playerGroup.x > interact_extentGroup[5].contentWidth + playerGroup.contentWidth * 3) then
					interact_button[1].alpha = 0
					interact_button[6].alpha = 1

				else
					interact_button[1].alpha = 0.5
					interact_button[2].alpha = 0
					interact_button[3].alpha = 0					
					interact_button[4].alpha = 0					
					interact_button[5].alpha = 0					
					interact_button[6].alpha = 0
				end
			else
				interact_button[1].alpha = 0.5
				interact_button[2].alpha = 0
				interact_button[3].alpha = 0					
				interact_button[4].alpha = 0					
				interact_button[5].alpha = 0					
				interact_button[6].alpha = 0
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

			up.alpha = 0.5
			right.alpha = 0.5
			left.alpha = 0.5
			down.alpha = 0.5
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

			up.alpha = 0.5
			right.alpha = 0.5
			left.alpha = 0.5
			down.alpha = 0.5
		end
	end

	stopUp:addEventListener("touch", stopMove)
	stopDown:addEventListener("touch", stopMove)
	stopLeft:addEventListener("touch", stopMove)
	stopRight:addEventListener("touch", stopMove)

-- ↑ 플레이어 이동 함수 정리 -------------------------------------------------------------------------------------------------


-- ↓ 상호작용 버튼 클릭 함수 ---------------------------------------------------------------------------------

	local function tapinteract_buttonEventListener( event )
		if interact_button[2].alpha == 1 then
			audio.play(sound_liar1)
			composer.gotoScene("liar_gameround3_1") -- gameround3_1으로 넘어가기
		
		elseif interact_button[3].alpha == 1 then
			audio.play(sound_liar2)
			composer.gotoScene("liar_gameround3_2") -- gameround3_2으로 넘어가기
		
		elseif interact_button[4].alpha == 1 then
			audio.play(sound_liar1)
			composer.gotoScene("liar_gameround3_3") -- gameround3_3으로 넘어가기
		
		elseif interact_button[5].alpha == 1 then
			audio.play(sound_liar2)
			composer.gotoScene("liar_gameround3_4") -- gameround3_4으로 넘어가기
		
		elseif interact_button[6].alpha == 1 then
			audio.play(sound_liar1)
			composer.gotoScene("liar_gameround3_5") -- gameround3_5으로 넘어가기
		
		else 
			print("상호작용 버튼을 탭함")
		end
	end

	interact_button[2]:addEventListener("tap", tapinteract_buttonEventListener)
	interact_button[3]:addEventListener("tap", tapinteract_buttonEventListener)
	interact_button[4]:addEventListener("tap", tapinteract_buttonEventListener)
	interact_button[5]:addEventListener("tap", tapinteract_buttonEventListener)
	interact_button[6]:addEventListener("tap", tapinteract_buttonEventListener)

-- ↑ 상호작용 버튼 클릭 함수-----------------------------------------------------------------------------------



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
		composer.removeScene('liar_gameround3') -- 추가
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
composer.recycleOnSceneChange = true
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
