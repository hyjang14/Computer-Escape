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

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local chatBox = display.newImage("image/UI/대화창 ui.png")
	chatBox.x, chatBox.y = display.contentWidth/2, display.contentHeight * 0.78

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	-- json에서 정보 읽기
	local Data = jsonParse("1st_floor_json/cherry_Ribbon_2.json")

	local dialog = display.newGroup()

	local image_cherry = display.newImage("image/캐릭터/체리 리본.png")
	image_cherry.x, image_cherry.y = display.contentWidth*0.8, display.contentHeight*0.5
	image_cherry.name = "체리"

	local image_pi = display.newImage("image/캐릭터/파이 결심.png")
	image_pi.x, image_pi.y = display.contentWidth*0.2, display.contentHeight*0.5
	image_pi.name = "파이"
	image_pi.alpha = 0

	local speaker
	speaker = display.newText(dialog, Data[1].speaker , display.contentWidth*0.25, display.contentHeight*0.76, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker)
	speaker.size = 50
	speaker:setFillColor(0)
	
	local content = display.newText(dialog, Data[1].content, display.contentWidth*0.5, display.contentHeight*0.902, display.contentWidth*0.7, display.contentHeight*0.2, font_Content)
	content.size = 40
	content:setFillColor(0)

	sceneGroup:insert(dialog)
	sceneGroup:insert(image_cherry)
	sceneGroup:insert(image_pi)

	sceneGroup:insert(chatBox)
	sceneGroup:insert(speaker)
	sceneGroup:insert(content)


	-- json에서 읽은 정보 적용하기
	local index = 1
	local i = 0

	local function nextScript( event )
		index = index + 1

		if(index > #Data) then 
			composer.hideOverlay("cherry_Ribbon_2")
			composer.gotoScene( "ending" ) 
			return
		end

		speaker.text = Data[index].speaker
		content.text = Data[index].content

		if(Data[index].speaker == image_cherry.name) then
			image_cherry.fill = {
				type = "image",
				filename = Data[index].image
			}
			image_cherry.alpha = 1
			image_pi.alpha = 0
		else
			image_pi.fill = {
				type = "image",
				filename = Data[index].image
			}

			image_cherry.alpha = 0
			image_pi.alpha = 1
		end

	end
	chatBox:addEventListener("tap", nextScript)
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
		composer.removeScene( "cherry_Ribbon_2" )
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
