-----------------------------------------------------------------------------------------
--
-- 거짓말쟁이방퀘스트.lua
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

	-- json에서 정보 읽기
	local Data = jsonParse("json/quest.json")

	local tipInfo = display.newGroup()

	local questBox = display.newImage("image/UI/퀘스트.png")
	questBox.x, questBox.y = display.contentWidth*0.247, display.contentHeight*0.33

	local number = composer.getVariable("number")

	if (number ==  nil) then
		number = 1
	else
		number = number + 1
	end

	local content = display.newText(tipInfo, Data[number].content, display.contentWidth*0.247, display.contentHeight*0.36, font_Content, 50)
	content:setFillColor(0)

	sceneGroup:insert(questBox)
	sceneGroup:insert(content)


	local function nextScript( event )
		composer.setVariable("number", number)
		-- composer.gotoScene( "computerScreen" ) 
		composer.hideOverlay("quest")
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
		composer.removeScene( "2nd_floor_quest" )
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
