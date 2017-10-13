local sonidosSettings = {}
sonidosSettings.__index = sonidosSettings

sonidosSettings.loader = {
	heroe = {
		attack1 = audio.loadSound("audio/effects/NFF-kid-attack.mp3")
	},
	levelBackground = {
		audio.loadStream("audio/themes/OveMelaa-HeavenSings2.mp3")
	},
  stickerBookBackground = audio.loadStream("audio/themes/OveMelaa-HeavenSings2.mp3")
}

sonidosSettings.channels = {
    background = 1,
    heroe = 2,
    enemys1 = 3
}

return sonidosSettings
