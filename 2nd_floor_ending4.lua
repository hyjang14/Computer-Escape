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

	local cursor = display.newImage("image/UI/커서.png")
	cursor.x, cursor.y = 1560, 840
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
	sceneGroup:insert(cursor)

-- ↑ 시작화면 배치 ---------------------------------------------------------------------------------------------
-- ↓ 플레이어 ---------------------------------------------------------------------------------------------------
	local player = display.newImageRect("image/캐릭터/pixil(앞)-0.png", 120, 120)
	player.x, player.y = display.contentWidth*0.5, display.contentHeight*0.5 
	player.alpha = 1

	sceneGroup:insert(up)
	sceneGroup:insert(right)
	sceneGroup:insert(left)
	sceneGroup:insert(down)
	sceneGroup:insert(stopUp)
	sceneGroup:insert(stopRight)
	sceneGroup:insert(stopLeft)
	sceneGroup:insert(stopDown)
	sceneGroup:insert(player)

-- ↑ 플레이어 ---------------------------------------------------------------------------------------------------

-- ↓ 플레이어 이동 함수 정리 --------------------------------------------------------------------------------------
	local startX = display.contentWidth / 2  -- 시작 X 좌표
	local startY = display.contentHeight / 2 -- 시작 Y 좌표
	local centerY = display.contentWidth / 2  -- 화면의 정중앙 Y 좌표

	local moveSpeed = 3

	local function moveToTargetPosition(event)
		local dy = centerY - player.y
		local distance = math.abs(dy) -- 수직 방향으로의 거리만 사용

		if distance > moveSpeed then
			local direction = dy > 0 and 1 or -1 -- 이동 방향 결정
			player.y = player.y + moveSpeed * direction
		else
			player.y = centerY
			Runtime:removeEventListener("enterFrame", moveToTargetPosition) -- 이동 완료 후 이벤트 리스너 제거
			composer.gotoScene("game_ending_lobby", {effect = "fade", time=1000})
		end
	end

	Runtime:addEventListener("enterFrame", moveToTargetPosition)

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