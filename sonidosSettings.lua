local sonidosSettings = {}
sonidosSettings.__index = sonidosSettings

local eFolder = 'audio/effects/'
sonidosSettings.effects = {
	heroe = {
		attack1 = audio.loadSound(eFolder .. 'heroAttack.mp3')
	},
	enemys = {
		Zombie = {
			spawn = audio.loadSound(eFolder .. 'enemyZombieSpawn.mp3'),
			dead = audio.loadSound(eFolder .. 'enemyZombieDead.mp3')
		}
	},
	ui = {
		menuSelect = audio.loadSound(eFolder .. 'uiMenuSelect.mp3'),
		menuBack = audio.loadSound(eFolder .. 'uiMenuBack.mp3'),
	},
	level = {
		init = audio.loadSound(eFolder .. 'levelInit.mp3')
	}
}

local tFolder = 'audio/themes/'
sonidosSettings.themes = {
	levelBackground = {
		audio.loadStream(tFolder .. 'OveMelaa-HeavenSings2.mp3')
	},
  stickerBookBackground = audio.loadStream(tFolder .. 'OveMelaa-HeavenSings2.mp3')
}

sonidosSettings.channels = {
    background = 1,
    heroe = 2,
    enemys1 = 3
}

return sonidosSettings
