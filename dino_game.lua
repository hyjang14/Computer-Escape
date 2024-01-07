-----------------------------------------------------------------------------------------
--
-- dino_test.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")

physics.start()
physics.setGravity(0,40)

--배경
local window
local window_bar
local background
local cursor
--오브제
local ground
local dino
local pi
local oh --파이옆에뜬 느낌표, 파이누르면 게임시작되고 느낌표도 사라짐
local obstacles = {}
--score
local score = 0
local scoreText

local gameSpeed = 15
local isJumping = false
local isGameOver = false
local isLanded = false
local timer1
local timer2
local speedTimer

local gameOverImage

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
-- sceneGroup:insert(text)

local function counter( event )
	hour = os.date( "%I" )
	hourText.text = hour
	minute = os.date( "%M" )
	minuteText.text = minute
end

timer.performWithDelay(1000, counter, -1)



-- ↑ 시간 -------------------------------------------------------------------------------------------------

--장애물 생성 함수------------------------------------------------------------------------
local function createObstacle()
	local obs = display.newImageRect("image/디노/obstacle.png", 60,120)
	obs.x, obs.y = display.contentWidth*0.8, display.contentHeight*0.45
	physics.addBody(obs, "kinematic")
	table.insert(obstacles, obs)
end
--장애물 이동 함수------------------------------------------------------------------------
local function moveObstacles(event)
	for i = #obstacles, 1, -1 do 
		local obstacle = obstacles[i] 
		obstacle.x = obstacle.x - gameSpeed -- 장애물 움직임

		if obstacle.x < -60 then
			display.remove(obstacle)
			table.remove(obstacles, i)
			
			if not isGameOver then
				gameSpeed = gameSpeed + 0.1
				score = score + 1
			end

		end
		if isGameOver then
			for i = #obstacles, 1, -1 do
				display.remove(obstacle)
			end
		end
		
	end
end
--점수 표시 함수 ---------------------------------------------------------------------
local function updateScore()
	local totalOptions = {
		text = "누적 "..score .. "kcal" ,
		x = display.contentWidth*0.5,
		y = display.contentHeight*0.25,
		width = ground.width - 20,
		font = "font/PF스타더스트.ttf",
		fontSize = 46,
		align = "right"
	}
	scoreText = display.newText(totalOptions)
	scoreText:setFillColor(0.3)
end

--디노 점프 함수 -------------------------------------------------------------------------
local function jumpDino(event)

	if event.phase == "ended" then
		if not isJumping then
    		dino:setLinearVelocity(0, -1000)  -- 제자리에서 점프 힘을 캐릭터에 적용
			isJumping = true
			isLanded = false
			print("점프!")
			--scoreText()
			display.remove(scoreText)
			updateScore()
		end
    end
end
--게임 함수 -------------------------------------------------------------------------
local function gameLoop() --장애물 생성->이동->제거함수 //2초마다 소환됨
	
	createObstacle()

end
local function gameStart(event) --<파이 누르면> 게임시작
	if not isGameOver then --게임오버되지 않았을때
		--느낌표 삭제
		display.remove(oh)
		--점수표시제거
		display.remove(scoreText)
		--점수표시
		updateScore()
		--파이터치이벤트삭제
		pi:removeEventListener("touch", gameStart)
		---------------------------------
		timer1 = timer.performWithDelay(2000, gameLoop, 0) --2초마다 장애물생성
		Runtime:addEventListener("enterFrame", moveObstacles)
		--local time2 = timer.performwithDelay(1000, updateScore)
	end
end
--게임오버show 함수 ------------------------------------------------------------------------
local function showGameOver()
    isGameOver = true 
	display.remove(scoreText)
    -- Remove event listeners
    Runtime:removeEventListener("enterFrame", moveObstacles)
	--cursor:removeEventListener("touch", jumpDino)
	--Runtime:removeEventListener("collision", checkGroundCollision)
	--Runtime:removeEventListener("collision", checkObstacleCollision)
	
	for i = 1, #obstacles do
		display.remove(obstacles[i])
	end
    timer.cancel(timer1)

    -- Display game over image
    gameOverImage.alpha = 1

	--gameOverImage:addEventListener("touch", restart)
	
end

