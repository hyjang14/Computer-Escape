-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	audio.pause(7)
	audio.play( mansionSound, { channel = 8, loops = -1})
	audio.setVolume( 0.3, { channel=8 } )
	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newImageRect("image/배경/배경_저택_1층.png", display.contentWidth/2, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	local chatBox = display.newImage("image/UI/대화창 ui.png")
	chatBox.x, chatBox.y = display.contentWidth/2, display.contentHeight * 0.78
	
	sceneGroup:insert(inventory)
	sceneGroup:insert(question)

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	local dialog = display.newGroup()

	local image_cherry = display.newImage("image/캐릭터/체리 기본.png")
	image_cherry.x, image_cherry.y = display.contentWidth*0.8, display.contentHeight*0.5
	image_cherry.name = "체리"

	local image_pi = display.newImage("image/캐릭터/파이 기본.png")
	image_pi.x, image_pi.y = display.contentWidth*0.2, display.contentHeight*0.5
	image_pi.name = "파이"
	image_pi.alpha = 0

	local speaker = display.newText(dialog, "체리", display.contentWidth*0.25, display.contentHeight*0.76, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker)
	speaker:setFillColor(0)
	speaker.size = 50
	
	local content = display.newText(dialog, "어서 와~ 모험의 저택, ‘Hunt’에 온 걸 환영...", display.contentWidth*0.5, display.contentHeight*0.902, display.contentWidth*0.7, display.contentHeight*0.2, font_Content)
	content:setFillColor(0)
	content.size = 40

	sceneGroup:insert(dialog)
	sceneGroup:insert(image_cherry)
	sceneGroup:insert(image_pi)
	sceneGroup:insert(chatBox)
	sceneGroup:insert(speaker)
	sceneGroup:insert(content)


	-- json에서 정보 읽기
	local Data = jsonParse("1st_floor_json/firstMeet.json")

	-- json에서 읽은 정보 적용하기
	local index = 0

	local function nextScript( event )
		index = index + 1

		if(index > #Data) then 
			composer.gotoScene( "game_lobby" ) 
			return
		end
		
		speaker.text = Data[index].speaker
		content.text = Data[index].content

		if(Data[index].speaker == image_cherry.name) then
			image_cherry.alpha = 1
			image_pi.alpha = 0

		else
			image_cherry.alpha = 0
			image_pi.alpha = 1
		end

		image_cherry.fill = {
			type = "image",
			filename = Data[index].image
		}
		image_pi.fill = {
			type = "image",
			filename = Data[index].image
		}

	end
	chatBox:addEventListener("tap", nextScript)
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
		composer.removeScene( "cherryFirstMeet" )
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
