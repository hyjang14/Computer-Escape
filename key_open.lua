-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local black = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	black:setFillColor(0) -- 검정 화면
	sceneGroup:insert(black)

	local backImage = {}
	backImage[1] = display.newRect(280, 630, 520, 900)
	backImage[1]:setFillColor(0, 0, 0)
	backImage[2] = display.newRect(1640, 610, 520, 942)
	backImage[2]:setFillColor(0, 0, 0)

	sceneGroup:insert(backImage[1])
	sceneGroup:insert(backImage[2])

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local backgroundY = composer.getVariable("backgroundY")

	local background = display.newImageRect("image/배경/배경_저택_1층.png", 2000, 2000)
	-- local background = display.newImage("image/배경/배경화면.png")
	background.x, background.y = display.contentWidth/2, backgroundY
	sceneGroup:insert(background)

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	sceneGroup:insert(inventory)
	sceneGroup:insert(question)

	local image_in = display.newImage("image/자물쇠/자물쇠게임_안.png")
	image_in.x, image_in.y = display.contentCenterX, display.contentCenterY

	sceneGroup:insert(image_in)

	local ribon = display.newImageRect("image/자물쇠/리본.png", 300, 300)
	ribon.x, ribon.y = display.contentCenterX, display.contentCenterY * 0.8
	ribon.alpha = 0
	sceneGroup:insert(ribon)

	local talk = display.newImage("image/UI/대화창 ui.png")
	talk.x, talk.y = display.contentWidth/2, display.contentHeight * 0.78
	talk.alpha = 0
	sceneGroup:insert(talk)

	local content = display.newText( "[ 귀여운 리본 ]을 얻었다.", display.contentWidth*0.63, display.contentHeight*0.86, display.contentWidth*0.5, display.contentHeight*0.2, font_Speaker)
	content:setFillColor(0)
	content.size = 45
	content.alpha = 0
	sceneGroup:insert(content)

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	-- ↓ 함수 정리 ------------------------------------------------------------------------------------------------------------

	local function get( event )
		ribon.alpha = 0
		itemNum[6] = true 
		audio.play(itemGetSound)
		itemNum[3] = false

		talk.alpha = 1
		content.alpha = 1
	end
	ribon:addEventListener("tap", get)

	transition.to ( ribon, {
		alpha = 1,
		time = 1000,
		y = ribon.y - 100,
		onComplete = function()
		end
	})

	-- ↓ 인벤토리 함수 -------------------------------------------------------------------------------------------------

	local function inven( event )
		composer.showOverlay("inventoryScene", {isModal = true})
	end
	inventory:addEventListener("tap", inven)

	-- 나가기
	local function back(event)
		composer.gotoScene("game_ending_lobby")
	end
	talk:addEventListener("tap", back)


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
		composer.setVariable("keyOpen", true)
		composer.removeScene( "key_open" )
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
