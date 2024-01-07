-----------------------------------------------------------------------------------------
--
-- robot_loading.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
    local sceneGroup = self.view

    -- local background = display.newRect("image/메인홈.png",display.contentCenterX, display.contentCenterY)
    -- sceneGroup:insert(background)
    -- local backChannel  = audio.play( mainBackgroundMusic, { channel = 1, loops = -1})
	-- audio.setVolume( 0.2, { channel=1 } )
    audio.play(garbageSound, {channel = 2})


    local go = 1
    local function next (event)
        go = go - 1

        if go == -1 then
            composer.gotoScene("mainScript5")
        end
    end
    timer.performWithDelay(1000, next, 2)


    -- -- ↓ 시간 -------------------------------------------------------------------------------------------------

    -- local hour = os.date( "%I" )
    -- local minute = os.date( "%M" )

    -- local hourText = display.newText(hour, display.contentWidth*0.919, display.contentHeight*0.972, font_Speaker)
    -- hourText.size = 46
    -- hourText:setFillColor(0)
    -- local minuteText = display.newText(minute, display.contentWidth*0.975, display.contentHeight*0.972, font_Speaker)
    -- minuteText.size = 46
    -- minuteText:setFillColor(0)

    -- local text = display.newText(":", display.contentWidth*0.946, display.contentHeight*0.96, font_Speaker)
    -- text.size = 100
    -- text:setFillColor(0)

    -- local function counter( event )
    --     hour = os.date( "%I" )
    --     hourText.text = hour
    --     minute = os.date( "%M" )
    --     minuteText.text = minute
    -- end

    -- timer.performWithDelay(1000, counter, -1)

    -- -- ↑ 시간 -------------------------------------------------------------------------------------------------

    

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
        audio.pause(2)
        composer.removeScene("robot_loading")
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
