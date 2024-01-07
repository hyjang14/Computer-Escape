-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	audio.play(buttonSound)

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80
	sceneGroup:insert(inventory)

	local back = display.newImageRect("image/UI/인벤토리(칸).png", 777.5, 415)
	back.x, back.y = display.contentWidth * 0.275 , display.contentHeight * 0.332
	sceneGroup:insert(back)

	-- 나침반 추가 코드: 빈 원형 클릭 배치하기 -------------------------------------------------------------------------------------------

	local not_interaction = display.newImageRect("image/UI/빈원형.png", 130, 130)
	not_interaction.x, not_interaction.y = 1740, 680
	not_interaction.alpha = 0.01
	sceneGroup:insert(not_interaction)

	--****** 아래 hide() 함수에서 display.remove(not_interaction) 코드 추가함 ******

	local item = {}
	-- key, sim, key_sum, compass, arm, ribbon
	item[1] = display.newImageRect("image/자물쇠/1자열쇠.png", 115, 115)
	item[2] = display.newImageRect("image/자물쇠/심.png", 110, 110)
	item[3] = display.newImageRect("image/자물쇠/열쇠(균일).png", 115, 115)
	item[4] = display.newImageRect("image/자물쇠/나침반.png", 110, 110)
	item[5] = display.newImageRect("image/자물쇠/총.png", 110, 110)
	item[6] = display.newImageRect("image/자물쇠/리본.png", 110, 110)

	local IN = 0

	for i = 1, 6 do
		item[i].name = i
		sceneGroup:insert(item[i])

		if itemNum[i] == true then
			item[i].alpha = 1
			if IN < 5 then
				item[i].x, item[i].y = 235 + IN * 147, display.contentHeight * 0.282
			else
				item[i].x, item[i].y = 235 + (IN-5) * 147, display.contentHeight * 0.432
			end
			IN = IN +  1
		else
			item[i].alpha = 0
		end
	end



	-- ↑ ui정리 -------------------------------------------------------------------------------------------------


	local compassDrag = composer.getVariable("compassGrag")

	-- 나침반 추가 코드: ↓ 나침반 함수 정리  -----------------------------------------------------------------------------------------------

	local function compassReaction(event) -- 나침반 이동 이벤트 
		if( event.phase == "began" ) then
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true

			-- 드래그 시작할 때
			event.target.x0 = event.target.x
            event.target.y0 = event.target.y

		elseif ( event.phase == "moved" ) then
			
			if ( event.target.isFocus ) then
				-- 드래그 중일 때
				local newX = event.target.x0 + event.x - event.xStart
                local newY = event.target.y0 + event.y - event.yStart
				event.target.x = newX
                event.target.y = newY
			end

		elseif ( event.phase == "ended" or event.phase == "cancelled"  ) then
			if ( event.target.x > not_interaction.x - 50 and event.target.x < not_interaction.x + 50 
				and event.target.y > not_interaction.y - 50 and event.target.y < not_interaction.y + 50 ) then

				display.getCurrentStage():setFocus( nil )

				audio.play( insertItem )

				local new_item4 = display.newImageRect("image/자물쇠/나침반.png", 110, 110)
				new_item4.x, new_item4.y = 1740, 680
				sceneGroup:insert(new_item4)

				item[4].alpha = 0
				itemNum[4] = false

				-- ↓ 휴지통 입장 코드  --------------------------------------------------------------------------------------------------

			 	composer.gotoScene( "compass_trashcan" )

				-- ↑ 휴지통 입장 코드 ---------------------------------------------------------------------------------------------------
				
			else
				display.getCurrentStage():setFocus( nil )
				
				event.target.x = event.target.x0
				event.target.y = event.target.y0
			end
		end

	end

	if itemNum[4] == true and compassDrag == true then
		item[4]:addEventListener("touch", compassReaction)
	end

	-- 나침반 추가 코드: ↑ 나침반 함수 정리  -----------------------------------------------------------------------------------------------

	-- ↓ 함수 정리 ------------------------------------------------------------------------------------------------------------

	-- 열쇠 심+본체 합치기
	local function keyReaction1(event) -- 1자열쇠 이동
		if( event.phase == "began" ) then
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true
			-- 드래그 시작할 때
			event.target.x0 = event.target.x
            event.target.y0 = event.target.y

		elseif ( event.phase == "moved" ) then
			
			if ( event.target.isFocus ) then
				-- 드래그 중일 때
				local newX = event.target.x0 + event.x - event.xStart
                local newY = event.target.y0 + event.y - event.yStart
				event.target.x = newX
                event.target.y = newY
			end

		elseif ( event.phase == "ended" or event.phase == "cancelled"  ) then
			if ( item[2].x - 50 < event.target.x and event.target.x < item[2].x + 50 and item[2].y - 50 < event.target.y and event.target.y < item[2].y + 50 ) then
				display.getCurrentStage():setFocus( nil )

				item[1].alpha = 0
				item[2].alpha = 0
				item[3].alpha = 1
				itemNum[1] = false
				itemNum[2] = false
				itemNum[3] = true

				item[3].x, item[3].y = 382, display.contentHeight * 0.282
			else
				display.getCurrentStage():setFocus( nil )
				
				event.target.x = event.target.x0
				event.target.y = event.target.y0
			end
		end

	end

	local function keyReaction2(event) -- 심 이동
		if( event.phase == "began" ) then
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true

			-- 드래그 시작할 때
			event.target.x0 = event.target.x
            event.target.y0 = event.target.y

		elseif ( event.phase == "moved" ) then
			
			if ( event.target.isFocus ) then
				-- 드래그 중일 때
				local newX = event.target.x0 + event.x - event.xStart
                local newY = event.target.y0 + event.y - event.yStart
				event.target.x = newX
                event.target.y = newY
			end

		elseif ( event.phase == "ended" or event.phase == "cancelled"  ) then
			if ( item[1].x - 50 < event.target.x and event.target.x < item[1].x + 50 and item[2].y - 50 < event.target.y and event.target.y < item[2].y + 50 ) then
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false
				
				item[1].alpha = 0
				item[2].alpha = 0
				item[3].alpha = 1
				itemNum[1] = false
				itemNum[2] = false
				itemNum[3] = true

				item[3].x, item[3].y = 235, display.contentHeight * 0.282
			else
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false

				event.target.x = event.target.x0
				event.target.y = event.target.y0
			end
		end

	end
	if itemNum[1] == true and itemNum[2] == true then
		item[1]:addEventListener("touch", keyReaction1)
		item[2]:addEventListener("touch", keyReaction2)
	end

	--	열쇠 만들기 이동
	local function tapKeyMaking(event)
		-- print(go)
		composer.showOverlay("key_making", {isModal == true})
	end
	item[3]:addEventListener("tap", tapKeyMaking)

	-- 아이템 설명창 이동
	local function tapItemDescription( event )
		if event.target.name == 1 then
			composer.setVariable("number", 1)
		elseif event.target.name == 2 then
			composer.setVariable("number", 2)
		elseif event.target.name == 4 then
			composer.setVariable("number", 4)
		elseif event.target.name == 5 then
			composer.setVariable("number", 5)
		elseif event.target.name == 6 then
			composer.setVariable("number", 6)
		end
		composer.showOverlay("inven_explain", {isModal == true})
	end
	for i = 1, 6 do
		if i ~= 3 then
			item[i]:addEventListener("tap", tapItemDescription)
		end
	end

	-- 인벤토리 끄기
	local function hide( event )
		audio.play(buttonSound)
		composer.hideOverlay("inventoryScene")
	end
	inventory:addEventListener("tap", hide)


	-- 열쇠 게임시 열쇠/자물쇠 상호작용 함수
	local crt
	local isLockingImage = composer.getVariable("isLockingImage")

	local function checkKeyRight(event)

		if( event.phase == "began" ) then
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true

			-- 드래그 시작할 때
			event.target.x0 = event.target.x
            event.target.y0 = event.target.y


		elseif ( event.phase == "moved" ) then
			
			if ( event.target.isFocus ) then
				-- 드래그 중일 때

				local newX = event.target.x0 + event.x - event.xStart
                local newY = event.target.y0 + event.y - event.yStart
				event.target.x = newX
                event.target.y = newY
			end

		elseif ( event.phase == "ended" or event.phase == "cancelled"  ) then
			crt = composer.getVariable("correct")
			print(crt)

			if ( event.target.isFocus ) then
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false
				-- 드래그 끝났을 때
				-- print(event.target.x, event.target.y)

				if(event.target.x > 760 and event.target.x < 1130 and event.target.y > 660 and event.target.y < 1000) then
					if(crt == 3 and isLockingImage == true) then -- 열쇠게임 성공
						audio.play(gameSuccess)
						composer.gotoScene("key_open")
					else
						-- 오답 소리
						audio.play(wrongSound)
						
						event.target.x = event.target.x0
						event.target.y = event.target.y0
					end
				else
					event.target.x = event.target.x0
					event.target.y = event.target.y0
				end
			else
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false

				event.target.x = event.target.x0
				event.target.y = event.target.y0
			end
		end
	end
	item[3]:addEventListener("touch", checkKeyRight)

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
		composer.removeScene( "inventoryScene" )
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
