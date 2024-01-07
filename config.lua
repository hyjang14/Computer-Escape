--
-- For more information on config.lua see the Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--

application =
{
	content =
	{
		width = 1080,
		height = 1920, 
		-- width = display.actualContentWidth * 0.5625,
      	-- height = display.actualContentHeight,

		scale = "letterbox",
		fps = 60,
		orientation = {
            default = "landscapeRight", -- 기본 가로 모드 설정
            supported = { "landscapeRight", "landscapeLeft" } -- 지원하는 가로 모드 목록
        },

		xAlign = "center",
		yAlign = "center",

	},
	icon =
	{
		filename = "ic_launcher.png",
		width = 512,
		height = 512,
	}
}
