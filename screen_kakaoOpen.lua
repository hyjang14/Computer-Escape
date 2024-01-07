-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local kakaoNum = composer.getVariable("kakaoNum")
	
	local diary = display.newImage("image/서브창/카톡창.png")
	diary.x, diary.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert(diary)

	local kakao = {}
	kakao[1] = display.newImage("image/서브창/엄마카톡_1.png")
	kakao[2] = display.newImage("image/서브창/제이카톡_1.png")
	kakao[3] = display.newImage("image/서브창/레오카톡_1.png")
	kakao[4] = display.newImage("image/서브창/세나카톡_1.png")
	
	for i= 1, 4 do
		kakao[i].x, kakao[i].y = display.contentWidth*0.75, display.contentHeight*0.52
		kakao[i].alpha = 0 
		sceneGroup:insert(kakao[i])
	end
	kakao[kakaoNum].alpha = 1

	local back = display.newImageRect( "image/서브창/카톡화살표.png", 50, 50)
	back.x, back.y = display.contentWidth*0.613, display.contentHeight*0.106
	sceneGroup:insert(back)


	-- 카톡 창 닫기
	local function kakao_hide(event)
		composer.hideOverlay("screen_kakaoOpen")
	end
	back:addEventListener("tap", kakao_hide)
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
		composer.removeScene( "screen_kakaoOpen" )
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
