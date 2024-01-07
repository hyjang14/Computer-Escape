-----------------------------------------------------------------------------------------
--
-- memo.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

-- ↓ 배경 ----------------------------------------------------------------------------------------------------
    local background = display.newImage("image/배경/배경_저택_예술가의방.png", display.contentCenterX, display.contentCenterY)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)

    local memoGroup = display.newGroup()
    local memo = {}
    
    memo[1] = display.newImageRect("image/UI/메모지.png", 60, 80)
    memo[1].x, memo[1].y = 450, 180
    memoGroup:insert(memo[1])

	memo[2] = display.newImageRect("image/UI/메모지.png", 501, 550)
    memo[2].x, memo[2].y = display.contentWidth/2, 400
    memo[2].name = "memo"

    local button = display.newImageRect("image/UI/버튼.png", 50, 50)
    button.x, button.y = 1535, 180
    sceneGroup:insert(button)

    local inventory = display.newImage("image/UI/인벤토리.png")
    inventory.x, inventory.y = 240, 80
    sceneGroup:insert(inventory)

    local question = display.newImage("image/UI/물음표.png")
    question.x, question.y = 100, 80
    sceneGroup:insert(question)

    local talkGroup = display.newGroup()
    local talk = {}

    talk[1] = display.newImage("image/UI/대화창 ui.png")
    talk[1].x, talk[1].y = display.contentWidth/2, display.contentHeight * 0.78
    
    talk[1].label = display.newText("- 바닥에 떨어진 그림을 들면 액자에 끌어다 넣을 수 있습니다. -", display.contentWidth/2, display.contentHeight*0.78, font_Speaker, 40)
    talk[1].label:setFillColor(0)

    -- Images
    local picGroup = display.newGroup()
    local pic = {}
    local framGroup = display.newGroup()
    local fram = {}

    pic[1] = display.newImageRect("image/artist/예술가의방 그림 H.png", 200, 150)
    pic[1].x, pic[1].y = 1450, 700
    pic[2] = display.newImageRect("image/artist/예술가의방 그림 U.png", pic[1].width, pic[1].height)
    pic[2].x, pic[2].y = 450, 650
    pic[3] = display.newImageRect("image/artist/예술가의방 그림 N.png", pic[1].width, pic[1].height)
    pic[3].x, pic[3].y = 850, 500
    pic[4] = display.newImageRect("image/artist/예술가의방 그림 T.png", pic[1].width, pic[1].height)
    pic[4].x, pic[4].y = 1100, 880

    for i = 1, 4 do
        picGroup:insert(pic[i])
        fram[i] = display.newImageRect("image/artist/오브제 액자.png", 200, 200)
        fram[i].x, fram[i].y = 645 + (i - 1) * 250, 180
        framGroup:insert(fram[i])
    end

    local player = display.newImageRect("image/캐릭터/pixil(뒤)-0.png", 120, 120)
    player.x, player.y = 450, 240

    memoGroup:insert(memo[2])
    sceneGroup:insert(picGroup)
    sceneGroup:insert(framGroup)
    sceneGroup:insert(memoGroup)
    sceneGroup:insert(player)

    talkGroup:insert(talk[1])
    talkGroup:insert(talk[1].label)

	sceneGroup:insert(talkGroup)

-- ↑ 배경 ----------------------------------------------------------------------------------------------------

-- ↓ 메모 ----------------------------------------------------------------------------------------------------
local function moveScene_1( event )
    composer.gotoScene("artist_picgame_start")
end

memo[2]:addEventListener("tap", moveScene_1)
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
        composer.removeScene("artist_memo")
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view

    -- Remove all display objects created in this scene
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