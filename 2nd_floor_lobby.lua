-----------------------------------------------------------------------------------------
--
-- 2층로비.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local bgm = composer.getVariable("bgm")

	-- audio.play( mansionSound, { channel = 2, loops = -1})
	-- audio.setVolume( 0.3, { channel=2 } )

-- ↓ 시작화면 배치 -----------------------------------------------------------------------------------------------

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newImageRect("image/배경/배경_저택_2층로비.png", 1900, 1210)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2 - 50

	local explanation = display.newImage("image/UI/물음표.png")
	explanation.x, explanation.y = 100, 80

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local item_Change = display.newImage("image/UI/빈원형.png")
	item_Change.x, item_Change.y = 1740, 680

	-- ↓ 방향키 --------------------------------------

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

	-- 레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(explanation)
	sceneGroup:insert(inventory)
	sceneGroup:insert(item_Change)

-- ↑ 시작화면 배치 ---------------------------------------------------------------------------------------------
-- ↓ 인벤토리 함수 -------------------------------------------------------------------------------------------------

	local function inven( event )
		composer.showOverlay("inventoryScene", {isModal = true})
	end
	inventory:addEventListener("tap", inven)

-- ↑ 인벤토리 함수 ---------------------------------------------------------------------------------------------
-- ↓ 상호작용 버튼 영역 ---------------------------------------------------------------------------------------------------
	local interact_extentGroup = display.newGroup()
	local interact_extent = {}

	interact_extent[1] = display.newRect(interact_extentGroup, display.contentCenterX, display.contentCenterY, 100, 100)
	interact_extent[1].x, interact_extent[1].y = display.contentWidth * 0.17, display.contentHeight * 0.55
	interact_extent[1].alpha = 0

	interact_extent[2] = display.newRect(interact_extentGroup, display.contentCenterX, display.contentCenterY, 150, 100)
	interact_extent[2].x, interact_extent[2].y = display.contentWidth * 0.5, display.contentHeight * 0.2
	interact_extent[2].alpha = 0

	interact_extent[3] = display.newRect(interact_extentGroup, display.contentCenterX, display.contentCenterY, 100, 100)
	interact_extent[3].x, interact_extent[3].y = display.contentWidth * 0.84, display.contentHeight * 0.55
	interact_extent[3].alpha = 0

	sceneGroup:insert(interact_extentGroup)
-- ↑ 상호작용 버튼 영역 ---------------------------------------------------------------------------------------------------

