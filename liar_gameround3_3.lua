-----------------------------------------------------------------------------------------
--
-- gameround3_사람3.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
-- ↓ 시작화면 배치 -----------------------=----------------------------------------------------------------------

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	background:setFillColor(0.1, 1) -- 전체 화면

	local room = display.newImage( "image/배경/배경_저택_거짓말쟁이 스포트라이트.png", display.contentWidth*0.5, display.contentHeight*0.5)
	room:scale(0.9, 0.9) -- 게임 방

	local personGroup = composer.getVariable( "personGroup3" )
	local truth_teller = composer.getVariable( "truth_teller3")

	-- ↓ 하트 ----------------------------------------------------------------------------------------------------
	
	local heartGroup = composer.getVariable( "heartGroup")

	-- ↓ 대화창 ----------------------------------------------------------------------------------------------------
	local talk1 = display.newImage("image/UI/대화창 ui.png")
	talk1.x, talk1.y = display.contentWidth*0.5, display.contentHeight*0.7 
	talk1:scale(0.63, 0.78) -- 대화창

	local talk3 = display.newImageRect("image/UI/대화창선택지.png", 200, 70)
	talk3.x, talk3.y = display.contentWidth*0.7, display.contentHeight*0.50
	talk3.alpha = 0 -- 대화창(맞아)

	local talk4 = display.newImageRect("image/UI/대화창선택지.png", 200, 70)
	talk4.x, talk4.y = display.contentWidth*0.7, display.contentHeight*0.56
	talk4.alpha = 0 -- 대화창(아니야)

	local character = display.newImageRect("image/캐릭터/pixil(뒤)-0.png", 120, 120)
	character.x, character.y = display.contentWidth*0.5, display.contentHeight*0.5   -- 주인공

	-- 레이어 정리
	
	-- 레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(room)
	sceneGroup:insert(personGroup)
	sceneGroup:insert(heartGroup)
	sceneGroup:insert(character)
	sceneGroup:insert(talk1)
	sceneGroup:insert(talk3)
	sceneGroup:insert(talk4)

-- ↑ 시작화면 배치 ---------------------------------------------------------------------------------------
-------------------------json1에서 정보 읽고 적용↓(임시)-----------------------------------------------------------
	local Data = jsonParse( "liar_round3_json/3.json" )

	local dialog = display.newGroup()

	local speaker = display.newText(dialog, Data[1].speaker, display.contentWidth*0.37, display.contentHeight*0.68, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker)
	speaker:setFillColor(0)
	speaker.size = 45

	local content = display.newText(dialog, Data[1].content, display.contentWidth*0.62, display.contentHeight*0.83, display.contentWidth*0.7, display.contentHeight*0.2, font_Content)
	content:setFillColor(0)
	content.size = 35

	local yes = display.newText(dialog, Data[1].yes, display.contentWidth*0.7, display.contentHeight*0.50, font_Content) 
	yes:setFillColor(0)
	yes.size = 30

	local no = display.newText(dialog, Data[1].no, display.contentWidth*0.7, display.contentHeight*0.56, font_Content) 
	no:setFillColor(0)
	no.size = 30

	if Data then
		print(Data[1].speaker)
		print(Data[1].content)
		print(Data[1].yes)
		print(Data[1].no)
	end

	local index = 1
	local c = -1 -- 진실을 찾을 경우 1로 변경
	local doublecheck = 0
	local wrong = 0  -- 틀린 경우 1로 변경
	local i = 0  -- 거짓말쟁이찾기/진술 구분
	local w = 0.24  -- 파이 x 위치 설정
	local person = 3

	local function nextScript( event )
		if wrong == 0 and doublecheck ~= 1 then
			index = index + 1
		end

		if event.target == talk3 then
			if (person == truth_teller) then
				i = 1
				c = 1
				doublecheck = 1
			elseif (person ~= truth_teller) then
				wrong = 1
				i = 1
				doublecheck = 1
			end
		end
		
		if wrong == 0 and c == -1 then
			if index == 3 then
				display.remove(dialog)
				composer.setVariable( "heartGroup" , heartGroup)
				composer.setVariable( "personGroup", personGroup )
				composer.gotoScene("liar_gameround3")
				return
			end
			speaker.text = Data[index].speaker
			content.text = Data[index].content
			yes.text = Data[index].yes
			no.text = Data[index].no 
		end

		if i == 1 then    -- 진술 
			talk3.alpha = 0
			talk4.alpha = 0
			if c == 1 and doublecheck == 1 then
				display.remove(dialog)
				composer.gotoScene("liar_clear_black")
				return
			
			elseif wrong == 1 then
				wrong = 0
				i = 0
			end
		elseif i == 0 then      -- 거짓말쟁이 찾기
			talk3.alpha = 1
			talk4.alpha = 1
		end
		
		if heartGroup.numChildren == 0 then
			display.remove(dialog)
			audio.pause(darkSound)
			composer.setVariable( "gameOverNumber" , 4)
			composer.gotoScene("gameOver")
		end

		if i == 1 then
			i = 0
		elseif i == 0 then
			i = 1
		elseif i == -1 then
			i = 1
		end
	end

	-- talk1에 대한 이벤트 리스너 함수 정의
	local function talk1Listener(event)
		if i == 0 then
			nextScript(event)
		elseif doublecheck == 1 then
			nextScript(event)
		end
	end

	-- talk3에 대한 이벤트 리스너 함수 정의
	local function talk3Listener(event)
		if i == 1 then
			talk3.alpha = 0
			talk4.alpha = 0
			if (person == truth_teller) then
				-- 대화창 내용 업데이트
				speaker.text = "1,2,3,4,5"
				content.text = "앗 들켰다!"
				yes.text = ""
				no.text = ""
	
				-- 1초 후에 다음 동작 수행
				timer.performWithDelay(1500, function()
					nextScript(event)
				end)
			elseif (person ~= truth_teller) then
				if heartGroup.numChildren > 0 then
					local lastHeart = heartGroup[heartGroup.numChildren]
					display.remove(lastHeart)  -- 마지막 하트 삭제
					audio.play(dieSound)
	
					-- 대화창 내용 업데이트
					speaker.text = "1,2,3,4,5"
					content.text = "하하하 틀렸어!"
					yes.text = ""
					no.text = ""
	
					-- 1초 후에 다음 동작 수행
					timer.performWithDelay(1000, function()
						nextScript(event)
					end)
				end
			end
		end
	end

	-- talk4에 대한 이벤트 리스너 함수 정의
	local function talk4Listener(event)
		if i == 1 then
			nextScript(event)
		end
	end

	-- talk1에 이벤트 리스너 등록
	talk1:addEventListener("tap", talk1Listener)

	-- talk3에 이벤트 리스너 등록
	talk3:addEventListener("tap", talk3Listener)

	-- talk4에 이벤트 리스너 등록
	talk4:addEventListener("tap", talk4Listener)

	dialog:toFront()

-------------------------json에서 정보 읽고 적용↑(임시)-----------------------------------------------------------
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
		composer.removeScene('liar_gameround3_3') -- 추가
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
composer.recycleOnSceneChange = true
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
