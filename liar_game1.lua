-----------------------------------------------------------------------------------------
--
-- game1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local heartGroup = display.newGroup()
-- ↓ 시작화면 배치 -----------------------------------------------------------------------------------------------

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	background:setFillColor(0.1, 1) -- 전체 화면

	local room = display.newImage( "image/배경/배경_저택_거짓말쟁이 스포트라이트.png", display.contentWidth*0.5, display.contentHeight*0.5)
	room:scale(0.9, 0.9) -- 게임 방

	local character = display.newImageRect("image/캐릭터/pixil(뒤)-0.png", 120, 120)
	character.x, character.y = display.contentWidth*0.5, display.contentHeight*0.5   -- 주인공

	local character2 = display.newImageRect("image/캐릭터/pixil(앞)-0.png", 120, 120)
	character2.x, character2.y = display.contentWidth*0.5, display.contentHeight*0.5 
	character2.alpha = 0


	-- ↓ 대화창 ----------------------------------------------------------------------------------------------------
	local talk1 = display.newImage("image/UI/대화창 ui.png")
	talk1.x, talk1.y = display.contentWidth*0.5, display.contentHeight*0.7 
	talk1:scale(0.63, 0.78) -- 대화창
	
	-- ↓ 하트 ----------------------------------------------------------------------------------------------------
	local heart1 = display.newImage(heartGroup, "image/거짓말쟁이방/heart.png")
	heart1.x, heart1.y = display.contentWidth*0.24, display.contentHeight*0.1 
	heart1:scale(0.15, 0.15)

	local heart2 = display.newImage(heartGroup, "image/거짓말쟁이방/heart.png")
	heart2.x, heart2.y = display.contentWidth*0.3, display.contentHeight*0.1
	heart2:scale(0.15, 0.15)

	local heart3 = display.newImage(heartGroup, "image/거짓말쟁이방/heart.png")
	heart3.x, heart3.y = display.contentWidth*0.36, display.contentHeight*0.1
	heart3:scale(0.15, 0.15)

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80
	question.alpha = 0

	local questBox = display.newImage("image/UI/퀘스트.png")
	questBox.x, questBox.y = display.contentWidth*0.198, display.contentHeight*0.285
	questBox.alpha = 0

	composer.setVariable( "heartGroup", heartGroup )

	local personGroup = composer.getVariable( "personGroup")
	-- 레이어 정리
	sceneGroup:insert(heartGroup)
	sceneGroup:insert(background)
	sceneGroup:insert(room)
	sceneGroup:insert(personGroup)
	sceneGroup:insert(character)
	sceneGroup:insert(character2)
	sceneGroup:insert(talk1)
	sceneGroup:insert(question)
	sceneGroup:insert(questBox)

-- ↑ 시작화면 배치 ----------------------------------------------------------------------------------------------



-- ↓ json1에서 정보 읽고 적용 ----------------------------------------------------------------------------------
	local Data = jsonParse( "liar_json/liar_game_start.json" )

	local dialog = display.newGroup()

	local speaker = display.newText(dialog, Data[1].speaker, display.contentWidth*0.37, display.contentHeight*0.68, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker)
	speaker:setFillColor(0)
	speaker.size = 45

	local content = display.newText(dialog, Data[1].content, display.contentWidth*0.62, display.contentHeight*0.83, display.contentWidth*0.7, display.contentHeight*0.2, font_Content)
	content:setFillColor(0)
	content.size = 35

	local quest = display.newText(dialog, Data[#Data].content, display.contentWidth*0.195, display.contentHeight*0.3, font_Content, 40)
	quest:setFillColor(0)

	if Data then
		print(Data[1].speaker)
		print(Data[1].content)
		print(Data[1].quest)
	end
	local index = 0

	local function nextScript( event )
		index = index + 1
		if ( index == #Data ) then
			audio.play(questSound)
			question.alpha = 1
			questBox.alpha = 0.6
			talk1.alpha = 0
			character.alpha = 0
			character2.alpha = 1
		end

		if(index > #Data) then 
			display.remove(dialog)
			audio.play(darkSound)
			composer.hideOverlay("liar_game1")
			composer.gotoScene("liar_game_start") 
			return
		end

		speaker.text = Data[index].speaker
		content.text = Data[index].content
		quest.text = Data[index].quest
	end

	talk1:addEventListener("tap", nextScript)
	questBox:addEventListener("tap", nextScript)
	question:addEventListener("tap", nextScript)
	dialog:toFront()

-- ↑ json1에서 정보 읽고 적용 ----------------------------------------------------------------------------------
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
		composer.removeScene('liar_game1') -- 추가
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