-- ↓ 플레이어 ---------------------------------------------------------------------------------------------------

	-- 이전 움직였던 좌표 있으면 받아오기
	local pX = composer.getVariable("playerX2")
	local pY = composer.getVariable("playerY2")
	local x
	local y

	local playerGroup2 = display.newGroup()
	local player = {} 

	for i = 1, 4 do
		player[i] = {}
	end

	-- 앞
	for i = 1, 4 do
		player[1][i] = display.newImageRect("image/캐릭터/pixil(앞)-"..(i - 1)..".png", 120, 120)

		if pX == nil and pY == nil then
			player[1][i].x, player[1][i].y = display.contentWidth*0.5, display.contentHeight*0.9 
		else
			player[1][i].x, player[1][i].y = display.contentWidth*0.5 + pX, display.contentHeight*0.9 + pY
		end
		player[1][i].alpha = 0

		playerGroup2:insert(player[1][i])
	end
	-- 뒤
	for i = 1, 4 do
		player[2][i] = display.newImageRect("image/캐릭터/pixil(뒤)-"..(i - 1)..".png", 120, 120)
		
		if pX == nil and pY == nil then
			player[2][i].x, player[2][i].y = display.contentWidth*0.5, display.contentHeight*0.9 
		else
			player[2][i].x, player[2][i].y = display.contentWidth*0.5 + pX, display.contentHeight*0.9 + pY
		end

		player[2][i].alpha = 0

		playerGroup2:insert(player[2][i])
	end
	-- 왼쪽
	for i = 1, 4 do
		player[3][i] = display.newImageRect("image/캐릭터/pixil(왼)-"..(i - 1)..".png", 120, 120)
		
		if pX == nil and pY == nil then
			player[3][i].x, player[3][i].y = display.contentWidth*0.5, display.contentHeight*0.9 
		else
			player[3][i].x, player[3][i].y = display.contentWidth*0.5 + pX, display.contentHeight*0.9 + pY
		end

		player[3][i].alpha = 0

		playerGroup2:insert(player[3][i])
	end
	-- 오른쪽
	for i = 1, 4 do
		player[4][i] = display.newImageRect("image/캐릭터/pixil(오른)-"..(i - 1)..".png", 120, 120)
		
		if pX == nil and pY == nil then
			player[4][i].x, player[4][i].y = display.contentWidth*0.5, display.contentHeight*0.9 
		else
			player[4][i].x, player[4][i].y = display.contentWidth*0.5 + pX, display.contentHeight*0.9 + pY
		end

		player[4][i].alpha = 0

		playerGroup2:insert(player[4][i])
	end

	if pX ~= nil and pY ~= nil then
		x = pX
		y = pY
	else
		x = 0
		y = 0 
	end

	sceneGroup:insert(playerGroup2)

	player[2][1].alpha = 1 -- 처음 모습

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

	-- ↓ 상호작용 버튼 ---------------------------------------------------------------------------------------------------
	local interact_button = {}

	interact_button[1] = display.newImage("image/UI/커서.png")
	interact_button[1].x, interact_button[1].y = 1560, 810
	interact_button[1].alpha = 0
	sceneGroup:insert(interact_button[1])
	for i = 2, 4 do
		interact_button[i] = display.newImage("image/UI/포인터.png")
		interact_button[i].x, interact_button[i].y = 1560, 810
		interact_button[i].alpha = 0

		sceneGroup:insert(interact_button[i])
	end

	interact_button[1].alpha = 1 -- 처음 모습
