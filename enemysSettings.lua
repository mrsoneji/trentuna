local enemysSettings = {}
enemysSettings.__index = enemysSettings
-- alksdjf
enemysSettings.killedAnimation = {
    name = "killed",
    spriteSheet = "images/effects/deleted.png",
    width = 106,
    height = 100,
    numFrames = 24,
    time = 1000,
    loopDirection = "forward",
    loopCount = 1,
    start = 1
}

enemysSettings.list = {
    {
        nombre = "Zombie",
        sprite = "",
        deathSequence = {"HACIAABAJO"},
        deathSequenceIcons = {"images/gestos/HACIAABAJO.png"},
        speed = 10000,
        animations = {
            {
                name = "hiddle",
                spriteSheet = "images/enemys/zombiWalk.png",
                width = 80,
                height = 100,
                numFrames = 24,
                time = 1000,
                loopDirection = "forward",
                loopCount = 0,
                start = 1
            }
        }
    },
    {
        nombre = "White Skelenton",
        sprite = "",
        deathSequence = {"CDESDEARRIBA"},
        deathSequenceIcons = {"images/gestos/CDESDEARRIBA.png"},
        speed = 10000,
        animations = {
            {
                name = "hiddle",
                spriteSheet = "images/enemys/skeleton1Walk.png",
                width = 59,
                height = 100,
                numFrames = 24,
                time = 1000,
                loopDirection = "forward",
                loopCount = 0,
                start = 1
            }
        }
    },
    {
        nombre = "Roman Soldier",
        sprite = "",
        deathSequence = {"HACIAABAJO"},
        deathSequenceIcons = {"images/gestos/HACIAABAJO.png"},
        speed = 10000,
        animations = {
            {
                name = "hiddle",
                spriteSheet = "images/enemys/romanWalk.png",
                width = 92,
                height = 100,
                numFrames = 24,
                time = 1000,
                loopDirection = "forward",
                loopCount = 0,
                start = 1
            }
        }
    },
    {
        nombre = "Black Skelenton",
        sprite = "",        
        deathSequence = {"N"},
        deathSequenceIcons = {"images/gestos/N.png"},
        speed = 10000,
        animations = {
            {
                name = "hiddle",
                spriteSheet = "images/enemys/skeleton2Walk.png",
                width = 59,
                height = 100,
                numFrames = 24,
                time = 1000,
                loopDirection = "forward",
                loopCount = 0,
                start = 1
            }
        }
    },
    {
        nombre = "Orange Dragon",
        sprite = "",        
        deathSequence = {"HACIAIZQUIERDA"},
        deathSequenceIcons = {"images/gestos/HACIAIZQUIERDA.png"},
        speed = 10000,
        animations = {
            {
                name = "hiddle",
                spriteSheet = "images/enemys/dragonWalk.png",
                width = 80,
                height = 100,
                numFrames = 24,
                time = 1000,
                loopDirection = "forward",
                loopCount = 0,
                start = 1
            }
        }
    },
    {
        nombre = "Green Wizard",
        sprite = "",        
        deathSequence = {"S"},
        deathSequenceIcons = {"images/gestos/S.png"},
        speed = 10000,
        animations = {
            {
                name = "hiddle",
                spriteSheet = "images/enemys/magoVerdeWalk.png",
                width = 94,
                height = 100,
                numFrames = 24,
                time = 1000,
                loopDirection = "forward",
                loopCount = 0,
                start = 1
            }
        }
    },
    {
        nombre = "Lamberto",
        sprite = "",        
        deathSequence = {"HACIADERECHA"},
        deathSequenceIcons = {"images/gestos/HACIADERECHA.png"},
        speed = 10000,
        animations = {
            {
                name = "hiddle",
                spriteSheet = "images/enemys/lambertoWalk.png",
                width = 96,
                height = 100,
                numFrames = 24,
                time = 1000,
                loopDirection = "forward",
                loopCount = 0,
                start = 1
            }
        }
    },
    {
        nombre = "Harpia",
        sprite = "",        
        deathSequence = {"HACIADERECHA"},
        deathSequenceIcons = {"images/gestos/HACIADERECHA.png"},
        speed = 10000,
        animations = {
            {
                name = "hiddle",
                spriteSheet = "images/enemys/harpiaWalk.png",
                width = 112,
                height = 100,
                numFrames = 24,
                time = 1000,
                loopDirection = "forward",
                loopCount = 0,
                start = 1
            }
        }
    },
    {
        nombre = "Cascanueces",
        sprite = "",        
        deathSequence = {"HACIADERECHA"},
        deathSequenceIcons = {"images/gestos/HACIADERECHA.png"},
        speed = 10000,
        animations = {
            {
                name = "hiddle",
                spriteSheet = "images/enemys/cascanuecesWalk.png",
                width = 53,
                height = 100,
                numFrames = 24,
                time = 1000,
                loopDirection = "forward",
                loopCount = 0,
                start = 1
            }
        }
    },
    {
        nombre = "Lobizon",
        sprite = "",        
        deathSequence = {"HACIADERECHA"},
        deathSequenceIcons = {"images/gestos/HACIADERECHA.png"},
        speed = 10000,
        animations = {
            {
                name = "hiddle",
                spriteSheet = "images/enemys/lobizonWalk.png",
                width = 105,
                height = 100,
                numFrames = 24,
                time = 1000,
                loopDirection = "forward",
                loopCount = 0,
                start = 1
            }
        }
    }
}


enemysSettings.bosses = {
    {
        nombre = "Hydra",
        sprite = "",
        deathSequence = {"HACIAABAJO"},
        deathSequenceIcons = {"images/gestos/HACIAABAJO.png"},
        speed = 10000,
        animations = {
            {
                name = "hiddle",
                spriteSheet = "images/enemys/hidraWalk.png",
                width = 230,
                height = 200,
                numFrames = 24,
                time = 1000,
                loopDirection = "forward",
                loopCount = 0,
                start = 1
            }
        }
    }
}


return enemysSettings
