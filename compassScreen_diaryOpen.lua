-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local diaryNumber = composer.getVariable("diaryNumber")
	
	
	local background = display.newImage("image/서브창/폴더창.png")
	background.x, background.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert(background)

	local memo = {}
	for i = 1, 10 do
		memo[i] = display.newImageRect("image/서브창/메모.png", 200, 200)
		memo[i].name = i

		if i < 6 then
			memo[i].x, memo[i].y =  display.contentWidth*0.24 + 242* (i-1), display.contentHeight*0.45
		else
			memo[i].x, memo[i].y =  display.contentWidth*0.24 + 242* (i-6), display.contentHeight*0.7
		end
		sceneGroup:insert(memo[i])
	end

	local player = display.newImageRect("image/캐릭터/pixil(앞)-"..(0)..".png", 100, 100)
	player.x, player.y = display.contentWidth*0.82, display.contentHeight*0.795
	sceneGroup:insert(player)

	local diary = {}
	for i = 1, 10 do
		diary[i] =  display.newImage("image/서브창/일기"..i..".png")
		diary[i].alpha = 0
		sceneGroup:insert(diary[i])
	end
	diary[diaryNumber].alpha = 1

	local diaryX = math.random(600, 1300)
	local diaryY = math.random(450, 550)
	diary[diaryNumber].x, diary[diaryNumber].y = diaryX, diaryY
	print(diaryX, diaryY)

	local diary_exit = display.newRect( diaryX + 382, diaryY - 370, 51, 51)
	diary_exit:setFillColor(1, 0, 0)
	diary_exit.alpha = 0.01
	sceneGroup:insert(diary_exit)


	-- 일기 닫기
	local function hide(event)
		composer.hideOverlay("screen_diaryOpen")
	end
	diary_exit:addEventListener("tap", hide)

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
		composer.removeScene( "screen_diaryOpen" )
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