--충돌 감지 함수 -------------------------------------------------------------------------
local function checkGroundCollision(event) --지면충돌감지 (점프제어용)
	if event.phase == "began" and not isLanded then
		if (event.object1 == dino and event.object2 == ground)
			or (event.object1 == ground and event.object2 == dino) then
			isJumping = false
			isLanded = true
			print("착지~")
			dino:setLinearVelocity(0,0) --땅에 떨어졌을때 반동 없앰
			dino:removeEventListener("collision", checkGroundCollision) -- 충돌 감지 이벤트 제거
		end
	end
end

local function checkObstacleCollision(event) --장애물충돌감지 (게임오버용)
	for i = #obstacles, 1, -1 do
		local obstacle = obstacles[i]

		if (event.object1 == dino and event.object2 == obstacle)
			or (event.object1 == obstacle and event.object2 == dino) then --부딪히면
			isJumping = false
			print("꺅! 충돌!")
			dino:setLinearVelocity(0,0) --땅에 떨어졌을때 반동 없앰
			display.remove(obstacles)
			showGameOver()
		end
	end
end
--게임 재시작 함수 ----------------------------------------------------------------------
local function restart(event)
	if event.phase == "ended" then
		
		display.remove(gameOverImage)
		display.remove(sceneGroup)
		
		composer.removeScene("dino_game")
		composer.gotoScene("dino_intro")
	end
	
end
--main function -------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view
	--창(배경)
	window = display.newImageRect("image/디노/DINO_window_.png", display.contentWidth, display.contentHeight)
	window.x, window.y = display.contentCenterX, display.contentCenterY
	--작업바
	window_bar = display.newImage("image/UI/하단바 와이파이 오프.png")
	window_bar.x, window_bar.y = display.contentCenterX, display.contentHeight*0.968
	--게임칸
	background = display.newImageRect("image/디노/game_background.png", 1500,450)
	background.x, background.y =  display.contentWidth/2, display.contentHeight*0.41
	--커서
	cursor = display.newImage("image/UI/커서.png")
	cursor.x, cursor.y = 1560, 810 
	--파이
	pi = display.newImageRect("image/캐릭터/pixil(왼)-0.png", 120, 120)
	pi.x, pi.y = display.contentWidth*0.92, display.contentHeight*0.45
	--느낌표
	oh = display.newImageRect("image/디노/oh.png", 40,60)
	oh.x, oh.y = pi.x + 60, pi.y - 50

	sceneGroup:insert( window )
	sceneGroup:insert(window_bar)
	sceneGroup:insert( background )
	sceneGroup:insert( cursor )
	sceneGroup:insert( pi )
	sceneGroup:insert( oh )


	--게임 초기화 함수 -------------------------------------------------------
	local function initGame()
	 	gameSpeed = 5
	 	--지면
	 	ground = display.newRect(display.contentWidth/2, display.contentHeight/2, 1400,10)
	 	physics.addBody(ground, "static")
	 	ground:setFillColor(0)
	 	--디노
	 	dino = display.newImageRect("image/디노/디노0.png", 120,120)
		dino.x , dino.y = display.contentWidth*0.2, display.contentHeight*0.45
	 	physics.addBody(dino, "dynamic")
	 	--게임오버화면
	 	gameOverImage = display.newImageRect("image/디노/game_over.png", 800, 600)
     	gameOverImage.x, gameOverImage.y = display.contentCenterX, display.contentCenterY
	 	gameOverImage.alpha = 0
	
	 	sceneGroup:insert( ground )
	 	sceneGroup:insert( dino )
	
	 	cursor:addEventListener("touch", jumpDino)
	 	Runtime:addEventListener("collision", checkGroundCollision)
	 	Runtime:addEventListener("collision", checkObstacleCollision)
	 	gameOverImage:addEventListener("touch", restart)

	 	pi:addEventListener("touch", gameStart) --파이터치 => 게임스타트
		
		
	end
	-----------------------------------------------------------------------------
	initGame()
	sceneGroup:insert(hourText)
	sceneGroup:insert(minuteText)
	sceneGroup:insert(text)
end



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		display.remove(test2)

	elseif phase == "did" then
		-- Runtime:addEventListener("enterFrame", gameloop)
		-- Runtime:addEventListener("collision", checkCollisions)
		
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
		composer.removeScene("dino_game")
		

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