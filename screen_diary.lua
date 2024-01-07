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
	local background = display.newImageRect("image/컴퓨터화면.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80
	sceneGroup:insert(inventory)

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80
	sceneGroup:insert(question)
	
	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	-- ↓ 시간 -------------------------------------------------------------------------------------------------

	local hour = os.date( "%I" )
	local minute = os.date( "%M" )

	local hourText = display.newText(hour, display.contentWidth*0.919, display.contentHeight*0.972, "font/PF스타더스트 Bold.ttf")
	hourText.size = 46
	hourText:setFillColor(0)
	local minuteText = display.newText(minute, display.contentWidth*0.975, display.contentHeight*0.972, "font/PF스타더스트 Bold.ttf")
	minuteText.size = 46
	minuteText:setFillColor(0)

	local text = display.newText(":", display.contentWidth*0.946, display.contentHeight*0.96, font_Speaker)
    text.size = 100
    text:setFillColor(0)
	sceneGroup:insert(text)

	local function counter( event )
		hour = os.date( "%I" )
		hourText.text = hour
		minute = os.date( "%M" )
		minuteText.text = minute
	end

	timer.performWithDelay(1000, counter, -1)

	sceneGroup:insert(hourText)
	sceneGroup:insert(minuteText)

	-- ↑ 시간 -------------------------------------------------------------------------------------------------
	
	local background = display.newImage("image/서브창/폴더창.png")
	background.x, background.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert(background)

	local exit = display.newRect( display.contentWidth*0.853, display.contentHeight*0.157, 51, 51)
	exit:setFillColor(1, 0, 0)
	exit.alpha = 0.01
	sceneGroup:insert(exit)

	local name = display.newImage("image/서브창/일기아이콘.png")
	name.x, name.y = display.contentWidth*0.185, display.contentHeight*0.17
	sceneGroup:insert(name)

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



	-- 일기 열기
	local diaryNumber
	local function diaryOpen(event)
		composer.setVariable("diaryNumber", event.target.name)
		composer.showOverlay("screen_diaryOpen", {isModal = true})
	end
	for i = 1, 10 do
		memo[i]:addEventListener("tap", diaryOpen)
	end


	-- 나가기
	local function go (event)
		composer.gotoScene("computerScreen")
	end
	exit:addEventListener("tap", go)

	-- ↓ 인벤토리 함수 -------------------------------------------------------------------------------------------------

    local function inven( event )
        composer.showOverlay("inventoryScene", {isModal = true})
    end
    inventory:addEventListener("tap", inven)
	
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
		composer.removeScene( "screen_diary" )
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
