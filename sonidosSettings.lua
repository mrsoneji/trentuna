local sonidosSettings = {}
sonidosSettings.__index = sonidosSettings

local eFolder = 'audio/effects/'
sonidosSettings.effects = {
  heroe = {
    attack1 = audio.loadSound(eFolder .. 'heroAttack.mp3'),
    hurt1 = audio.loadSound(eFolder .. 'heroHurt1.mp3'),
    hurt2 = audio.loadSound(eFolder .. 'heroHurt2.mp3'),
    win = audio.loadSound(eFolder .. 'heroWin.mp3'),
    dead = audio.loadSound(eFolder .. 'heroDead.mp3')
  },
  enemys = {
    zombie = {
      spawn = audio.loadSound(eFolder .. 'enemyZombieSpawn.mp3'),
      dead = audio.loadSound(eFolder .. 'enemyZombieDead.mp3')
    },
    whiteSkeleton = {
      spawn = audio.loadSound(eFolder .. 'enemySkeletonSpawn.mp3'),
      dead = audio.loadSound(eFolder .. 'enemyZombieDead.mp3')
    },
    romanSoldier = {
      spawn = audio.loadSound(eFolder .. 'enemyRomanSpawn.mp3'),
      dead = audio.loadSound(eFolder .. 'enemyZombieDead.mp3')
    },
    blackSkeleton = {
      spawn = audio.loadSound(eFolder .. 'enemyZombieSpawn.mp3'),
      dead = audio.loadSound(eFolder .. 'enemyZombieDead.mp3')
    },
    orangeDragon = {
      spawn = audio.loadSound(eFolder .. 'enemyDragonSpawn.mp3'),
      dead = audio.loadSound(eFolder .. 'enemyZombieDead.mp3')
    },
    greenWizard = {
      spawn = audio.loadSound(eFolder .. 'enemyGreenWizard.mp3'),
      dead = audio.loadSound(eFolder .. 'enemyZombieDead.mp3')
    },
    lamberto = {
      spawn = audio.loadSound(eFolder .. 'enemyLambertoSpawn.mp3'),
      dead = audio.loadSound(eFolder .. 'enemyZombieDead.mp3')
    },
    harpia = {
      spawn = audio.loadSound(eFolder .. 'enemyHarpiaSpawn.mp3'),
      dead = audio.loadSound(eFolder .. 'enemyZombieDead.mp3')
    },
    cascanueces = {
      spawn = audio.loadSound(eFolder .. 'enemyCascanuecesSpawn.mp3'),
      dead = audio.loadSound(eFolder .. 'enemyZombieDead.mp3')
    },
    lobizon = {
      spawn = audio.loadSound(eFolder .. 'enemyLobizonSpawn.mp3'),
      dead = audio.loadSound(eFolder .. 'enemyLobizonDead.mp3')
    },
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
  level = {
    audio.loadStream(tFolder .. 'OveMelaa-HeavenSings2.mp3'),
    audio.loadStream(tFolder .. 'HeroicDemiseNew.mp3'),
    audio.loadStream(tFolder .. 'OveMelaa-HeavenSings2.mp3'),
    audio.loadStream(tFolder .. 'HeroicDemiseNew.mp3'),
    audio.loadStream(tFolder .. 'DarkWinds.mp3'),
  },
  stickerBook = audio.loadStream(tFolder .. 'book.mp3'),
  menu = audio.loadStream(tFolder .. 'medieval.mp3')
}

sonidosSettings.channels = {
    background = 1,
    heroe = 2,
    enemys = 3
}

return sonidosSettings
