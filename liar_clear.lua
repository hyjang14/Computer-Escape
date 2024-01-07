-----------------------------------------------------------------------------------------
--
-- claer.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

-- ↓ 시작화면 배치 -----------------------=----------------------------------------------------------------------
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	background:setFillColor(0.1, 1) -- 전체 화면

	local room = display.newImage( "image/배경/배경_저택_거짓말쟁이 스포트라이트.png", display.contentWidth*0.5, display.contentHeight*0.5)
	room:scale(0.9, 0.9) -- 게임 방

	local explanation = display.newImage("image/UI/물음표.png")
	explanation.x, explanation.y = 100, 80
	explanation.alpha = 0

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80
	inventory.alpha = 0

	local item_Change = display.newImage("image/UI/빈원형.png")
	item_Change.x, item_Change.y = 1740, 680
	item_Change.alpha = 0

	-- ↓ 방향키 --------------------------------------

	local up = display.newImage("image/UI/콘솔(상).png")
	up.x, up.y = 330, 696
	up.name  = "up"
	up.alpha = 0

	local right = display.newImage("image/UI/콘솔(우).png")
	right.x, right.y = 443, 810
	right.name = "right"
	right.alpha = 0

	local left = display.newImage("image/UI/콘솔(좌).png")
	left.x, left.y = 217, 810
	left.name = "left"
	left.alpha = 0

	local down = display.newImage("image/UI/콘솔(하).png")
	down.x, down.y = 330, 924
	down.name = "down"
	down.alpha = 0

	--  -----------
	local stopUp = display.newImage("image/UI/상_스트로크.png")
	stopUp.x, stopUp.y = 330, 697
	stopUp.alpha = 0
	
	local stopRight = display.newImage("image/UI/우_스트로크.png")
	stopRight.x, stopRight.y = 442, 810
	stopRight.alpha = 0

	local stopLeft = display.newImage("image/UI/좌_스트로크.png")
	stopLeft.x, stopLeft.y = 218, 810
	stopLeft.alpha = 0

	local stopDown = display.newImage("image/UI/하_스트로크.png")
	stopDown.x, stopDown.y = 330, 923
	stopDown.alpha = 0

	local character = display.newImageRect("image/캐릭터/pixil(뒤)-0.png", 120, 120)
	character.x, character.y = display.contentWidth*0.5, display.contentHeight*0.5   -- 주인공

	-- ↓ 대화창 ----------------------------------------------------------------------------------------------------
	local talk1 = display.newImage("image/UI/대화창 ui.png")
	talk1.x, talk1.y = display.contentWidth*0.5, display.contentHeight*0.7 
	talk1:scale(0.63, 0.78) -- 대화창
	
	local key = display.newImage("image/자물쇠/1자열쇠.png")
	key.x, key.y = display.contentWidth*0.5, display.contentHeight*0.65   -- 키
	key:scale(0.1, 0.1)
	key.alpha = 0

	local interact_button = display.newImage("image/UI/커서.png")
	interact_button.x, interact_button.y = 1560, 810
	interact_button.alpha = 0

	local personGroup = composer.getVariable( "personGroup" )  

	-- 레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(room)
	sceneGroup:insert(explanation)
	sceneGroup:insert(inventory)
	sceneGroup:insert(item_Change)
	sceneGroup:insert(character)
	sceneGroup:insert(talk1)
	sceneGroup:insert(key)
	sceneGroup:insert(up)
	sceneGroup:insert(down)
	sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(stopUp)
	sceneGroup:insert(stopDown)
	sceneGroup:insert(stopLeft)
	sceneGroup:insert(stopRight)
	sceneGroup:insert(interact_button)
	sceneGroup:insert(personGroup)

-- ↑ 시작화면 배치 ---------------------------------------------------------------------------------------
-- ↓ json ----------------------------------------------------------------------------------
	local Data = jsonParse( "liar_json/win.json" )

	local dialog = display.newGroup()

	local speaker = display.newText(dialog, Data[1].speaker, display.contentWidth*0.37, display.contentHeight*0.68, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker)
	speaker:setFillColor(0)
	speaker.size = 45

	local content = display.newText(dialog, Data[1].content, display.contentWidth*0.62, display.contentHeight*0.83, display.contentWidth*0.7, display.contentHeight*0.2, font_Content)
	content:setFillColor(0)
	content.size = 35

	if Data then
		print(Data[1].speaker)
		print(Data[1].content)
	end
	local index = 0
	local function nextScript( event )
		index = index + 1
		if(index > #Data) then 
			display.remove(dialog)
			display.remove(talk1)
			key.alpha = 1
			explanation.alpha = 1
			inventory.alpha = 1
			item_Change.alpha = 0
			interact_button.alpha = 0.5
			up.alpha = 0.5
			down.alpha = 0.5
			left.alpha = 0.5
			right.alpha = 0.5
			stopUp.alpha = 1
			stopDown.alpha = 1
			stopLeft.alpha = 1
			stopRight.alpha = 1
			display.remove(character)
			local character = display.newImageRect("image/캐릭터/pixil(앞)-0.png", 120, 120)
			character.x, character.y = display.contentWidth*0.5, display.contentHeight*0.5   -- 주인공
			sceneGroup:insert(character)
			return
		end
		speaker.text = Data[index].speaker
		content.text = Data[index].content
	end

	talk1:addEventListener("tap", nextScript)
	dialog:toFront()

-- ↑ json ----------------------------------------------------------------------------------
-- ↓ key획득 -----------------------------------------------------------------------------------
	local function keytap( event )
		if itemNum[1] == false then
			itemNum[1] = true
			audio.play(itemGetSound)
		end
		composer.setVariable( "personGroup" , personGroup)
		composer.hideOverlay("liar_clear")
		composer.gotoScene("liar_clear2") -- clear2으로 넘어가기
	end

	key:addEventListener("tap", keytap)
-- ↑ key획득 -----------------------------------------------------------------------------------

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
		composer.removeScene('liar_clear') -- 추가
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