-----------------------------------------------------------------------------------------
--
-- intro.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
    local sound_artist = audio.loadSound("sound/예술가의방.mp3")

    audio.play(sound_artist, { channel=5, loops = -1 })
    audio.setVolume( 0.3, { channel=5 } )

-- ↓ 배경 ----------------------------------------------------------------------------------------------------
local background = display.newImage("image/배경/배경_저택_예술가의방.png", display.contentCenterX, display.contentCenterY)
background.x, background.y = display.contentWidth/2, display.contentHeight/2
sceneGroup:insert(background)

local memo = {}
local memo = display.newImageRect("image/UI/메모지.png", 60, 80)
memo.x, memo.y = 450, 180
sceneGroup:insert(memo)

local button = display.newImageRect("image/UI/버튼.png", 50, 50)
button.x, button.y = 1535, 180
sceneGroup:insert(button)

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

sceneGroup:insert(picGroup)
sceneGroup:insert(framGroup)

local not_interaction = display.newImageRect("image/UI/빈원형.png", 130, 130)
not_interaction.x, not_interaction.y = 1740, 680
not_interaction.alpha = 0

local cursor = display.newImage("image/UI/커서.png")
cursor.x, cursor.y = 1560, 810 
cursor.alpha = 0

local finger = display.newImage("image/UI/포인터.png")
finger.x, finger.y = 1560, 810
finger.alpha = 0

local interaction = display.newImageRect("image/UI/변형.png", 130, 130)
interaction.x, interaction.y = 1740, 680
interaction.alpha = 0

local inventory = display.newImage("image/UI/인벤토리.png")
inventory.x, inventory.y = 240, 80

local question = display.newImage("image/UI/물음표.png")
question.x, question.y = 100, 80

sceneGroup:insert(cursor)
sceneGroup:insert(finger)
sceneGroup:insert(not_interaction)
sceneGroup:insert(interaction)
sceneGroup:insert(inventory)
sceneGroup:insert(question)

-- ↑ 배경 ----------------------------------------------------------------------------------------------------

-- ↓ 파이 일러 ----------------------------------------------------------------------------------------------------
    
    local image1 = display.newImage("image/캐릭터/파이 당황.png")
    image1.x, image1.y = display.contentWidth*0.2, display.contentHeight*0.5

    local image2 = display.newImage("image/캐릭터/파이 기본.png")
    image2.x, image2.y = display.contentWidth*0.2, display.contentHeight*0.5
    image2.alpha = 0

    sceneGroup:insert(image1)
    sceneGroup:insert(image2)

-- ↓ 대화 ----------------------------------------------------------------------------------------------------
local chatBox = display.newImage("image/UI/대화창 ui.png")
	chatBox.x, chatBox.y = display.contentWidth/2, display.contentHeight * 0.78

sceneGroup:insert(chatBox)


-- ↓ json1에서 정보 읽고 적용 ----------------------------------------------------------------------------------
    local Data = jsonParse( "artist_json/intro.json" )

    local dialog = display.newGroup()

    local speaker = display.newText(dialog, "파이", display.contentWidth*0.25, display.contentHeight*0.76, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker)
	speaker:setFillColor(0)
	speaker.size = 50

	local content = display.newText(dialog, "웬 그림들이 이렇게 널브러져있지...?",  display.contentWidth*0.5, display.contentHeight*0.902, display.contentWidth*0.7, display.contentHeight*0.2, font_Content)
	content:setFillColor(0)
	content.size = 40

    if Data then
        print(Data[1].speaker)
        print(Data[1].content)
    end
    local index = 0

    local function nextScript( event )
        index = index + 1
        if(index > #Data) then 
            display.remove(dialog)
            composer.gotoScene("artist_room_start") 
            return
        end

        speaker.text = Data[index].speaker
        content.text = Data[index].content
    end

    chatBox:addEventListener("tap", nextScript)
    dialog:toFront()

-- ↑ json1에서 정보 읽고 적용 ----------------------------------------------------------------------------------

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
        composer.removeScene("artist_intro")
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view

    -- Remove all display objects created in this scene
    if picGroup then
        picGroup:removeSelf()
        picGroup = nil
    end

    if framGroup then
        framGroup:removeSelf()
        framGroup = nil
    end

    if dialog then
        dialog:removeSelf()
        dialog = nil
    end

    if memo then
        memo:removeSelf()
        memo = nil
    end

    if background then
        background:removeSelf()
        background = nil
    end

    if talkGroup then
        talkGroup:removeSelf()
        talkGroup = nil
    end
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