-- ↑ 상호작용 버튼 ---------------------------------------------------------------------------------------------------

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

			if ( playerGroup2.x < -620 - x or  playerGroup2.x > 640 - x) then
				if playerGroup2.y > -452 - y then
					playerGroup2.y = playerGroup2.y - moveSpeed
				end	
			elseif playerGroup2.y > -800  - y then
				playerGroup2.y = playerGroup2.y - moveSpeed
			end

			up.alpha = 0.5
			
			if (playerGroup2.x < -573 - x) then
				if (playerGroup2.y < -366 - y) and (playerGroup2.y > -475.2 - y) then
					interact_button[1].alpha = 0
					interact_button[2].alpha = 1
				else
					interact_button[1].alpha = 1
					interact_button[2].alpha = 0
				end
			elseif(playerGroup2.x > 604 - x) then
				if (playerGroup2.y < -366 - y) and (playerGroup2.y > -475.2 - y) then
					interact_button[1].alpha = 0
					interact_button[3].alpha = 1
				else
					interact_button[1].alpha = 1
					interact_button[3].alpha = 0
				end
			elseif (playerGroup2.y < -708 - y) then
				if (playerGroup2.x > -84 - x) and (playerGroup2.x < 84 - x) then
					interact_button[1].alpha = 0
					interact_button[4].alpha = 1
				else
					interact_button[1].alpha = 1
					interact_button[4].alpha = 0
				end
			else
				interact_button[1].alpha = 1
				interact_button[2].alpha = 0
				interact_button[3].alpha = 0
				interact_button[4].alpha = 0
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
			if(d >= 1.2) then
				motionDown = motionDown + 1
				d = 0
			end
			if motionDown == 5 then
				motionDown = 1
			end

			-- print( playerGroup2.x, playerGroup2.y)
			if ( playerGroup2.x < -620 - x or  playerGroup2.x > 640 - x) then
				if playerGroup2.y < -384 - y then
					playerGroup2.y = playerGroup2.y + moveSpeed
				end	
			elseif ( playerGroup2.x > -124 - x and playerGroup2.x < 124 - x) then
				if playerGroup2.y < 36 - y then
					playerGroup2.y = playerGroup2.y + moveSpeed
				end
			elseif playerGroup2.y < -11.96 - y then
				playerGroup2.y = playerGroup2.y + moveSpeed
			end

			down.alpha = 0.5

			if (playerGroup2.x < -573 - x) then
				if (playerGroup2.y < -366 - y) and (playerGroup2.y > -475.2 - y) then
					interact_button[1].alpha = 0
					interact_button[2].alpha = 1
				else
					interact_button[1].alpha = 1
					interact_button[2].alpha = 0
				end
			elseif(playerGroup2.x > 604 - x) then
				if (playerGroup2.y < -366 - y) and (playerGroup2.y > -475.2 - y) then
					interact_button[1].alpha = 0
					interact_button[3].alpha = 1
				else
					interact_button[1].alpha = 1
					interact_button[3].alpha = 0
				end
			elseif (playerGroup2.y < -708 - y) then
				if (playerGroup2.x > -84 - x) and (playerGroup2.x < 84 - x) then
					interact_button[1].alpha = 0
					interact_button[4].alpha = 1
				else
					interact_button[1].alpha = 1
					interact_button[4].alpha = 0
				end
			else
				interact_button[1].alpha = 1
				interact_button[2].alpha = 0
				interact_button[3].alpha = 0
				interact_button[4].alpha = 0
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
			if(d >= 1.4) then
				motionLeft = motionLeft + 1
				d = 0
			end
			if motionLeft == 5 then
				motionLeft = 1
			end

			if ( playerGroup2.y < -392 - y and playerGroup2.y > -464 - y) then
				if playerGroup2.x > -740 - x then
					playerGroup2.x = playerGroup2.x - moveSpeed
				end
			elseif ( playerGroup2.y > 0  - y) then
				if playerGroup2.x > -120 then
					playerGroup2.x = playerGroup2.x - moveSpeed
				end
			elseif playerGroup2.x > -620  - x then
				playerGroup2.x = playerGroup2.x - moveSpeed
			end

			left.alpha = 0.5

			if (playerGroup2.x < -573 - x) then
				if (playerGroup2.y < -366 - y) and (playerGroup2.y > -475.2 - y) then
					interact_button[1].alpha = 0
					interact_button[2].alpha = 1
				else
					interact_button[1].alpha = 1
					interact_button[2].alpha = 0
				end
			elseif(playerGroup2.x > 604 - x) then
				if (playerGroup2.y < -366 - y) and (playerGroup2.y > -475.2 - y) then
					interact_button[1].alpha = 0
					interact_button[3].alpha = 1
				else
					interact_button[1].alpha = 1
					interact_button[3].alpha = 0
				end
			elseif (playerGroup2.y < -708 - y) then
				if (playerGroup2.x > -84 - x) and (playerGroup2.x < 84 - x) then
					interact_button[1].alpha = 0
					interact_button[4].alpha = 1
				else
					interact_button[1].alpha = 1
					interact_button[4].alpha = 0
				end
			else
				interact_button[1].alpha = 1
				interact_button[2].alpha = 0
				interact_button[3].alpha = 0
				interact_button[4].alpha = 0
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
			if(d >= 1.4) then
				motionRight = motionRight + 1
				d = 0
			end
			if motionRight == 5 then
				motionRight = 1
			end

			if ( playerGroup2.y < -392 - y and playerGroup2.y > -464 - y ) then
				if playerGroup2.x < 748 - x then
					playerGroup2.x = playerGroup2.x + moveSpeed
				end
			elseif ( playerGroup2.y > 0 - y) then
				if playerGroup2.x < 124 then
					playerGroup2.x = playerGroup2.x + moveSpeed
				end
			elseif playerGroup2.x < 640 - x then
				playerGroup2.x = playerGroup2.x + moveSpeed
			end
			right.alpha = 0.5

			if (playerGroup2.x < -573 - x) then
				if (playerGroup2.y < -366 - y) and (playerGroup2.y > -475.2 - y) then
					interact_button[1].alpha = 0
					interact_button[2].alpha = 1
				else
					interact_button[1].alpha = 1
					interact_button[2].alpha = 0
				end
			elseif(playerGroup2.x > 604 - x) then
				if (playerGroup2.y < -366 - y) and (playerGroup2.y > -475.2 - y) then
					interact_button[1].alpha = 0
					interact_button[3].alpha = 1
				else
					interact_button[1].alpha = 1
					interact_button[3].alpha = 0
				end
			elseif (playerGroup2.y < -708 - y) then
				if (playerGroup2.x > -84 - x) and (playerGroup2.x < 84 - x) then
					interact_button[1].alpha = 0
					interact_button[4].alpha = 1
				else
					interact_button[1].alpha = 1
					interact_button[4].alpha = 0
				end
			else
				interact_button[1].alpha = 1
				interact_button[2].alpha = 0
				interact_button[3].alpha = 0
				interact_button[4].alpha = 0
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

			if(playerGroup2.y == 36 and game1 == 1 and game2 == 1 and game3 == 1 ) then
				composer.hideOverlay("2nd_floor_lobby")
				composer.gotoScene("game_lobby", {effect = "fade", time=1000})
			elseif (playerGroup2.y == 36) then
				composer.hideOverlay("2nd_floor_lobby")
				composer.gotoScene("2nd_floor_lobby_X")
			end

			up.alpha = 1
			right.alpha = 1
			left.alpha = 1
			down.alpha = 1

		end
	end

	up:addEventListener("touch", touchEventListener)
	down:addEventListener("touch", touchEventListener)
	left:addEventListener("touch", touchEventListener)
	right:addEventListener("touch", touchEventListener)

	Runtime:addEventListener("enterFrame", moveCharacter)

	local function stopMove ( event )
		if event.phase == "began" or event.phase == "moved" or event.phase == "ended" then
			movingDirection = nil
			-- print(">>>>")

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


