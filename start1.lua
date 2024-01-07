-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()



--검은배경
local back = display.newImageRect("image/배경.png", 1920,1080)
back.x, back.y = display.contentCenterX, display.contentCenterY
--버튼_누르기전
local button1 = display.newImageRect("image/전원볼드.png", 300,300)
button1.x, button1.y = display.contentCenterX, display.contentCenterY-45
button1.alpha = 0
--버튼_누른후
local button2 = display.newImageRect("image/전원버튼.png", 250,250)
button2.x, button2.y = display.contentCenterX, display.contentCenterY-45
button2.alpha = 0


local function gotoStartScene()
	audio.play(insertItem)
	button1.alpha = 0
	button2.alpha = 1

	local function buttonReturn(event) --다시 되돌아와 버튼!
		button1.alpha = 1
		button2.alpha = 0
	end
	timer.performWithDelay(300,buttonReturn)

	local options = {
		effect = "slideUp", 
		time = 1000 
	}

	local function sendNext(event) --화면전환 타이머함수
			
		-- print("화면전환함수")
		-- composer.hideOverlay("view1")
		composer.gotoScene("start2", options)

	end
	timer.performWithDelay(1000, sendNext)
end

function scene:create( event )
	local sceneGroup = self.view

	--배경음악
	audio.play(start_page_bgm, { channel=6, loops = -1 })
	audio.setVolume( 0.1, { channel=6 } )

	sceneGroup:insert(back)
	sceneGroup:insert(button1)
	sceneGroup:insert(button2)
	
	timer.performWithDelay(3000, function()
		transition.to(button1, {time = 800, alpha = 1})
	end
	)

	button1:addEventListener("tap", gotoStartScene)
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
		composer.removeScene("start1")
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