-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	sceneGroup:insert(question)

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	audio.play(questSound)

	local questBox = display.newImage("image/UI/퀘스트.png")
	questBox.x, questBox.y = display.contentWidth*0.198, display.contentHeight*0.285

	local options = {

	text = "new 퀘스트\n\n>> [괴물을 쫓아 게임에 들어가 보자.]",
	x = display.contentWidth * 0.21,
	y = display.contentHeight * 0.3,
	width = 550,
	font = font_Content,
	fontSize = 37,
	align = "left" }

	local content = display.newText(options)
	content:setFillColor(0)

	sceneGroup:insert(questBox)
	sceneGroup:insert(content)


	local function nextScript( event )
		audio.play(buttonSound)
		composer.hideOverlay("questGame")
	end
	questBox:addEventListener("tap", nextScript)
	question:addEventListener("tap", nextScript)

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
		composer.removeScene( "questGame" )
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
