-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80
	sceneGroup:insert(inventory)

	local back = display.newImageRect("image/UI/인벤토리창.png", 777.5, 415)
	back.x, back.y = display.contentWidth * 0.275 , display.contentHeight * 0.332
	sceneGroup:insert(back)

	
	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	-- json에서 정보 읽기
	local Data = jsonParse("json/inven_explain.json")
	local number = composer.getVariable("number")

	local tipInfo = display.newGroup()

	local image = display.newImageRect(Data[number].image, 160, 160)
	image.x, image.y = display.contentWidth * 0.17 , display.contentHeight * 0.26

	local options = {
    text = Data[number].content,
    x = display.contentWidth * 0.28,
    y = display.contentHeight * 0.42,
    width = 650,
    font = font_Content,
    fontSize = 40,
    align = "left" }

	local content = display.newText(options)
	content:setFillColor(0)

	sceneGroup:insert(image)
	sceneGroup:insert(content)

	-- ↓ 함수 정리 ------------------------------------------------------------------------------------------------------------


	local function hide( event )
		composer.hideOverlay("inven_explain")
	end
	inventory:addEventListener("tap", hide)
	back:addEventListener("tap", hide)

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
		composer.removeScene( "inven_explain" )
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
