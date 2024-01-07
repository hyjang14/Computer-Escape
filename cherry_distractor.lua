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
	local backgroundY = composer.getVariable("backgroundY")
	
	local finger = composer.getVariable("finger")
	finger.alpha = 0

	local black = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	black:setFillColor(0) -- 검정 화면
	sceneGroup:insert(black)

	local background = display.newImageRect("image/배경/배경_저택_1층.png", 2000, 2000)
	background.x, background.y = display.contentWidth/2, backgroundY
	sceneGroup:insert(background)

	-- 체리
	local cherry_Y = composer.getVariable("cherry_Y")
	local cherry = display.newImageRect("image/캐릭터/체리_도트_기본모습.png", 120, 120)
	cherry.x, cherry.y = display.contentWidth/2, cherry_Y
	sceneGroup:insert(cherry)

	-- 파이
	local pi_X = composer.getVariable("pi_X")
	local pi = display.newImageRect("image/캐릭터/pixil(뒤)-0.png", 120, 120)
	pi.x, pi.y = pi_X, 570
	sceneGroup:insert(pi)

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	local chatBox = display.newImage("image/UI/대화창 ui.png")
	chatBox.x, chatBox.y = display.contentWidth/2, display.contentHeight * 0.78

	local chatBox_N = display.newImage("image/UI/대화창 ui.png")
	chatBox_N.x, chatBox_N.y = display.contentWidth/2, display.contentHeight * 0.78
	chatBox_N.alpha = 0

	sceneGroup:insert(inventory)
	sceneGroup:insert(question)


	local choice = {}
	choice[1] = display.newImageRect("image/UI/대답박스 분리.png", 700, 110)
	choice[1].x, choice[1].y = display.contentWidth * 0.76, display.contentHeight * 0.46
	choice[1].alpha = 0

	choice[2] = display.newImageRect("image/UI/대답박스 분리.png", 700, 110)
	choice[2].x, choice[2].y = display.contentWidth * 0.76, display.contentHeight * 0.57
	choice[2].alpha = 0

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	local choiceSound = audio.loadSound("sound/체리 선택지 2.mp3")

	-- json에서 정보 읽기
	local Data = jsonParse("1st_floor_json/cherry_distractor.json")

	local dialog = display.newGroup()

	local image_cherry = display.newImage("image/캐릭터/체리 기본.png")
	image_cherry.x, image_cherry.y = display.contentWidth*0.8, display.contentHeight*0.5
	image_cherry.name = "체리"

	local image_pi = display.newImage("image/캐릭터/파이 기본.png")
	image_pi.x, image_pi.y = display.contentWidth*0.2, display.contentHeight*0.5
	image_pi.name = "파이"
	image_pi.alpha = 0

	local speaker
	speaker = display.newText(dialog, Data[1].speaker , display.contentWidth*0.25, display.contentHeight*0.76, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker)
	speaker.size = 50
	speaker:setFillColor(0)
	
	local content = display.newText(dialog, Data[1].content, display.contentWidth*0.5, display.contentHeight*0.902, display.contentWidth*0.7, display.contentHeight*0.2, font_Content)
	content.size = 40
	content:setFillColor(0)

	local answer1 = display.newText("그러게. 나도 너랑 대화하는 게 즐거워.", display.contentWidth * 0.77, display.contentHeight * 0.46, font_Content, 36)
	answer1:setFillColor(0)
	answer1.alpha = 0

    local answer2 = display.newText("아쉽지만 어쩌겠어, 난 이곳 사람이 아닌데.", display.contentWidth * 0.765, display.contentHeight * 0.57, font_Content, 36)
	answer2:setFillColor(0)
	answer2.alpha = 0

	sceneGroup:insert(dialog)
	sceneGroup:insert(image_cherry)
	sceneGroup:insert(image_pi)

	sceneGroup:insert(chatBox)
	sceneGroup:insert(chatBox_N)
	sceneGroup:insert(choice[1])
	sceneGroup:insert(choice[2])

	sceneGroup:insert(speaker)
	sceneGroup:insert(content)
	sceneGroup:insert(answer1)
	sceneGroup:insert(answer2)


	-- json에서 읽은 정보 적용하기
	local index = 1
	local i = 0

	local function nextScript( event )
		index = index + 1

		if(index > #Data) then 
			finger.alpha = 1
			composer.hideOverlay("cherry_distractor")
			return
		end

		speaker.text = Data[index].speaker
		content.text = Data[index].content

		if(Data[index].speaker == image_cherry.name) then
			image_cherry.fill = {
				type = "image",
				filename = Data[index].image
			}
			image_cherry.alpha = 1
			image_pi.alpha = 0
		else
			image_pi.fill = {
				type = "image",
				filename = Data[index].image
			}

			image_cherry.alpha = 0
			image_pi.alpha = 1
		end


		if(index == 3) then 
			-- 큰 대화창 비활성화
			chatBox.alpha = 0
			chatBox_N.alpha = 1

			-- 대답박스 활성화
			choice[1].alpha = 1
			choice[2].alpha = 1

			-- 대답활성화
			answer1.alpha = 1
			answer2.alpha = 1
			print("!!!!!")

		elseif(index == 5 and i == 0) then
			finger.alpha = 1
			composer.hideOverlay("cherry_distractor")
			composer.gotoScene( "game_lobby" ) 
			return
		end
	end
	chatBox:addEventListener("tap", nextScript)


	local function choiceScript( event )
		if(event.target == choice[2]) then
			index = index + 2
			i = 1
		else
			index = index + 1
			cherry_interaction = 1
			audio.play(choiceSound)
		end
		print(index)
		if(index == 5 and i == 0) then
			finger.alpha = 1
			composer.hideOverlay("cherry_distractor")
			composer.gotoScene( "game_lobby" ) 
			return
		end

		-- 대답상자 비활성화
		choice[1].alpha = 0
		choice[2].alpha = 0
		-- 대답비활성화
		answer1.alpha = 0
		answer2.alpha = 0

		speaker.text = Data[index].speaker
		content.text = Data[index].content

		if(Data[index].speaker == image_cherry.name) then
			image_cherry.fill = {
				type = "image",
				filename = Data[index].image
			}
			image_cherry.alpha = 1
			image_pi.alpha = 0
		else
			image_pi.fill = {
				type = "image",
				filename = Data[index].image
			}

			image_cherry.alpha = 0
			image_pi.alpha = 1
		end

		chatBox.alpha = 1
		chatBox_N.alpha = 0
	end

	choice[1]:addEventListener("tap", choiceScript)
	choice[2]:addEventListener("tap", choiceScript)


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
		composer.removeScene( "cherry_distractor" )
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
