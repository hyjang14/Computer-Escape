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
	local pictureY = composer.getVariable("pictureY")

	local background = display.newImageRect("image/배경/배경_저택_1층.png", 2000, 2000)
	background.x, background.y = display.contentWidth/2, backgroundY
	sceneGroup:insert(background)
	
	-- 파이
	local pi_X = composer.getVariable("pi_X")
	local pi = display.newImageRect("image/캐릭터/pixil(앞)-0.png", 120, 120)
	pi.x, pi.y = pi_X, display.contentHeight/2 + 30
	pi.alpha = 0

	sceneGroup:insert(pi)

	-- 액자
	local frame = {}
	for i = 1, 4 do
		frame[i] = display.newImageRect("image/저택그림/액자"..i..".png", 130, 130)
		sceneGroup:insert(frame[i])
	end
	frame[1].x, frame[1].y =  display.contentWidth * 0.16, pictureY
	frame[2].x, frame[2].y =  display.contentWidth * 0.29, pictureY
	frame[3].x, frame[3].y =  display.contentWidth * 0.72, pictureY
	frame[4].x, frame[4].y =  display.contentWidth * 0.85, pictureY

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------
	
	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	local chatBox = display.newImage("image/UI/대화창 ui.png")
	chatBox.x, chatBox.y = display.contentWidth/2, display.contentHeight * 0.78

	local questBox = display.newImage("image/UI/퀘스트창.png")
	questBox.x, questBox.y = display.contentWidth*0.265, display.contentHeight*0.28
	questBox:scale(1.09, 0.73)
	questBox.alpha = 0

	sceneGroup:insert(inventory)
	sceneGroup:insert(question)
	sceneGroup:insert(questBox)

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	local dialog = display.newGroup()

	local image_pi = display.newImage("image/캐릭터/파이 기본.png")
	image_pi.x, image_pi.y = display.contentWidth*0.2, display.contentHeight*0.5

	local speaker = display.newText(dialog, "파이", display.contentWidth*0.25, display.contentHeight*0.76, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker)
	speaker:setFillColor(0)
	speaker.size = 50
	
	local content = display.newText(dialog, "그림이... 오래된 게임이라지만 참 볼품없네.", display.contentWidth*0.5, display.contentHeight*0.902, display.contentWidth*0.7, display.contentHeight*0.2, font_Content)
	content:setFillColor(0)
	content.size = 40

	local quest = display.newText(dialog, "", display.contentWidth*0.265, display.contentHeight*0.3, font_Content, 40)
	quest:setFillColor(0)

	sceneGroup:insert(dialog)
	sceneGroup:insert(image_pi)
	sceneGroup:insert(chatBox)
	sceneGroup:insert(quest)
	sceneGroup:insert(speaker)
	sceneGroup:insert(content)


	-- json에서 정보 읽기
	local Data = jsonParse("1st_floor_json/picture.json")

	-- json에서 읽은 정보 적용하기
	local index = 0

	local function nextScript( event )
		index = index + 1
		if ( index == #Data ) then
			audio.play(questSound)
			pi.alpha = 1
			question.alpha = 1
			questBox.alpha = 0.6
			chatBox.alpha = 0
			image_pi.alpha = 0
		end

		if(index > #Data) then 
			composer.hideOverlay("picturejson")
			composer.gotoScene( "game_lobby" ) 
			return
		end
		
		speaker.text = Data[index].speaker
		content.text = Data[index].content
		quest.text = Data[index].quest

	end
	chatBox:addEventListener("tap", nextScript)
	questBox:addEventListener("tap", nextScript)
	question:addEventListener("tap", nextScript)
	-- image_cherry::addEventListener("tap", nextScript)
	-- image_pi::addEventListener("tap", nextScript)

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
		composer.removeScene( "picturejson" )
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
