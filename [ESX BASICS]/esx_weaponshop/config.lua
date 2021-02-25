Config                			= {}
Config.DrawDistance   			= 5
Config.Size           			= { x = 1.2, y = 1.2, z = 0.1 }
Config.Color          			= {r = 76, g = 190, b = 253,  a = 100}
Config.Type           			= 27
Config.Locale         			= 'es'
Config.EnableLicense  			= false
Config.LicensePrice   			= 15000
Config.EnableClipGunShop		= false
Config.EnableClipBlackWeashop	= false

Config.EnableClip = {
	GunShop = {
		Price = 700,
		Label = "Cargador"	
	},
	BlackWeashop = {
		Price = 700,
		Label = "Cargador"	
	}
}

Config.Zones = {

    GunShop = {
        legal = 0,
        Items = {
            {  name  = 'WEAPON_BALL', price = 10 },
            {  name  = 'WEAPON_FLASHLIGHT', price = 500 },
            {  name  = 'WEAPON_GOLFCLUB', price = 1000 },
            {  name  = 'WEAPON_BAT', price = 1500 },
            {  name  = 'WEAPON_KNUCKLE', price = 2000 },
            {  name  = 'WEAPON_KNIFE', price = 3000 },
    
        },
        Pos   = {
            { x = -662.180,   y = -934.961,   z = 20.829 },
            { x = 810.25,     y = -2157.60,   z = 28.62 },
            { x = 1693.44,    y = 3760.16,    z = 33.71 },
            { x = -330.24,    y = 6083.88,    z = 30.45 },
            { x = 252.63,     y = -50.00,     z = 68.94 },
            { x = 22.09,      y = -1107.28,   z = 28.80 },
            { x = 2567.69,    y = 294.38,     z = 107.73 },
            { x = -1117.58,   y = 2698.61,    z = 17.55 },
            { x = 842.44,     y = -1033.42,   z = 27.19 },

        }
    },

    BlackWeashop = {
        legal = 1,
        Items = {},
        Pos   = {
            { x = -1306.239,   y = -394.018,  z = 35.695 },
        }
    },

}
