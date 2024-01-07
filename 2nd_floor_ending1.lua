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

-- ↓ 플레이어 ---------------------------------------------------------------------------------------------------
	local num = composer.getVariable("num")
	if num == nil then 
		num = 1
	end
	local playerGroup2 = display.newGroup()
	local player = {} 

	for i = 1, 4 do
		player[i] = {}
	end

	-- 앞
	for i = 1, 4 do
		player[1][i] = display.newImageRect("image/캐릭터/pixil(앞)-"..(i - 1)..".png", 120, 120)
		player[1][i].x, player[1][i].y = display.contentWidth*0.5, display.contentHeight*0.2 
		player[1][i].alpha = 0

		playerGroup2:insert(player[1][i])
	end
	-- 뒤
	for i = 1, 4 do
		player[2][i] = display.newImageRect("image/캐릭터/pixil(뒤)-"..(i - 1)..".png", 120, 120)
		player[2][i].x, player[2][i].y = display.contentWidth*0.5, display.contentHeight*0.5
		player[2][i].alpha = 0

		playerGroup2:insert(player[2][i])
	end
	-- 왼쪽
	for i = 1, 4 do
		player[3][i] = display.newImageRect("image/캐릭터/pixil(왼)-"..(i - 1)..".png", 120, 120)
		player[3][i].x, player[3][i].y = display.contentWidth*0.85, display.contentHeight*0.5
		player[3][i].alpha = 0

		playerGroup2:insert(player[3][i])
	end
	-- 오른쪽
	for i = 1, 4 do
		player[4][i] = display.newImageRect("image/캐릭터/pixil(오른)-"..(i - 1)..".png", 120, 120)
		player[4][i].x, player[4][i].y = display.contentWidth*0.2, display.contentHeight*0.5
		player[4][i].alpha = 0

		playerGroup2:insert(player[4][i])
	end

	sceneGroup:insert(playerGroup2)

	if(num == 1) then
		player[4][1].alpha = 1 -- 처음 모습
	elseif(num == 2) then
		player[1][1].alpha = 1 -- 처음 모습
	elseif(num == 3) then
		player[3][1].alpha = 1 -- 처음 모습
	end
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

-- ↓ 플레이어 이동 함수 정리 --------------------------------------------------------------------------------------

	local index = 1 -- 현재 보여지는 백신 이미지의 인덱스
	local playerFrameChangeInterval = 1000 -- 이미지 변경 간격 (밀리초 단위)
	local md = nil
	local s = 0
	
	local function moveplayerImage()
		if num == 2 then
			if index == 1 then
				player[1][4].alpha = 0
			else
				player[1][index - 1].alpha = 0
			end
			player[1][index].alpha = 1
	
			s = s + 0.2
			if s == 1.2 then
				index = index + 1
				s = 0
			end
			if index == 5 then
				index = 1
			end
	
		elseif num == 3 then
			if index == 1 then
				player[3][4].alpha = 0
			else
				player[3][index - 1].alpha = 0
			end
			player[3][index].alpha = 1
	
			s = s + 0.2
			if s == 1.2 then
				index = index + 1
				s = 0
			end
			if index == 5 then
				index = 1
			end
	
		elseif num == 1 then
			if index == 1 then
				player[4][4].alpha = 0
			else
				player[4][index - 1].alpha = 0
			end
			player[4][index].alpha = 1
	
			s = s + 0.2
			if s == 1.2 then
				index = index + 1
				s = 0
			end
			if index == 5 then
				index = 1
			end

		end
	end
				
			
			
	local currentplayerFrame = 1 -- 현재 보여지는 백신 이미지의 인덱스
	local playerFrameChangeInterval = 100 -- 이미지 변경 간격 (밀리초 단위)

	-- 1초마다 changeVaccineImage 함수 호출
	local playerTimerID = timer.performWithDelay(playerFrameChangeInterval, changeplayerImage, 0)

	if num == 1 then

		local startX = display.contentWidth / 2 - 400 -- 시작 X 좌표
		local startY = display.contentHeight / 2 -- 시작 Y 좌표
		local centerX = display.contentWidth / 2 - 400 -- 화면의 정중앙 X 좌표

		local moveSpeed = 4.7

		local function moveToTargetPosition(event)
			local dx = centerX - playerGroup2.x
			local distance = math.abs(dx) -- 수평 방향으로의 거리만 사용

			if distance > moveSpeed then
				local direction = dx > 0 and 1 or -1 -- 이동 방향 결정
				playerGroup2.x = playerGroup2.x + moveSpeed * direction
			else
				playerGroup2.x = centerX
				Runtime:removeEventListener("enterFrame", moveToTargetPosition) -- 이동 완료 후 이벤트 리스너 제거
				composer.gotoScene("2nd_floor_Vaccine1")
			end
		end

		Runtime:addEventListener("enterFrame", moveToTargetPosition)

	elseif num == 2 then

		local startX = display.contentWidth / 2  -- 시작 X 좌표
		local startY = display.contentHeight / 2 -- 시작 Y 좌표
		local centerY = display.contentWidth / 2 - 650 -- 화면의 정중앙 Y 좌표

		local moveSpeed = 4.7

		local function moveToTargetPosition(event)
			local dy = centerY - playerGroup2.y
			local distance = math.abs(dy) -- 수직 방향으로의 거리만 사용

			if distance > moveSpeed then
				local direction = dy > 0 and 1 or -1 -- 이동 방향 결정
				playerGroup2.y = playerGroup2.y + moveSpeed * direction
			else
				playerGroup2.y = centerY
				Runtime:removeEventListener("enterFrame", moveToTargetPosition) -- 이동 완료 후 이벤트 리스너 제거
				composer.gotoScene("2nd_floor_Vaccine1")
			end
		end

		Runtime:addEventListener("enterFrame", moveToTargetPosition)

	elseif num == 3 then

		local centerX = display.contentWidth / 2 - 1650-- 화면의 정중앙 X 좌표

		local moveSpeed = 4.7

		local function moveToTargetPosition(event)
			local dx = centerX - playerGroup2.x 
			local distance = math.abs(dx) -- 수평 방향으로의 거리만 사용

			if distance > moveSpeed then
				local direction = dx > 0 and 1 or -1 -- 이동 방향 결정
				playerGroup2.x = playerGroup2.x + moveSpeed * direction
			else
				playerGroup2.x = centerX
				Runtime:removeEventListener("enterFrame", moveToTargetPosition) -- 이동 완료 후 이벤트 리스너 제거
				composer.gotoScene("2nd_floor_Vaccine1")
			end
		end

		Runtime:addEventListener("enterFrame", moveToTargetPosition)

	end
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
		--composer.removeScene("2층.2층로비")
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