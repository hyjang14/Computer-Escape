-----------------------------------------------------------------------------------------
--
-- robot_fail.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
    local sceneGroup = self.view

    audio.play(wrongSound)

    local background = display.newImageRect("image/게임오버창.png", 1920, 1080)
    background.x, background.y = display.contentCenterX, display.contentCenterY
    sceneGroup:insert(background)

    local gameOverNumber = composer.getVariable("gameOverNumber")
    local function hide(event)
        if gameOverNumber == 1 then
            composer.gotoScene("mainScript1") -- 보안창
        elseif gameOverNumber == 2 then
            audio.play( mainBackgroundMusic, { channel = 7 , loops = -1})
            audio.setVolume( 0.2, { channel=7 } )
            composer.gotoScene("login_logIn") -- 로그인, 로봇
        elseif gameOverNumber == 3 then
            composer.gotoScene("computerScreen") -- 디노
        elseif gameOverNumber == 4 then
            audio.resume(8)
            composer.gotoScene("2nd_floor_lobby") -- 2층 게임
        end

    end
    background:addEventListener("tap", hide)
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
        composer.removeScene("gameOver")
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
