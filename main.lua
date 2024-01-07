-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- json parsing
local json = require "json"

function jsonParse( src )
	local filename = system.pathForFile( src )
	
	local data, pos, msg
	data, pos, msg = json.decodeFile(filename)

	-- 디버깅
	if data then
		return data
	else
		print("WARNING: " .. pos, msg)
		return nil
	end
end

-- -------------------------------------------------------------

function rotateLoading() -- 로딩창 회전시키는 함수
    transition.to(loading, {
        rotation = loading.rotation + 720, --2바퀴 회전
        x = display.contentCenterX,
        y = display.contentCenterY,
        time = 4000, --3초간
        onComplete = nextScene --회전끝나면, nextScene함수로 이동
        }
    )
end

native.setProperty( "androidSystemUiVisibility" , "immersiveSticky" )

-- show default status bar (iOS)
display.setStatusBar( display.HiddenStatusBar )


-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"

font_Content = "font/PF스타더스트.ttf"
font_Speaker = "font/PF스타더스트 Bold.ttf"


mainBackgroundMusic = audio.loadSound( "sound/default_bgm_1.mp3" )
liarroomSound = audio.loadSound( "sound/거짓말쟁이방.mp3" )
sound_artist = audio.loadSound("sound/예술가의방.mp3")
mansionSound = audio.loadSound("sound/저택 브금.mp3")
sound_liar1 =  audio.loadSound("sound/거짓말쟁이 1.mp3")
sound_liar2 =  audio.loadSound("sound/거짓말쟁이 2.mp3")
sound_rose = audio.loadSound("sound/장미키우기.mp3")
start_page_bgm = audio.loadSound("sound/밝은브금.mp3")


wateringSound = audio.loadSound("sound/물주는_소리.mp3")
witheringSound = audio.loadSound("sound/시드는_소리.mp3")
movingSound = audio.loadSound("sound/파이_이동소리.mp3")
debuggingSound = audio.loadSound("sound/종이 찢는 소리.mp3")

wrongSound = audio.loadSound( "sound/경고음 1 수정.mp3" )
warningSound_short = audio.loadSound("sound/경고음 2(short).mp3")
warningSound = audio.loadSound( "sound/경고음 2.mp3" )

insertItem = audio.loadSound( "sound/게임 시스템/딸깍 소리 1.mp3" )
buttonSound = audio.loadSound( "sound/게임 시스템/딸깍 소리 2.mp3" )
gameSuccess = audio.loadSound( "sound/게임 시스템/성공 소리.mp3" )
questSound = audio.loadSound( "sound/게임 시스템/알림 소리.mp3" )
itemGetSound = audio.loadSound("sound/게임 시스템/아이템 얻는 소리 1.mp3")

buttonSound1 = audio.loadSound( "sound/게임 시스템/버튼 소리 1.mp3" )
buttonSound2 = audio.loadSound( "sound/게임 시스템/버튼 소리 2.mp3" )
sucessSound = audio.loadSound( "sound/게임 시스템/성공 소리.mp3" )

darkSound =  audio.loadSound("sound/게임 시스템/암전 될 때 소리.mp3")
dieSound =  audio.loadSound("sound/베는, 찔리는 소리 2.mp3")
garbageSound = audio.loadSound( "sound/낙엽 밟는 소리.mp3" )

keySound = audio.loadSound("sound/열쇠.mp3")

killBugSound =  audio.loadSound("sound/총소리 2.mp3")

questActive = true


interactionNumber = 0
isInteraction = {}
for i = 1, 8 do
	isInteraction[i] = false
end

itemNum = {}

for i = 1, 6 do
	itemNum[i] = false
end

cherry_interaction = 0
game1 = 0 --거짓말쟁이방
game2 = 0 --장미방
game3 = 0 --예술가의방

-- event listeners for tab buttons:
local function onFirstView( event )
	-- composer.gotoScene( "computerScreen" )
	--composer.gotoScene("screen_garbage") -- 영상 건너 뛰고 시작/시뮬용 시작
	-- composer.gotoScene( "mainScript7" )
	--composer.gotoScene( "compass_prevScript" )
	-- composer.gotoScene( "compass_escape" )
	-- composer.gotoScene("ending")
	-- composer.gotoScene("game_start_loading")
	composer.gotoScene("start1") -- 처음 시작 화면
	-- composer.gotoScene("compass_computerScreen")
	-- composer.gotoScene("key_open")
	-- composer.gotoScene("game_lobby")
	-- composer.gotoScene("game_ending_lobby")
end


onFirstView()	-- invoke first tab button's onPress event manually
