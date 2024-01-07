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
	local finger = composer.getVariable("finger")
	finger.alpha = 0
	
	local black = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	black:setFillColor(0) -- 검정 화면
	sceneGroup:insert(black)

	local background = display.newImageRect("image/배경/배경_저택_1층.png", 2000, 2000)
	background.x, background.y = display.contentWidth/2, backgroundY
	sceneGroup:insert(background)

	-- 체리
	local cherry_Y = composer.getVariable("cherry_Y")
	local cherry = display.newImageRect("image/캐릭터/체리_도트_기본모습.png", 120, 120)
	cherry.x, cherry.y = display.contentWidth/2, cherry_Y
	sceneGroup:insert(cherry)

	-- 파이
	local pi_X = composer.getVariable("pi_X")
	local pi = display.newImageRect("image/캐릭터/pixil(뒤)-0.png", 120, 120)
	pi.x, pi.y = pi_X, 570
	sceneGroup:insert(pi)

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	local chatBox = display.newImage("image/UI/대화창 ui.png")
	chatBox.x, chatBox.y = display.contentWidth/2, display.contentHeight * 0.76

	sceneGroup:insert(inventory)
	sceneGroup:insert(question)

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	-- json에서 정보 읽기
	local Data = jsonParse("1st_floor_json/cherry_interaction.json")

	local showTipNo = math.random(1, 20)

	-- if (Data) then
	-- 	print(Data[showTipNo].tipNo)
	-- 	print(Data[showTipNo].tipContent)	
	-- end
	
	local tipInfo = display.newGroup()

	local image_cherry = display.newImage(Data[showTipNo].image)
	image_cherry.x, image_cherry.y = display.contentWidth*0.2, display.contentHeight*0.5
	image_cherry:scale(-1, 1)

	local tipContent = display.newText(tipInfo, Data[showTipNo].tipContent, display.contentCenterX, display.contentCenterY + 290, font_Content , 45)
	tipContent:setFillColor(0)
	tipContent.align = "left"

	-- sceneGroup:insert(tipNo)
	sceneGroup:insert(image_cherry)
	sceneGroup:insert(chatBox)
	sceneGroup:insert(tipContent)

	local function nextScript( event )
		finger.alpha = 1
		composer.hideOverlay("cherryInteraction")
		--composer.gotoScene( "game_lobby" ) 
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
		composer.removeScene( "cherryInteraction" )
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