-- ↓ 상호작용 버튼 클릭 함수 ---------------------------------------------------------------------------------

local function tapinteract_buttonEventListener( event )

	if pX == nil then
		composer.setVariable("playerX2", playerGroup2.x)
		composer.setVariable("playerY2", playerGroup2.y)
	else
		composer.setVariable("playerX2", playerGroup2.x + pX)
		composer.setVariable("playerY2", playerGroup2.y + pY)
	end

	if interact_button[2].alpha == 1 then
		if game1 == 0 then
			audio.pause( 8 )
			audio.play( liarroomSound, { channel = 3, loops = -1})
			composer.gotoScene("liar_black") -- 거짓말쟁이방
		else
			composer.gotoScene("2nd_floor_lobby_success") -- 거짓말쟁이방
		end	
	elseif interact_button[4].alpha == 1 then
		if game2 == 0 then
			audio.pause( 8 )
			--audio.play( default_bgm, { channel = 4, loops = -1})
			composer.gotoScene("rose_black") -- 장미게임
		else
			composer.gotoScene("2nd_floor_lobby_success") -- 장미게임
		end	
	elseif interact_button[3].alpha == 1 then
		if game3 == 0 then
			audio.pause( 8 )
			--audio.play( default_bgm, { channel = 5, loops = -1})
			composer.gotoScene("artist_black") -- 예술가의방
		else
			composer.gotoScene("2nd_floor_lobby_success") -- 예술가의방
		end	
	else 
		print("상호작용 버튼을 탭함")
	end
end

interact_button[2]:addEventListener("tap", tapinteract_buttonEventListener)
interact_button[3]:addEventListener("tap", tapinteract_buttonEventListener)
interact_button[4]:addEventListener("tap", tapinteract_buttonEventListener)

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
		composer.removeScene("2nd_floor_lobby")
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
--composer.recycleOnSceneChange = true
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene