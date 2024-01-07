-----------------------------------------------------------------------------------------
--
-- robot_findGame.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local previousRoundImages = {}

local randomList
local nextRound = 1
local correct = 0
local answer
local images = {}  

local game


-- 게임 풍선 진동 함수 ---------------------------------------------------------------------------

local function vibrateImage(image, time)
    local initialX, initialY = image.x, image.y
    local shakeMagnitude = 4 -- 진동 크기
    local numShakes = time / 200 
    
    local function shakeImage()
        if numShakes > 0 then
            image.x = initialX + math.random(-shakeMagnitude, shakeMagnitude)
            image.y = initialY + math.random(-shakeMagnitude, shakeMagnitude)
            numShakes = numShakes - 1

            timer.performWithDelay(100, shakeImage)
        else
            -- 원래 자리로 복원하기 
            image.x, image.y = initialX, initialY
        end
    end

    shakeImage()
end

-- 숫자 테이블 섞기 함수  -------------------------------------------------------------------------

function shuffleTable(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
end

-- 중복 없이 1부터 num까지의 랜덤 리스트를 생성하는 함수 -------------------------------------------

function generateUniqueRandomList(num)
    local allNumbers = {} 
    for i = 1, num do
        table.insert(allNumbers, i)
    end

    shuffleTable(allNumbers)

    return allNumbers
end

-- 랜덤으로 1.jpg를 3장, 2.jpg를 1장 선택하는 함수 -----------------------------------------------

local function selectRandomImages(num)
    local mixNum = generateUniqueRandomList(4)

    for i = 1, 4 do
        images[i] = {}
    end

    for i = 1, 3 do
        table.insert(images[mixNum[i]], "image/로봇이 아닙니다/group" .. num .. "/1.jpg")
        images[mixNum[i]].isCorrect = false
    end

    table.insert(images[mixNum[4]], "image/로봇이 아닙니다/group" .. num .. "/2.jpg")
    images[mixNum[4]].isCorrect = true

    return images
end

-- 이미지 객체에 번호를 부여하는 함수  -------------------------------------------------------

local function createImageWithNumber(imagePath, number)
    local image = display.newImage(imagePath)
    image.number = number 
   
    return image
end

-- 이미지들을 2x2 형태로 배치하는 함수  -------------------------------------------------------

local function placeImages(images)
   
    print("placeImages 함수 시작") 

    previousRoundImages = {} 

    local imageWidth = display.contentWidth * 0.15
    local imageHeight = display.contentHeight * 0.15
    local startX = display.contentWidth * 0.60715
    local startY = display.contentHeight * 0.499
    local gapX = 145.3
    local gapY = 87
    local index = 1

    for i = 1, 2 do
        for j = 1, 2 do
            local image = createImageWithNumber(images[index][1], index)
          
            image.x = startX + (imageWidth + gapX) * (j - 1)
            image.y = startY + (imageHeight + gapY) * (i - 1)

            local scale = imageWidth / image.width
            image:scale(0.435, 0.42)

            if images[index].isCorrect == true then

                answer = index 
                print("정답 번호: " ..answer)
            end

            table.insert(previousRoundImages, image) 

            index = index + 1

            if timeAttack then
                timer.cancel(timeAttack)
                timeAttack = nil
            end

            -- ↓ 이미지의 탭 이벤트 함수 ----------------------------------------------------

            local function onImageTap(event, number)
                local image = event.target

                print("눌린 사진 번호: " ..image.number)

                if image.number == number then
                    print("정답입니다!")

                    correct = correct + 1
                    print("정답 횟수: " .. correct)
                else
                    vibrateImage(game, 700)

                    print("실패입니다!")
                    print("정답 횟수: " .. correct)

                    local wrong = display.newText("틀렸습니다!", display.contentWidth*0.89, display.contentHeight*0.32)
                    wrong.size = 42
                    wrong:setFillColor(1, 0.85, 0)
                    wrong.alpha = 1

                    -- 경고음 재생 --------------------

                    audio.play( wrongSound )

                    local function hideText()
                        wrong.isVisible = false
                    end

                    timer.performWithDelay(500, hideText)

                end

                -- 전 라운드 이미지들 이벤트 & 사진 삭제하기 --------------

                for i = 1, #previousRoundImages do
                    local image = previousRoundImages[i]

                    if image.tapListener then
                        image:removeEventListener("tap", image.tapListener)
                        image.tapListener = nil
                    end

                    display.remove(image) 
                end

                --------------------------------------------------------

                nextRound = nextRound + 1

                if nextRound > 10 then
                    audio.stop()
                    timer.performWithDelay(500, function()
	                composer.gotoScene("login_death")
                    end)
                end

                print(randomList[nextRound - 1].. "라운드")

                -- ↓ 정답이 5가 아니면 다음 라운드 사진 배치  ------------

                if correct < 5 and nextRound <= 10 then
                    images = selectRandomImages(randomList[nextRound])
                    placeImages(images)
                else
                    print("로딩중!") 
                end

                -----------------------------------------------
            end

            -- ↑ 이미지의 탭 이벤트 함수 ---------------------------------------------------

            local tapListener = function(event)
                onImageTap(event, answer) 
            end

            image.tapListener = tapListener 
            image:addEventListener("tap", image.tapListener)
        end
    end
end

local isInitialized = false

function scene:create( event )

   local sceneGroup = self.view

    if not isInitialized then

        local background = display.newImageRect("image/로봇이 아닙니다/game_bg.png", display.contentWidth, display.contentHeight)
        background.x, background.y = display.contentWidth/2, display.contentHeight/2

        local check_rec = display.newImage("image/로봇이 아닙니다/check.png")
        check_rec.x, check_rec.y = display.contentWidth*0.63, display.contentHeight*0.53
        check_rec:scale(1, 1)
        check_rec.x = check_rec.x - 730

        game = display.newImage("image/로봇이 아닙니다/game.png")
        game.x, game.y = display.contentWidth * 0.72, display.contentHeight * 0.53
        game:scale(1, 1)

        sceneGroup:insert(background)
        sceneGroup:insert(check_rec)
        sceneGroup:insert(game)

        -- ↓ 시간 -------------------------------------------------------------------------------------------------

        local hour = os.date( "%I" )
        local minute = os.date( "%M" )

        local hourText = display.newText(hour, display.contentWidth*0.919, display.contentHeight*0.972, font_Speaker)
        hourText.size = 46
        hourText:setFillColor(0)
        local minuteText = display.newText(minute, display.contentWidth*0.975, display.contentHeight*0.972, font_Speaker)
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

        hourText:toFront()
        minuteText:toFront()

        -- ↑ 시간 -------------------------------------------------------------------------------------------------


        -- 랜덤 리스트 생성하기
        randomList = generateUniqueRandomList(10)

        for i = 1, 10 do
            print(randomList[i])
        end

        local i = 1

        -- 랜덤으로 1.jpg 3장, 2.jpg 1장을 선택하기
        images = selectRandomImages(randomList[1])

        -- ↓ 초시계 생성 ----------------------------------------------------------------------------

        local time = display.newText(10, display.contentWidth*0.7475, display.contentHeight*0.318)

        time.size = 45
        time:setFillColor(1, 0.85, 0)

        sceneGroup:insert(time)

        --------------------------------------------------------------------------------------------

        local timeAttack

        local function counter( event )

            time.text = time.text - 1

            if(time.text == '3') then
                time:setFillColor(1, 0, 0)
            end

            if(time.text == '0') then
                time.alpha = 0

                for i = 1, #previousRoundImages do
                    local image = previousRoundImages[i]

                    if image.tapListener then
                        image:removeEventListener("tap", image.tapListener)
                        image.tapListener = nil
                    end

                    display.remove(image) 
                   
                end

                -- 실패하면 bgm끄고 end로 넘어간다 ----------

                audio.stop()
                composer.gotoScene('login_death') -- 실패

                -------------------------------------------
            end

            -- 성공하면 bgm끄고 loading으로 넘어간다 --------

            if(correct == 5) then
                timer.pause(timeAttack)
                time:removeSelf()
                audio.play(gameSuccess)
                composer.gotoScene('robot_loading', {effect = fade}) -- 성공
            end

            ---------------------------------------------
        end

        -- -1까지 할거라 11번 반복하기

        timeAttack = timer.performWithDelay(1000, counter, 11)

        -- 이미지 배치하기
        placeImages(images)

        isInitialized = true
    end

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
        composer.removeScene( "robot_findGame" )
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
