local heroSettings = {}
heroSettings.__index = heroSettings

heroSettings.damage = {
	imagen = 'images/hero/damage.png'
}

heroSettings.attack = {
	imagen = {
		'images/hero/attack1.png',
		'images/hero/attack2.png',
	}
}

heroSettings.hiddleAnimation = {
	name = 'hiddle',
	spriteSheet = 'images/hero/iddle.png',
	width = 116,
	height = 100,
	numFrames = 24,
	time = 1000,
	loopDirection = 'forward',
	loopCount = 0,
	start = 1
}

return heroSettings
