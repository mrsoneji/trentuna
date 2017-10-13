local levelsSettings = {}
levelsSettings.__index = levelsSettings

levelsSettings.mapItems = {
    {
        imagen = "images/mapa/bosque.png",
        imagenOscura = "images/mapa/bosqueOscuro.png",
        x = 100, 
        y = 90
    },
    {
        imagen = "images/mapa/montana.png",
        imagenOscura = "images/mapa/montanaOscura.png",
        x = 150,
        y = display.contentHeight - 70
    },
    {
        imagen = "images/mapa/lago.png",
        imagenOscura = "images/mapa/lagoOscuro.png",
        x = 300,
        y = 50
    },
    {
        imagen = "images/mapa/bosquemuerto.png",
        imagenOscura = "images/mapa/bosquemuertoOscuro.png",
        x = 350,
        y = display.contentHeight - 50,
    },
    {
        imagen = "images/mapa/castillo.png",
        imagenOscura = "images/mapa/castilloOscuro.png",
        x = display.contentWidth - 60,
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
                10, 10,10,10,10,10, 9,9,9,9, 2, 3, 4, 5, 9,
                7, 8, 9, 2, 8, 6,
                3, 7, 2, 8, 9, 6,
                2, 3, 4, 4, 7
            },
            {--wave 2
                1, 1, 1, 1, 1,
                2, 1, 2, 2, 1,
                3, 1, 2, 3, 1,
                2, 3, 4, 4, 4
            },
            {--wave 3
                1, 1, 1, 1, 1,
                2, 1, 2, 2, 1,
                3, 1, 2, 3, 1,
                2, 3, 4, 4, 4
            }
        }
    },
    {--level 2
        mapItems = levelsSettings.mapItems[2],
        fondo = levelsSettings.fondos[2],
        enemySecuences = {
            {--wave 1
                1, 2, 3, 4, 5, 6,
                2, 1, 2, 2, 1, 6,
                3, 1, 2, 3, 1, 6,
                2, 3, 4, 4, 4
            },
            {--wave 2
                1, 1, 1, 1, 1,
                2, 1, 2, 2, 1,
                3, 1, 2, 3, 1,
                2, 3, 4, 4, 4
            },
            {--wave 3
                1, 1, 1, 1, 1,
                2, 1, 2, 2, 1,
                3, 1, 2, 3, 1,
                2, 3, 4, 4, 4
            }
        }
    },
    {--level 3
        mapItems = levelsSettings.mapItems[3],
        fondo = levelsSettings.fondos[3],
        enemySecuences = {
            {
                4
            }
        }
    },
    {--level 4
        mapItems = levelsSettings.mapItems[4],
        fondo = levelsSettings.fondos[4],
        enemySecuences = {
            {
                4
            }
        }
    },
    {--level 5
        mapItems = levelsSettings.mapItems[5],
        fondo = levelsSettings.fondos[5],
        enemySecuences = {
            {
                4
            }
        }
    }
}

return levelsSettings
