-- overlay_memo.lua

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)

	local sound_artist_memo2 = audio.loadSound("sound/종이 넘기는 소리 2.mp3")
    local sceneGroup = self.view

    -- Images
    local memo = display.newImageRect(sceneGroup, "image/UI/메모지.png", 501, 550)
    memo.x, memo.y = display.contentWidth/2, 400

	local talkGroup = display.newGroup()
    local talk = {}

    talk[1] = display.newImage("image/UI/대화창 ui.png")
    talk[1].x, talk[1].y = display.contentWidth/2, display.contentHeight * 0.78
    
    talk[1].label = display.newText("- 바닥에 떨어진 그림을 들면 액자에 끌어다 넣을 수 있습니다. -", display.contentWidth/2, display.contentHeight*0.78, font_Speaker, 40)
    talk[1].label:setFillColor(0)

    talkGroup:insert(talk[1])
    talkGroup:insert(talk[1].label)

	sceneGroup:insert(talkGroup)
    sceneGroup:insert(memo)

    local function onTouch(event)
        composer.hideOverlay("artist_overlay_memo")
		audio.play(sound_artist_memo2)
    end
	memo:addEventListener("tap", onTouch)
	talkGroup:addEventListener("tap", onTouch)

	memo:toFront()
	talkGroup:toFront()
  
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
		composer.removeScene( "artist_overlay_memo" )
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
