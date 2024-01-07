-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local backgroundY = composer.getVariable("backgroundY")

	local background = display.newImageRect("image/배경/배경_저택_1층.png", 2000, 2000)
	background.x, background.y = display.contentWidth/2, backgroundY
	sceneGroup:insert(background)

	--[[ 파이
	local pi_X = composer.getVariable("pi_X")
	local pi = display.newImageRect("image/캐릭터/pixil(뒤)-0.png", 120, 120)
	pi.x, pi.y = pi_X, 995
	sceneGroup:insert(pi)]]

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	sceneGroup:insert(inventory)
	sceneGroup:insert(question)


	-- 게임 관련
	local sim = composer.getVariable("sim")
	if sim == nil then
		sim = 1
	end

	local image_in = display.newImage("image/자물쇠/자물쇠게임_안.png")
	image_in.x, image_in.y = display.contentCenterX, display.contentCenterY

	local volume = display.newImageRect("image/자물쇠/볼륨.png", 70, 70)
	volume.x, volume.y = display.contentWidth* 0.64, display.contentHeight*0.55

	local image_front = display.newImage("image/자물쇠/자물쇠게임_앞.png")
	image_front.x, image_front.y = display.contentCenterX, display.contentCenterY

	local wifiSim = display.newImageRect("image/자물쇠/심(와이파이).png", 38, 38)
	wifiSim.x, wifiSim.y = display.contentWidth * 0.37, display.contentHeight * 0.165

	if sim == 0 then
		wifiSim.alpha = 0
	end

	sceneGroup:insert(image_in)
	sceneGroup:insert(volume)
	sceneGroup:insert(image_front)
	sceneGroup:insert(wifiSim)

	local frontGroup = display.newGroup()

	frontGroup:insert(image_front)
	frontGroup:insert(wifiSim)

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	-- ↓ 함수 정리 ------------------------------------------------------------------------------------------------------------

	local function open( event )
		if( event.phase == "began" ) then
			event.target.isFocus = true
			-- 드래그 시작할 때
			event.target.initX = event.target.x

		elseif ( event.phase == "moved" ) then
			
			if ( event.target.isFocus ) then
				-- 드래그 중일 때
				event.target.x = event.xStart + event.xDelta
				wifiSim.x = display.contentWidth * 0.37  + event.xDelta
				
			end
			
		elseif ( event.phase == "ended" or event.phase == "cancelled"  ) then
			if ( event.target.x > display.contentWidth*0.6 ) then
				image_front.alpha = 0
				wifiSim.alpha = 0
				volume.alpha = 1
			else
				event.target.x = event.target.initX
				wifiSim.x = display.contentWidth * 0.37
			end
		end
		return true
	end
	image_front:addEventListener( "touch" , open )

	-- 소리 나오는거 
	local function vol(event)

	end
	volume:addEventListener("tap", vol)

	-- 심 얻음
	local function wifi(event)
		sim = 0
		wifiSim.alpha = 0
		composer.setVariable("wifisim", 1)
		showItemNumber = showItemNumber + 1
	end
	wifiSim:addEventListener("tap", wifi)

	-- ↓ 인벤토리 함수 -------------------------------------------------------------------------------------------------

	local function inven( event )
		composer.showOverlay("inventoryScene", {isModal = true})
	end
	inventory:addEventListener("tap", inven)
	local next = composer.getVariable("next")
	-- 나가기
	local function back(event)
		composer.setVariable("sim", sim)
		-- composer.hideOverlay("key_lockingImage_2")
		if(next == 0) then
			composer.gotoScene("game_lobby")
		elseif(next == 1) then
			composer.gotoScene("game_ending_lobby")
		end
	end
	background:addEventListener("tap", back)
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
		composer.removeScene( "key_lockingImage_2" )
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
