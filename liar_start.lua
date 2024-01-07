-----------------------------------------------------------------------------------------
--
-- start.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	audio.play(darkSound)
		
	audio.play(liarroomSound, { channel = 3, loops = -1 })
	audio.setVolume(0.7, {channel = 3})
	audio.resume(3)
-- ↓ 시작화면 배치 -----------------------------------------------------------------------------------------------

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	background:setFillColor(0.1, 1) -- 전체 화면

	local room = display.newImage( "image/배경/배경_저택_거짓말쟁이 스포트라이트.png", display.contentWidth*0.5, display.contentHeight*0.5)
	--room:setFillColor(0.4, 0.4) -- 게임 방
	room:scale(0.9, 0.9)

	local explanation = display.newImage("image/UI/물음표.png")
	explanation.x, explanation.y = 100, 80

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local item_Change = display.newImage("image/UI/빈원형.png")
	item_Change.x, item_Change.y = 1740, 680

	local interact_extent = display.newRect(display.contentCenterX, display.contentCenterY, 100, 150)
	interact_extent.x, interact_extent.y = display.contentWidth*0.75, display.contentHeight*0.78   -- game으로 넘어갈 수 있는 부분
	interact_extent.alpha = 0
	
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
	sceneGroup:insert(explanation)
	sceneGroup:insert(inventory)
	sceneGroup:insert(item_Change)
	sceneGroup:insert(interact_extent)

-- ↑ 시작화면 배치 ---------------------------------------------------------------------------------------------


-- ↓ 사람 랜덤 배치 ------------------------------------------------------------------------------------------

	local personGroup = display.newGroup();
	local person = {}
	local w = {0.24, 0.37, 0.5, 0.63, 0.76}
	local selectedIndices = {0, 0, 0, 0, 0}  -- 이전에 선택한 인덱스를 저장하는 테이블  1이면 이전에 선택한 인덱스임

	for i = 1, 5 do
		local randomIndex
		repeat
			randomIndex = math.random(#w)  -- 랜덤 인덱스 선택
		until not (selectedIndices[randomIndex] == 1)  -- 선택된 인덱스가 이전에 선택된 값과 겹치지 않도록 반복

		person[i] = display.newImageRect(personGroup, "image/거짓말쟁이방/liar" .. i .. ".png", 120, 120)
		person[i].x, person[i].y = display.contentWidth * w[randomIndex], display.contentHeight * 0.3
		selectedIndices[randomIndex] = 1
	end
	-- 레이어 정리
	sceneGroup:insert(personGroup)

	composer.setVariable( "personGroup", personGroup )

-- ↑ 사람 랜덤 배치 --------------------------------------------------------------------------------------------


-- ↓ 플레이어 ---------------------------------------------------------------------------------------------------
	local playerGroup = display.newGroup()
	local player = {} 

	for i = 1, 4 do
		player[i] = {}
	end

	-- 앞
	for i = 1, 4 do
		player[1][i] = display.newImageRect("image/캐릭터/pixil(앞)-"..(i - 1)..".png", 120, 120)
		player[1][i].x, player[1][i].y = display.contentWidth*0.82, display.contentHeight*0.78 
		player[1][i].alpha = 0

		playerGroup:insert(player[1][i])
	end
	-- 뒤
	for i = 1, 4 do
		player[2][i] = display.newImageRect("image/캐릭터/pixil(뒤)-"..(i - 1)..".png", 120, 120)
		player[2][i].x, player[2][i].y = display.contentWidth*0.82, display.contentHeight*0.78 
		player[2][i].alpha = 0

		playerGroup:insert(player[2][i])
	end
	-- 왼쪽
	for i = 1, 4 do
		player[3][i] = display.newImageRect("image/캐릭터/pixil(왼)-"..(i - 1)..".png", 120, 120)
		player[3][i].x, player[3][i].y = display.contentWidth*0.82, display.contentHeight*0.78 
		player[3][i].alpha = 0

		playerGroup:insert(player[3][i])
	end
	-- 오른쪽
	for i = 1, 4 do
		player[4][i] = display.newImageRect("image/캐릭터/pixil(오른)-"..(i - 1)..".png", 120, 120)
		player[4][i].x, player[4][i].y = display.contentWidth*0.82, display.contentHeight*0.78 
		player[4][i].alpha = 0

		playerGroup:insert(player[4][i])
	end

	sceneGroup:insert(playerGroup)

	player[3][1].alpha = 1 -- 처음 모습

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
			up.alpha = 0.3
		elseif movingDirection == "down" then
			down.alpha = 0.3
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
			if(d == 1) then
				motionLeft = motionLeft + 1
				d = 0
			end
			if motionLeft == 5 then
				motionLeft = 1
			end
			
			if playerGroup.x > room.contentWidth - playerGroup.contentWidth * 15.7 then
				if playerGroup.x == room.contentWidth - playerGroup.contentWidth * 15.6 then
					composer.hideOverlay("liar_start")
					composer.gotoScene("liar_start_black") -- start_black으로 넘어가기
				end
				playerGroup.x = playerGroup.x - moveSpeed

			end
			left.alpha = 0.3
			
		elseif movingDirection == "right" then
			right.alpha = 0.3
		end

	end

	local function touchEventListener(event)
		if event.phase == "began" or event.phase == "moved" then
			-- print("터치를 시작함")
			if event.target == up then
				movingDirection = "up"
			elseif event.target == down then
				movingDirection = "down"
			elseif event.target == left then
				movingDirection = "left"
			
				for i = 1, 4 do
					if i ~= 3 then
						for j = 1, 4 do
							player[i][j].alpha = 0
						end
					end
				end--]]
			elseif event.target == right then
				movingDirection = "right"
			end

		elseif event.phase == "ended" or event.phase == "cancelled" then
			movingDirection = nil

			up.alpha = 0.5
			right.alpha = 0.5
			left.alpha = 0.5
			down.alpha = 0.5
		end
	end

	left:addEventListener("touch", touchEventListener)
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

	stopLeft:addEventListener("touch", stopMove)

-- ↑ 플레이어 이동 함수 정리 -------------------------------------------------------------------------------------------------
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
		composer.removeScene('liar_start') -- 추가
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