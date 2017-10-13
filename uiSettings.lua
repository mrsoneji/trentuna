local ui = {}
ui.__index = ui

local folder = "images/ui/"

ui.bossapproaching = folder .. "bossapproaching.png"
ui.gameover = folder .. "gameover.png"
ui.stickerbook = folder .. "stickerbook.png"
ui.sounds = folder .. "sounds.png"
ui.stickerbookblocked = folder .. "stickerbookblocked.png"
ui.stickerbookblocked = folder .. "stickerbook.png"
ui.victory = folder .. "victory.png"
ui.music = folder .. "music.png"
ui.effects = folder .. "effects.png"
ui.done = folder .. "done.png"
ui.exit = folder .. "exit.png"

ui.levelLabel = {
	folder .. "leveli.png",
	folder .. "levelii.png",
	folder .. "leveliii.png",
	folder .. "leveliv.png",
	folder .. "levelv.png",
	folder .. "levelvi.png",
	folder .. "levelvii.png",
	folder .. "levelviii.png",
	folder .. "levelvix.png",
	folder .. "levelx.png"
}

ui.title = {
	name = "title",
	spriteSheet = folder .. "trentunaTitle.png",
	width = 256,
	height = 75,
	numFrames = 48,
	time = 2000,
	loopDirection = "forward",
	loopCount = 0,
	start = 1
}

ui.play = folder .. "play.png"
ui.options = folder .. "options.png"

ui.wave1 = {
	name = "wave1",
	spriteSheet = folder .. "wave1.png",
	width = 148,
	height = 63,
	numFrames = 24,
	time = 1000,
	loopDirection = "forward",
	loopCount = 0,
	start = 1
}

ui.wave2 = {
	name = "wave2",
	spriteSheet = folder .. "wave2.png",
	width = 163,
	height = 63,
	numFrames = 24,
	time = 1000,
	loopDirection = "forward",
	loopCount = 0,
	start = 1
}

ui.wave3 = {
	name = "wave3",
	spriteSheet = folder .. "wave3.png",
	width = 154,
	height = 60,
	numFrames = 24,
	time = 1000,
	loopDirection = "forward",
	loopCount = 0,
	start = 1
}

ui.wave4 = {
	name = "wave4",
	spriteSheet = folder .. "wave4.png",
	width = 169,
	height = 66,
	numFrames = 24,
	time = 1000,
	loopDirection = "forward",
	loopCount = 0,
	start = 1
}

ui.wave5 = {
	name = "wave5",
	spriteSheet = folder .. "wave5.png",
	width = 157,
	height = 64,
	numFrames = 24,
	time = 1000,
	loopDirection = "forward",
	loopCount = 0,
	start = 1
}

ui.wave6 = {
	name = "wave6",
	spriteSheet = folder .. "wave6.png",
	width = 169,
	height = 61,
	numFrames = 24,
	time = 1000,
	loopDirection = "forward",
	loopCount = 0,
	start = 1
}

ui.wave7 = {
	name = "wave7",
	spriteSheet = folder .. "wave7.png",
	width = 184,
	height = 63,
	numFrames = 24,
	time = 1000,
	loopDirection = "forward",
	loopCount = 0,
	start = 1
}

ui.wave8 = {
	name = "wave8",
	spriteSheet = folder .. "wave8.png",
	width = 202,
	height = 63,
	numFrames = 24,
	time = 1000,
	loopDirection = "forward",
	loopCount = 0,
	start = 1
}

ui.wave9 = {
	name = "wave9",
	spriteSheet = folder .. "wave9.png",
	width = 170,
	height = 64,
	numFrames = 24,
	time = 1000,
	loopDirection = "forward",
	loopCount = 0,
	start = 1
}

ui.wave10 = {
	name = "wave10",
	spriteSheet = folder .. "wave10.png",
	width = 157,
	height = 63,
	numFrames = 24,
	time = 1000,
	loopDirection = "forward",
	loopCount = 0,
	start = 1
}

function ui.getWave(n)
	if n == 1 then 
		return ui.wave1
	elseif n == 2 then
		return ui.wave2
	elseif n == 3 then
		return ui.wave3
	elseif n == 4 then
		return ui.wave4
	elseif n == 5 then
		return ui.wave5
	elseif n == 6 then
		return ui.wave6
	elseif n == 7 then
		return ui.wave7
	elseif n == 8 then
		return ui.wave8
	elseif n == 9 then
		return ui.wave9
	elseif n == 10 then
		return ui.wave10
	end
end

return ui
