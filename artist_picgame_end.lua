-----------------------------------------------------------------------------------------
--
-- picgame_end.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local gameSuccess = gameSuccess

    -- Background
    local background = display.newImage("image/배경/배경_저택_예술가의방.png", display.contentCenterX, display.contentCenterY)
    sceneGroup:insert(background)

    local memo = display.newImageRect("image/UI/메모지.png", 60, 80)
    memo.x, memo.y = 450, 180
    memo.alpha = 0.7
    memo.name = "memo"  

    local button = display.newImageRect("image/UI/버튼.png", 50, 50)
    button.x, button.y = 1535, 180
    sceneGroup:insert(button)

    -- Images
    local framGroup = display.newGroup()
    local fram = {}


    fram[1] = display.newImageRect("image/artist/1.png", 165, 165)
    fram[2] = display.newImageRect("image/artist/2.png", fram[1].width, fram[1].height)
    fram[3] = display.newImageRect("image/artist/3.png", fram[1].width, fram[1].height)
    fram[4] = display.newImageRect("image/artist/4.png", fram[1].width, fram[1].height)


    for i = 1, 4 do
        fram[i].x, fram[i].y = 645 + (i - 1) * 250, 180
        framGroup:insert(fram[i])
    end


    sceneGroup:insert(memo)
    sceneGroup:insert(framGroup)


    -- 조작키 --------------------------------------

	local not_interaction = display.newImageRect("image/UI/빈원형.png", 130, 130)
	not_interaction.x, not_interaction.y = 1740, 680
	not_interaction.alpha = 0

	local interaction = display.newImageRect("image/UI/변형.png", 130, 130)
	interaction.x, interaction.y = 1740, 680
	interaction.alpha = 0

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80


	-- 레이어 정리
	sceneGroup:insert(not_interaction)
	sceneGroup:insert(interaction)
	sceneGroup:insert(inventory)
	sceneGroup:insert(question)


    -- ↑ ui정리 -------------------------------------------------------------------------------------------------

    -- ↓ 플레이어 ---------------------------------------------------------------------------------------------------
	local playerGroup = display.newGroup()
	local player = {} 

	for i = 1, 4 do
		player[i] = {}
	end

	-- 앞
	for i = 1, 4 do
		player[1][i] = display.newImageRect("image/캐릭터/pixil(앞)-"..(i - 1)..".png", 120, 120)
		player[1][i].x, player[1][i].y = 1540, 240
		player[1][i].alpha = 0

		playerGroup:insert(player[1][i])
	end
	-- 뒤
	for i = 1, 4 do
		player[2][i] = display.newImageRect("image/캐릭터/pixil(뒤)-"..(i - 1)..".png", 120, 120)
		player[2][i].x, player[2][i].y = 1540, 240
		player[2][i].alpha = 0

		playerGroup:insert(player[2][i])
	end
	-- 왼쪽
	for i = 1, 4 do
		player[3][i] = display.newImageRect("image/캐릭터/pixil(왼)-"..(i - 1)..".png", 120, 120)
		player[3][i].x, player[3][i].y = 1540, 240
		player[3][i].alpha = 0

		playerGroup:insert(player[3][i])
	end
	-- 오른쪽
	for i = 1, 4 do
		player[4][i] = display.newImageRect("image/캐릭터/pixil(오른)-"..(i - 1)..".png", 120, 120)
		player[4][i].x, player[4][i].y = 1540, 240 
		player[4][i].alpha = 0

		playerGroup:insert(player[4][i])
	end

	sceneGroup:insert(playerGroup)

	player[1][1].alpha = 1 -- 처음 모습

	local locationX = 1200
	local locationY = 700

    -- ↓ 일러스트 ---------------------------------------------------------------------------------------------------

    local image2 = display.newImage("image/캐릭터/파이 기본.png")
	image2.x, image2.y = display.contentWidth*0.2, display.contentHeight*0.5
    image2.alpha = 0

    local image3 = display.newImage("image/캐릭터/파이 안도.png")
	image3.x, image3.y = display.contentWidth*0.2, display.contentHeight*0.5
    image3.alpha = 0

    sceneGroup:insert(image2)
    sceneGroup:insert(image3)

-- ↓ 대화 ----------------------------------------------------------------------------------------------------

local talkGroup = display.newGroup()
local talk = {}

talk[1] = display.newImage("image/UI/대화창 ui.png")
talk[1].x, talk[1].y = display.contentWidth/2, display.contentHeight * 0.78

talkGroup:insert(talk[1])

sceneGroup:insert(talkGroup)


-- ↓ json1에서 정보 읽고 적용 ----------------------------------------------------------------------------------
local dialog = display.newGroup()

local content = display.newText(dialog, "[ 뭐든 쏴 무기 ]를 얻었다.", display.contentWidth*0.63, display.contentHeight*0.86, display.contentWidth*0.5, display.contentHeight*0.2, font_Speaker)
content:setFillColor(0)
content.size = 45

local index = 0

local function nextScript( event )
    display.remove(dialog)
    display.remove(playerGroup)
    audio.pause(5)
    game3 = 1
    local function goToNextScene()
        composer.gotoScene("artist_black2")
    end
    
    timer.performWithDelay(0, goToNextScene)
end

talk[1]:addEventListener("tap", nextScript)
dialog:toFront()


end


	----------------------------------------------------------------------------------------------------------


function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc.
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.
        composer.removeScene("artist_picgame_end")
    elseif phase == "did" then
        -- Called when the scene is now off screen
    end
end

function scene:destroy(event)
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc.
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
