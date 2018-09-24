local levelsSettings = {}
levelsSettings.__index = levelsSettings

levelsSettings.mapItems = {
    {
        imagen = "images/mapa/bosque.png",
        imagenOscura = "images/mapa/bosqueOscuro.png",
        x = 150, 
        y = 90
    },
    {
        imagen = "images/mapa/lago.png",
        imagenOscura = "images/mapa/lagoOscuro.png",
        x = 350,
        y = 70
    },
    {
        imagen = "images/mapa/montana.png",
        imagenOscura = "images/mapa/montanaOscura.png",
        x = 150,
        y = display.contentHeight - 100
    },
    {
        imagen = "images/mapa/bosquemuerto.png",
        imagenOscura = "images/mapa/bosquemuertoOscuro.png",
        x = 320,
        y = display.contentHeight - 70,
    },
    {
        imagen = "images/mapa/castillo.png",
        imagenOscura = "images/mapa/castilloOscuro.png",
        x = display.contentWidth - 100,
        y = display.contentCenterY
    },
}

levelsSettings.fondos = {
    {
        imagen = "images/scenarios/luminoso3.jpg",
        x = 300,
        y = -130
    },
    {
        imagen = "images/scenarios/olas1.jpg",
        x = 300,
        y = -130
    },
    {
        imagen = "images/scenarios/luminoso6.jpg",
        x = 300,
        y = -130
    },
    {
        imagen = "images/scenarios/oscuro1.jpg",
        x = 300,
        y = -130
    },
    {
        imagen = "images/scenarios/fuego1.jpg",
        x = 300,
        y = -130
    }
}
levelsSettings.levels = {
    {   --level 1
        mapItems = levelsSettings.mapItems[1],
        fondo = levelsSettings.fondos[1],
        enemySecuences = {
            {--wave 1
                1, 2, 3, 4, 5,
                6, 7, 8, 9, 1,
                1, 2, 3, 4, 5,
                6, 7, 8, 9
            },
            {--wave 1
                1, 1, 1, 1, 1,
                1, 1, 1, 1, 1,
                1, 1, 1, 1, 1,
                1, 1, 1, 1, 1
            },
            {--wave 2
                1, 1, 1, 1, 1,
                2, 1, 2, 1, 2,
                2, 1, 2, 1, 2,
                2, 2, 2, 2, 2
            },
            {--wave 3
                1, 2, 1, 2, 1,
                2, 1, 2, 1, 2,
                3, 1, 2, 3, 1,
                2, 3, 2, 3, 1
            }
        }
    },
    {--level 2
        mapItems = levelsSettings.mapItems[2],
        fondo = levelsSettings.fondos[2],
        enemySecuences = {
            {--wave 1
                1, 2, 3, 4, 1,
                2, 4, 2, 4, 1,
                3, 1, 4, 3, 1,
                2, 3, 4, 4, 4
            },
            {--wave 2
                1, 4, 1, 4, 1,
                2, 3, 2, 3, 1,
                3, 1, 4, 3, 4,
                2, 3, 4, 4, 4
            },
            {--wave 3
                1, 1, 2, 1, 1,
                2, 1, 4, 2, 1,
                3, 4, 2, 4, 1,
                2, 3, 1, 4, 4
            }
        }
    },
    {--level 3
        mapItems = levelsSettings.mapItems[3],
        fondo = levelsSettings.fondos[3],
        enemySecuences = {
            {--wave 1
                1, 2, 3, 4, 1,
                2, 4, 2, 4, 1,
                3, 1, 4, 3, 1,
                2, 3, 4, 4, 4
            },
            {--wave 2
                1, 4, 1, 4, 1,
                2, 3, 2, 3, 1,
                3, 1, 4, 3, 4,
                2, 3, 4, 4, 4
            },
            {--wave 3
                1, 1, 2, 1, 1,
                2, 1, 4, 2, 1,
                3, 4, 2, 4, 1,
                2, 3, 1, 4, 4
            }
        }
    },
    {--level 4
        mapItems = levelsSettings.mapItems[4],
        fondo = levelsSettings.fondos[4],
        enemySecuences = {
            {--wave 1
                1, 2, 3, 4, 1,
                2, 4, 2, 4, 1,
                3, 1, 4, 3, 1,
                2, 3, 4, 4, 4
            },
            {--wave 2
                1, 4, 1, 4, 1,
                2, 3, 2, 3, 1,
                3, 1, 4, 3, 4,
                2, 3, 4, 4, 4
            },
            {--wave 3
                1, 1, 2, 1, 1,
                2, 1, 4, 2, 1,
                3, 4, 2, 4, 1,
                2, 3, 1, 4, 4
            }
        }
    },
    {--level 5
        mapItems = levelsSettings.mapItems[5],
        fondo = levelsSettings.fondos[5],
        enemySecuences = {
            {--wave 1
                1, 2, 3, 4, 1,
                2, 4, 2, 4, 1,
                3, 1, 4, 3, 1,
                2, 3, 4, 4, 4
            },
            {--wave 2
                1, 4, 1, 4, 1,
                2, 3, 2, 3, 1,
                3, 1, 4, 3, 4,
                2, 3, 4, 4, 4
            },
            {--wave 3
                1, 1, 2, 1, 1,
                2, 1, 4, 2, 1,
                3, 4, 2, 4, 1,
                2, 3, 1, 4, 4
            }
        }
    }
}

return levelsSettings
