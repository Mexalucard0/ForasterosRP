Config              = {}
Config.DrawDistance = 100
Config.Size         = {x = 1.2, y = 1.2, z = 0.2}
Config.Color        = {r = 76, g = 190, b = 253,  a = 100}
Config.Type         = 1
Config.Locale = 'es'

Config.Map = {
  --[[{name="Tequil-La La",color=27, id=93, x=-565.906, y=276.093, z=100.176},
  {name="Bahamas",color=27, id=93,x =-1388.409, y =-585.624, z =100.319},
  {name="Stripclub",color=27, id=121,x =132.17, y =-1304.42, z =100.319},
  {name="Yellow Jack",color=27, id=93,x =1992.69, y =3058.57, z =100.319},
  {name="Galaxy",color=27, id=93,x = 195.23, y = -3167.4, z = 4.82}, -- Wainting for the nightclub id blip
  ]]--
  {name="24/7",color=2, id=52,x =373.875, y =325.896, z =100.319},
  {name="24/7",color=2, id=52,x =2557.458, y =382.282, z =100.319},
  {name="24/7",color=2, id=52,x =-3038.939, y =585.954, z =6.908},
  {name="24/7",color=2, id=52,x =-3241.927, y =1001.462, z =11.830},
  {name="24/7",color=2, id=52,x =547.431, y =2671.710, z =41.156},
  {name="24/7",color=2, id=52,x =1961.464, y =3740.672, z =31.343},
  {name="24/7",color=2, id=52,x =2678.916, y =3280.671, z =54.241},
  {name="24/7",color=2, id=52,x =1730.1, y =6416.16, z =34.04},
  {name="24/7",color=2, id=52,x =25.83, y =-1347.66, z =28.5},
  {name="Licoreria",color=2, id=52,x =1135.808, y =-982.281, z =45.415},
  {name="Licoreria",color=2, id=52,x =-1222.915, y =-906.983, z =11.326},
  {name="Licoreria",color=2, id=52,x =-1487.553, y =-379.107, z =39.163},
  {name="Licoreria",color=2, id=52,x =-2968.243, y =390.910, z =14.043},
  {name="Badulaque",color=2, id=52,x = 1163.62, y =2706.14, z =37.157},
  {name="Licoreria",color=2, id=52,x =1392.562, y =3604.648, z =33.980},
  {name="24H Gasolinera",color=2, id=52,x =-48.519, y =-1757.514, z =28.421},
  {name="24H Gasolinera",color=2, id=52,x =1163.373, y =-323.801, z =68.205},
  {name="Badulaque",color=2, id=52,x =-707.501, y =-914.260, z =18.215},
  {name="24H Gasolinera",color=2, id=52,x =-1820.523, y =792.518, z =137.118},
  {name="24H Gasolinera",color=2, id=52,x =1698.388, y =4924.404, z =41.063},
  {name="24H Paleto",color=2, id=52,x =168.7, y =6638.37, z =30.71},
}

Config.Zones = {

    TwentyFourSeven = {
        --IfNotJobOnline = 'legal2',
        Items = {bread, chocolate, sandwich, hamburge, cupcake, chips, water, cocacola,  coffe, milk, cigarett },
        Pos = {
            {x = 373.875,   y = 325.896,  z = 102.566},
            {x = 2557.458,  y = 382.282,  z = 107.622},
            {x = -3038.939, y = 585.954,  z = 6.908},
            {x = -3241.927, y = 1001.462, z = 11.830},
            {x = 547.431,   y = 2671.710, z = 41.156},
            {x = 1961.464,  y = 3740.672, z = 31.343},
            {x = 2678.916,  y = 3280.671, z = 54.241},
            {x = 1729.216,  y = 6414.131, z = 34.037},
            {x = 25.83,  y = -1347.66, z = 28.5},
            {x = 168.9,  y = 6638.86, z = 30.71}
        }
    },

    RobsLiquor = {
        --IfNotJobOnline = 'banda7',
        Items = {bread, chocolate, sandwich, hamburge, cupcake, chips, water, cocacola,  coffe, milk, cigarett },
        Pos = {
            {x = 1135.808,  y = -982.281,  z = 45.415},
            {x = -1222.915, y = -906.983,  z = 11.326},
            {x = -1487.553, y = -379.107,  z = 39.163},
            {x = -2968.243, y = 390.910,   z = 14.043},
            {x = 1163.62,   y = 2706.14,     z =37.157},
            {x = 1392.562,  y = 3604.684,  z = 33.980}
        }
    },

    LTDgasoline = {
        --IfNotJobOnline = 'banda7',
        Items = {bread, chocolate, sandwich, hamburge, cupcake, chips, water, cocacola,  coffe, milk, cigarett },
        Pos = {
            {x = -48.519,   y = -1757.514, z = 28.421},
            {x = 1163.373,  y = -323.801,  z = 68.205},
            {x = -717.75,  y = -909.75,  z = 18.215},
            {x = -1820.523, y = 792.518,   z = 137.118},
            {x = 1698.388,  y = 4924.404,  z = 41.063}
        }
    },

    Bar = {
        Items = {beer, wine, vodka, tequila, whisky, gintonic, absinthe ,champagne, cigarett },
        Pos = {
        --    {x = 127.830,   y = -1284.796, z = 28.280}, --StripClub
        --    {x = -1381.95, y = -632.9,  z = 29.82}, --Bahamamas
        --    {x = -563.34,  y = 286.1,   z = 84.38}, --Tequila la
        --    {x = 1986.18,   y = 3054.31,   z = 46.32}
        }
    },
  
    Disco = {
        Items = {beer, wine, vodka, tequila, whisky, cigarett},
        Pos = {
        --    {x = -1586.922,   y = -3012.860, z = -77.004}, --Upstairs
	    --    {x = -1578.204,   y = -3014.460, z = -80.005}  --Downstairs
        }
    },

    MoleCorp = {
        Items = {laptop_h},
        Pos = {
            {x = -627.68762207031,   y = -278.75204467773, z = 34.577480316162}, --MoleCorp Shop Joyeria 35.577480316162
        }
    },
    
    Federal = {
        Items = {bread, water},
        Pos = {
            {x = 1779.6766357422, y = 2589.5988769531, z = 44.897977447514}
        }
    }
}
