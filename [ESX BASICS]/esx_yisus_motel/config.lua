Config = {}

Config.AlignMenu = "bottom-right" -- this is where the menu is located [left, right, center, top-right, top-left etc.]

Config.MotelPrice = 100 -- this is the price that you will pay when you buy the motel.
Config.HoraDeCobro = {["h"] = 12, ["m"]=00} -- Hora y minuto a la que se realiza el cobro del alquiler cada día

Config.Weapons = false -- enable this if you want weapons in the storage.
Config.DirtyMoney = false -- enable this if you want dirty money in the storage.

Config.Debug = false -- enable this only if you know what you're doing.

Config.MotelInterior = {
    ["exit"] = vector3(151.34562683105, -1007.6842041016, -98.999992370605),
    ["drawer"] = vector3(151.2417755127, -1003.018737793, -98.999992370605),
    ["wardrobe"] = vector3(151.71522521973, -1001.3452758789, -98.999977111816),
    ["invite"] = vector3(152.84375, -1007.8104248047, -99.0)
}

Config.ActionLabel = {
    ["exit"] = "salir",
    ["drawer"] = "abrir el cajón",
    ["wardrobe"] = "abrir el armario",
    ["invite"] = "para invitar"
}

Config.ReconnectSpawn = {
    ["position"] = vector3(320.54, -231.74, 54.03)
}

