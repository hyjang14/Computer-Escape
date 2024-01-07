-----------------------------------------------------------------------------------------
--
-- 백신1
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local gunSound = audio.loadSound( "sound/총 장전.mp3" )
	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newImageRect("image/배경/배경_저택_2층로비.png", 1900, 1210)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2 - 50

	local pi = display.newImageRect("image/캐릭터/pixil(앞)-0.png", 120, 120)
	pi.x, pi.y = display.contentWidth/2, display.contentHeight/2

	local index = composer.getVariable("index")
	if index == nil then
		index = 1
	end

	local Vaccine = display.newImageRect("image/캐릭터/백신각성 뒤0.png", 120, 120)
	Vaccine.x, Vaccine.y = display.contentWidth/2, display.contentHeight/2 + 400 - (index * 50)

	local gun2 = display.newImageRect("image/오브제/gun.png", 100,100)
	gun2.x, gun2.y = display.contentWidth*0.9, display.contentHeight*0.63

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local explanation = display.newImage("image/UI/물음표.png")
	explanation.x, explanation.y = 100, 80

	local item_Change = display.newImage("image/UI/빈원형.png")
	item_Change.x, item_Change.y = 1740, 680

	local finger = display.newImage("image/UI/포인터.png")
	finger.x, finger.y = 1560, 840
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


	sceneGroup:insert(background)
	sceneGroup:insert(pi)
	sceneGroup:insert(Vaccine)
	sceneGroup:insert(inventory)
	sceneGroup:insert(explanation)
	sceneGroup:insert(item_Change)
	sceneGroup:insert(up)
	sceneGroup:insert(right)
	sceneGroup:insert(left)
	sceneGroup:insert(down)
	sceneGroup:insert(stopUp)
	sceneGroup:insert(stopRight)
	sceneGroup:insert(stopLeft)
	sceneGroup:insert(stopDown)
	sceneGroup:insert(finger)
	sceneGroup:insert(gun2)

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	-- ↓ 상호작용 함수 -------------------------------------------------------------------------------------------------
	
	
	local function tap( event )
		if index == 1 then
			composer.gotoScene("2nd_floor_Vaccine2")
			Vaccine.y = Vaccine.y - 50
		elseif  index == 2 then
			composer.gotoScene("2nd_floor_Vaccine3")
			Vaccine.y = Vaccine.y - 100
		elseif  index == 3 then
			composer.gotoScene("2nd_floor_Vaccine4")
			Vaccine.y = Vaccine.y - 150
		elseif  index == 4 then
			audio.play(gunSound)
			composer.gotoScene("2nd_floor_Vaccine5")
		end
	end
	finger:addEventListener("tap", tap)

	
	 
	-- ↓ 체리 상호작용 함수 -------------------------------------------------------------------------------------------------

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
		composer.removeScene( "2nd_floor_ending2" )
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
