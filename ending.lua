-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
audio.pause(2)

function scene:create( event )
	local sceneGroup = self.view
    local backgroundY = composer.getVariable("backgroundY")

	local back = display.newImageRect("image/배경/배경_저택_1층.png", 2000, 2000)
	back.x, back.y = display.contentWidth/2, backgroundY
	sceneGroup:insert(back)

	--loading.png: 정사각형모양 배경없는 로딩아이콘
    local background = display.newImageRect("image/로딩창/게임종료중.png", 1200, 600)
    background.x, background.y = display.contentCenterX, display.contentCenterY - 50
    sceneGroup:insert(background)

	loading = display.newImageRect("image/로딩창/로딩아이콘.png", 160, 160)
	loading.x, loading.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert( loading )

	rotateLoading()

	-- nextScene = composer.gotoScene("배경화면.compass_prevScript")
	local function rotateLoading() -- 로딩창 회전시키는 함수
		transition.to(loading, {
			rotation = loading.rotation + 720, --2바퀴 회전
			x = display.contentCenterX,
			y = display.contentCenterY,
			time = 3000, --3초간
			-- onComplete = nextScene --회전끝나면, nextScene함수로 이동
			}
		)
	end

	go = 2
	local function count(event)
		go = go - 1
		if go == -1 then
			audio.pause(8)
			composer.gotoScene("compass_prevScript", {effect = "fade"})
		end
	end
	timer.performWithDelay(1000, count, 3)


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
		composer.removeScene( "ending" )
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