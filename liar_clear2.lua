-----------------------------------------------------------------------------------------
--
-- claer2.lua
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

	local character = display.newImageRect("image/캐릭터/pixil(앞)-0.png", 120, 120)
	character.x, character.y = display.contentWidth*0.5, display.contentHeight*0.5   -- 주인공

	local talk1 = display.newImage("image/UI/대화창 ui.png")
	talk1.x, talk1.y = display.contentWidth*0.5, display.contentHeight*0.7 
	talk1:scale(0.63, 0.78) -- 대화창
	
	local personGroup = composer.getVariable( "personGroup" )  

	-- 레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(room)
	sceneGroup:insert(character)
	sceneGroup:insert(talk1)
	sceneGroup:insert(personGroup)

-- ↑ 시작화면 배치 ---------------------------------------------------------------------------------------
-- ↓ json ----------------------------------------------------------------------------------
	local Data = jsonParse( "liar_json/key.json" )

	local dialog = display.newGroup()

	local content = display.newText(dialog, Data[1].content, display.contentWidth*0.63, display.contentHeight*0.78, display.contentWidth*0.5, display.contentHeight*0.2, font_Speaker)
	content:setFillColor(0)
	content.size = 45

	if Data then
		print(Data[1].content)
	end
	local index = 0

	local function nextScript( event )
		index = index + 1
		if(index > #Data) then 
			display.remove(dialog)
			composer.hideOverlay("liar_clear2")
			composer.gotoScene("liar_black2")  -- 암전
			return
		end

		content.text = Data[index].content
	end

	talk1:addEventListener("tap", nextScript)
	dialog:toFront()

-- ↑ json ----------------------------------------------------------------------------------
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
		composer.removeScene('liar_clear2') -- 추가
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
composer.recycleOnSceneChange = true
return scene