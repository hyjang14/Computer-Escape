-----------------------------------------------------------------------------------------
--
-- intro.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


--메인함수 -------------------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view
	--배경화면
	local background = display.newImageRect("image/background.png", 1300,1000)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)
	--장미
	local rose = display.newImageRect("image/오브제/rose0.png", 300,300)
	rose.x, rose.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(rose)
	--박스
	local box = display.newImageRect("image/오브제/box.png", 280,280)
	box.x, box.y = display.contentWidth*0.3, display.contentHeight*0.2
	sceneGroup:insert(box)
	--주전자
	local pot = display.newImageRect("image/오브제/pot.png", 150,150)
	pot.x, pot.y = display.contentWidth*0.7, display.contentHeight*0.25
	sceneGroup:insert(pot)
	--죽은장미들 오브제
	local deads01 = display.newImageRect("image/오브제/deads01.png", 400,260)
	deads01.x, deads01.y = display.contentWidth*0.73, display.contentHeight*0.75
	sceneGroup:insert(deads01)
	local deads02 = display.newImageRect("image/오브제/deads02.png", 500,280)
	deads02.x, deads02.y = display.contentWidth*0.28, display.contentHeight*0.75
	sceneGroup:insert(deads02)
	--pi
	local pi = display.newImageRect("image/캐릭터/pixil(뒤)-0.png", 120,120)
	pi.x, pi.y = display.contentWidth/2, display.contentHeight*0.66
	sceneGroup:insert(pi)
	--반투명
	local screen = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	screen:setFillColor(0)
	screen.alpha = 0.6
	sceneGroup:insert(screen)
    --대화창
    local chatBox = display.newImage("image/UI/대화창 ui.png")
	chatBox.x, chatBox.y = display.contentWidth/2, display.contentHeight * 0.78
	sceneGroup:insert(chatBox)
    --퀘스트창
    local questBox = display.newImage("image/UI/퀘스트.png")
    questBox.x, questBox.y = display.contentWidth*0.19, display.contentHeight*0.28
    questBox:scale(0.73, 0.73)
    questBox.alpha = 0
	sceneGroup:insert(questBox)
    

    --json 적용 ----------------------------------------------------------------------------------
    local dialog = display.newGroup()
	
	local image_rose = display.newImage("image/오브제/rose0.png")
	image_rose.x, image_rose.y = display.contentWidth*0.7, display.contentHeight*0.5
	image_rose.name = "장미"
	image_rose.alpha = 0

	local image_pi = display.newImage("image/캐릭터/파이 웃음.png")
	image_pi.x, image_pi.y = display.contentWidth*0.2, display.contentHeight*0.5
	image_pi.name = "파이"
	image_pi.alpha = 1

	local speaker = display.newText(dialog, "파이", display.contentWidth*0.25, display.contentHeight*0.76, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker)
	speaker:setFillColor(0)
	speaker.size = 50
	--speaker.font = "font/PF스타더스트 Bold.ttf"
	
	local content = display.newText(dialog, "오오!!!", display.contentWidth*0.5, display.contentHeight*0.902, display.contentWidth*0.7, display.contentHeight*0.2, font_Content)
	content:setFillColor(0)
	content.size = 40
	--content.font = "font/PF스타더스트.ttf"

	sceneGroup:insert(dialog)
	sceneGroup:insert(image_rose)
	sceneGroup:insert(image_pi)
	sceneGroup:insert(questBox)
	sceneGroup:insert(chatBox)
	sceneGroup:insert(speaker)
	sceneGroup:insert(content)

    local function gotoNextRoom()
		
        audio.pause(4)
        audio.resume(8)
        composer.hideOverlay("rose_ending_dialog")
        if (game1 ==1 and game2 == 1 and game3 == 1) then
             composer.setVariable("num", 2)
             composer.gotoScene("2nd_floor_ending1", {effect = "fade"})
        else 
             composer.gotoScene("2nd_floor_lobby", {effect = "fade"})
        end
		
    end


	-- json에서 정보 읽기
	local Data = jsonParse("rose_json/rose_pi3.json")

	-- json에서 읽은 정보 적용하기
	local index = 0

	local function nextScript( event )
		index = index + 1

		if(index > #Data) then --뷰 끝나면 다음씬으로!
			gotoNextRoom()
			return
		end

		
		
		speaker.text = Data[index].speaker
		content.text = Data[index].content


		if (index == 1) then
			-----------폰트,위치 수정
			content.x, content.y = display.contentWidth*0.75, display.contentHeight*0.84
			content.font = font_Speaker
		else
			content.x, content.y = display.contentWidth*0.5, display.contentHeight*0.902
			content.font = font_Content
		end
			

		if(Data[index].speaker == image_rose.name) then
			image_rose.alpha = 1
			image_pi.alpha = 0

		else
			image_rose.alpha = 0
			image_pi.alpha = 1
		end

        if (Data[index].speaker == " ") then
            image_rose.alpha = 0
            image_pi.alpha = 0
        end

		image_rose.fill = {
			type = "image",
			filename = Data[index].image
		}
		image_pi.fill = {
			type = "image",
			filename = Data[index].image
		}

	end
    
    
	chatBox:addEventListener("tap", nextScript)
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		composer.removeScene("rose_intro_dialog")
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	-- Called prior to the removal of scene's "view" (sceneGroup)
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene