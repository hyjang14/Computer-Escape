-----------------------------------------------------------------------------------------
--
-- mainScript4.lua
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local talk1 = display.newImage("image/대화창/대화창1.png")
	talk1.x, talk1.y = display.contentWidth/2, display.contentHeight * 0.76

	-- ↑ 대화창 -------------------------------------------------------------------------------------------------

	local dialog = display.newGroup()

	local image_pi1 = display.newImage("image/캐릭터/파이 결심.png")
	image_pi1.x, image_pi1.y = display.contentWidth*0.2, display.contentHeight*0.5
	image_pi1.name = "파이"

	local speaker = display.newText(dialog, "파이", display.contentWidth*0.25, display.contentHeight*0.73, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker)
	speaker:setFillColor(0)
	speaker.size = 50
	
	local content = display.newText(dialog, "됐어! 이제 그 수상한 메일을 다시 확인해보자.", display.contentWidth*0.5, display.contentHeight*0.88, display.contentWidth*0.7, display.contentHeight*0.2, font_Content)
	content:setFillColor(0)
	content.size = 40

	sceneGroup:insert(dialog)
	sceneGroup:insert(image_pi1)
	sceneGroup:insert(talk1)
	sceneGroup:insert(speaker)
	sceneGroup:insert(content)


	-- json에서 정보 읽기
	local Data = jsonParse("json/mainScript4.json")

	-- json에서 읽은 정보 적용하기
	local index = 0

	local function nextScript( event )
		index = index + 1

		if(index > #Data) then 
			--composer.gotoScene( "2층.2층로비" ) 
			return
		end
		
		speaker.text = Data[index].speaker
		content.text = Data[index].content
	end
	talk1:addEventListener("tap", nextScript)

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
		composer.removeScene( "mainScript4" )
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