Config.LandLord = {
    ["Pink Cage Motel"] = {
        Key = "PinkCageMotel",
        Position = vector3(325.01959228516, -229.5560760498, 54.221176147461),
        MotelsEntrances = { -- every motel entrance, add more if you want another one.
            { roomId = 1, coords = vector3(312.96322631836, -218.5948638916, 54.221771240234)},
            { roomId = 2, coords = vector3(310.96774291992, -217.81716918945, 54.221771240234)},
            { roomId = 3, coords = vector3(307.30145263672, -216.61219787598, 54.221771240234)},
            { roomId = 4, coords = vector3(307.70816040039, -213.3956451416, 54.221771240234)},
            { roomId = 5, coords = vector3(309.65942382813, -208.16549682617, 54.221771240234)},
            { roomId = 6, coords = vector3(313.52093505859, -198.16625976563, 54.221775054932)},
            { roomId = 7, coords = vector3(315.78137207031, -194.87210083008, 54.226440429688)},
            { roomId = 8, coords = vector3(319.16732788086, -196.6743927002, 54.226455688477)},
            { roomId = 9, coords = vector3(321.14105224609, -197.32002258301, 54.226455688477)},
            { roomId = 10, coords = vector3(311.38592529297, -203.59060668945, 54.221775054932)},
            { roomId = 11, coords = vector3(312.92715454102, -218.70674133301, 58.019248962402)},
            { roomId = 12, coords = vector3(311.02416992188, -217.88179016113, 58.019248962402)},
            { roomId = 13, coords = vector3(307.35223388672, -216.50700378418, 58.01921081543)},
            { roomId = 14, coords = vector3(307.75787353516, -213.50387573242, 58.019248962402)},
            { roomId = 15, coords = vector3(309.78897094727, -208.13804626465, 58.019248962402)},
            { roomId = 16, coords = vector3(311.65594482422, -203.6040802002, 58.019248962402)},
            { roomId = 17, coords = vector3(313.45355224609, -198.26907348633, 58.019214630127)},
            { roomId = 18, coords = vector3(315.65441894531, -194.87507629395, 58.019214630127)},
            { roomId = 19, coords = vector3(319.19891357422, -196.36817932129, 58.019214630127)},
            { roomId = 20, coords = vector3(321.16479492188, -197.19439697266, 58.019218444824)},
            { roomId = 21, coords = vector3(329.38122558594, -224.86923217773, 54.22180557251)},
            { roomId = 22, coords = vector3(331.49880981445, -225.41708374023, 54.22180557251)},
            { roomId = 23, coords = vector3(335.14532470703, -227.01698303223, 54.22180557251)},
            { roomId = 24, coords = vector3(336.76617431641, -224.61317443848, 54.221809387207)},
            { roomId = 25, coords = vector3(338.63681030273, -219.24388122559, 54.221817016602)},
            { roomId = 26, coords = vector3(340.43328857422, -214.77523803711, 54.221817016602)},
            { roomId = 27, coords = vector3(342.68362426758, -209.43200683594, 54.221817016602)},
            { roomId = 28, coords = vector3(344.32986450195, -204.81706237793, 54.221809387207)},
            { roomId = 29, coords = vector3(346.38806152344, -199.60670471191, 54.221809387207)},
            { roomId = 30, coords = vector3(329.39547729492, -224.89248657227, 58.019245147705)},
            { roomId = 31, coords = vector3(331.39825439453, -225.66204833984, 58.019245147705)},
            { roomId = 32, coords = vector3(334.89376831055, -227.13185119629, 58.019245147705)},
            { roomId = 33, coords = vector3(336.84780883789, -224.65908813477, 58.019245147705)},
            { roomId = 34, coords = vector3(338.85153198242, -219.31286621094, 58.019237518311)},
            { roomId = 35, coords = vector3(340.47213745117, -214.57499694824, 58.019237518311)},
            { roomId = 36, coords = vector3(342.56774902344, -209.27154541016, 58.019237518311)},
            { roomId = 37, coords = vector3(344.37359619141, -204.82313537598, 58.019237518311)},
            { roomId = 38, coords = vector3(346.62841796875, -199.55404663086, 58.019237518311)},
        }
    },
    ["Sandy Motel"] = {
        Key = "SandyMotel",
        Position = vector3(317.18267822266, 2623.0607910156, 44.459266662598),
        MotelsEntrances = { -- every motel entrance, add more if you want another one.
            { roomId = 39, coords = vector3(341.62335205078,2614.9907226563,44.672428131104)},
            { roomId = 40, coords = vector3(347.0866394043,2618.11328125,44.672901153564)},
            { roomId = 41, coords = vector3(354.40390014648,2619.7971191406,44.672424316406)},
            { roomId = 42, coords = vector3(359.99819946289,2623.0161132813,44.67346572876)},
            { roomId = 43, coords = vector3(366.98565673828,2624.4738769531,44.672428131104)},
            { roomId = 44, coords = vector3(372.53436279297,2627.6772460938,44.673461914063)},
            { roomId = 45, coords = vector3(379.8291015625,2629.3129882813,44.672428131104)},
            { roomId = 46, coords = vector3(385.31466674805,2632.4799804688,44.673358917236)},
            { roomId = 47, coords = vector3(392.79983520508,2634.220703125,44.672424316406)},
            { roomId = 48, coords = vector3(397.873046875,2637.1252441406,44.672966003418)},
        }
    },
    ["Dream View Motel"] = {
        Key = "DreamViewMotel",
        Position = vector3(-96.573822021484,6324.4580078125,31.576183319092),
        MotelsEntrances = { -- every motel entrance, add more if you want another one.
            { roomId = 49, coords = vector3(-103.21811676025,6330.9711914063,35.500743865967)},
            { roomId = 50, coords = vector3(-106.69355010986,6334.1030273438,35.500743865967)},
            { roomId = 51, coords = vector3(-107.57382965088,6339.7744140625,35.500785827637)},
            { roomId = 52, coords = vector3(-102.24085235596,6345.1625976563,35.500785827637)},
            { roomId = 53, coords = vector3(-98.879653930664,6348.5556640625,35.500785827637)},
            { roomId = 54, coords = vector3(-93.557167053223,6353.94140625,35.500785827637)},
            { roomId = 55, coords = vector3(-90.164131164551,6357.1669921875,35.500785827637)},
            { roomId = 56, coords = vector3(-84.903434753418,6362.5205078125,35.500782012939)},
        }
    },
}

Config.HelpTextMessage = "Selecciona con ~y~&lt;- -&gt;~s~<br>~y~ENTER~s~ alquilar habitación por ($" .. Config.MotelPrice .. ")<br>ESC para cancelar"



Config.GenerateUniqueId = function()
    math.randomseed(GetGameTimer() + math.random())

    return math.random(1000000, 9999999)
end