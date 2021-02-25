Config              = {}
Config.DrawDistance = 100.0
Config.CopsRequired = 4
Config.BlipUpdateTime = 1000 --In milliseconds. I used it on 3000. If you want instant update, 50 is more than enough. Even 100 is good. I hope it doesn't kill FPS and the server.
Config.HideRobbedCarBlip = 180000 -- en ms, tiempo que debe de pasar para que desaparezca el blip del coche robado a los polcias.
Config.CooldownMinutes = {20, 40}
Config.Locale = 'es'

Config.Zones = {
	[1] = {
		Pos   = {x = 1201.36, y = -3118.05, z = 4.54, h= 0.0},
		Size  = {x = 3.0, y = 3.0, z = 0.5},
		Color = {r = 28, g = 168, b = 0},
		VehicleSpawnPoint = {
			Pos   = {x = 1204.42, y = -3106.31, z = 5.62},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Type  = -1,
	  	},
		Type  = 27,
		Colour    = 6, --BLIP
		Id        = 229, --BLIP
	},
	[2] = {
		Pos   = {x = -796.11, y = 335.97, z = 84.7, h= 0.0},
        Size  = {x = 3.0, y = 3.0, z = 0.5},
        Color = {r = 28, g = 168, b = 0},
        VehicleSpawnPoint = {
            Pos   = {x = -800.37,  y = 332.34, z = 85.7},
            Size  = {x = 3.0, y = 3.0, z = 1.0},
            Type  = -1,
          },
		Type  = 27,
		Colour    = 6, --BLIP
		Id        = 229, --BLIP
	},
	[3] = {
		Pos   = {x = 1016.84, y = -2529.24, z = 27.3, h= 0.0},
        Size  = {x = 3.0, y = 3.0, z = 0.5},
        Color = {r = 28, g = 168, b = 0},
        VehicleSpawnPoint = {
            Pos   = {x = 1009.16,  y = -2529.73, z = 28.3, h = 355.31, },
            Size  = {x = 3.0, y = 3.0, z = 1.0},
            Type  = -1,
          },
		Type  = 27,
		Colour    = 6, --BLIP
		Id        = 229, --BLIP
	},
	[4] = {
		Pos   = {x = 371.81, y = -2417.95, z = 5.04, h= 0.0},
        Size  = {x = 3.0, y = 3.0, z = 0.5},
        Color = {r = 28, g = 168, b = 0},
        VehicleSpawnPoint = {
            Pos   = {x = 372.12,  y = -2424.01, z = 6.04, h = 170.98,},
            Size  = {x = 3.0, y = 3.0, z = 1.0},
            Type  = -1,
          },
		Type  = 27,
		Colour    = 6, --BLIP
		Id        = 229, --BLIP
	},
	[5] = {
		Pos   = {x = 137.83, y = -2473.23, z = 5, h= 0.0},
        Size  = {x = 3.0, y = 3.0, z = 0.5},
        Color = {r = 28, g = 168, b = 0},
        VehicleSpawnPoint = {
            Pos   = {x = 137.32,  y = -2477.77, z = 6, h= 234.58},
            Size  = {x = 3.0, y = 3.0, z = 1.0},
            Type  = -1,
          },
		Type  = 27,
		Colour    = 6, --BLIP
		Id        = 229, --BLIP
	},
	[6] = {
		Pos   = {x = 123.77, y = -3109.41, z = 4.98},
		Size  = {x = 3.0, y = 3.0, z = 0.5},
		Color = {r = 28, g = 168, b = 0},
		VehicleSpawnPoint = {
			Pos   = {x = 142.89, y = -3108.54, z = 5.9, h= 269.3},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Type  = -1,
	  	},
		Type  = 27,
		Colour    = 6, --BLIP
		Id        = 229, --BLIP
	},
	[7] = {
		Pos   = {x = 151.41, y = -3076.69, z = 4.9},
		Size  = {x = 3.0, y = 3.0, z = 0.5},
		Color = {r = 28, g = 168, b = 0},
		VehicleSpawnPoint = {
			Pos   = {x = 139.97, y = -3081.89, z = 5.9, h= 180.25},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Type  = -1,
	  	},
		Type  = 27,
		Colour    = 6, --BLIP
		Id        = 229, --BLIP
	},
}
	



Config.Delivery = {
	--Desert
	--Grapeseed Main Street 9.22KM
	Delivery1 = {
		Pos      = {x = 1671.44, y = 4974.78, z = 41.31},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 4200,
		Cars = {'visione','osiris','cyclone','ruston','turismor','furia','emerus','nero2','infernus2'},
	},
	--Catfish View 9.61KM
	Delivery2 = {
		Pos      = {x = 3695.58, y = 4562.26, z = 24.3},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 4550,
		Cars = {'zentorno','t20','reaper','neon','pfister811','jugular','paragon','zorrusso'},
	},
	--Paleto Boulevard 12.94KM
	Delivery3 = {
		Pos      = {x = 92.5, y = 6358.68, z = 30.38},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 5110,
		Cars = {'entityxf','nero','gp1','vagner','italigto','thrax','fmj','krieger', 'italirsx'},
	},
	--Milton Road 6KM
	Delivery4 = {
		Pos      = {x = -677.68, y = 903.15, z = 229.58},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 3710,
		Cars = {'sheava','seven70','tempesta','xa21','raiden'},
	},
	--Autopista de Los Santos 6.1KM
	 Delivery5 = {
		Pos      = {x = 1531.94, y = 1703.07, z = 108.76},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 3700,
		Cars = {'contender','f82','toros','taipan','caracara2','pariah'},
	},
	--Autopista de Del Perro 4.5KM
	 Delivery6 = {
		Pos      = {x = -1359.61, y = -756.9, z = 21.3},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 3010,
		Cars = {'sultanrs','comet5','flashgt','sc1','italigtb'},
	},
}
