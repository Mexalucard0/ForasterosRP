Config               = {}

Config.Locale = 'es'

Config.LicenseEnable = true -- enable boat license? Requires esx_license
Config.LicensePrice  = 6500

Config.MarkerType    = 1
Config.DrawDistance  = 100.0

Config.Marker = {
	r = 100, g = 204, b = 100, -- blue-ish color
	x = 1.5, y = 1.5, z = 1.0  -- standard size circle
}

Config.StoreMarker = {
	r = 255, g = 0, b = 0,     -- red color
	x = 5.0, y = 5.0, z = 1.0  -- big circle for storing boat
}


Config.Zones = {

	Garages = {

		{ -- Shank St, nearby campaign boat garage
			GaragePos  = vector3(-772.4, -1430.9, 0.5),
			SpawnPoint = vector4(-785.39, -1426.3, 0.0, 146.0),
			StorePos   = vector3(-798.4, -1456.0, 0.0),
			StoreTP    = vector4(-791.4, -1452.5, 1.5, 318.9)
		},
		{ -- Faro
		GaragePos  = vector3(3372.99, 5183.64, 0.46),
		SpawnPoint = vector4(3385.04,5195.96, 0.0, 308.14),
		StorePos   = vector3(3369.71,5192.8,0),
		StoreTP    = vector4(3372.99, 5183.64, 0.46, 87.14)
	},
	--[[	{ -- Catfish View
			GaragePos  = vector3(3864.9, 4463.9, 1.6),
			SpawnPoint = vector4(3854.4, 4477.2, 0.0, 273.0),
			StorePos   = vector3(3857.0, 4446.9, 0.0),
			StoreTP    = vector4(3854.7, 4458.6, 1.8, 355.3)
		},
]]--
		{ -- Great Ocean Highway
			GaragePos  = vector3(-1614.0, 5260.1, 2.8),
			SpawnPoint = vector4(-1622.5, 5247.1, 0.0, 21.0),
			StorePos   = vector3(-1600.3, 5261.9, 0.0),
			StoreTP    = vector4(-1605.7, 5259.0, 2.0, 25.0)
		},

		{ -- North Calafia Way
			GaragePos  = vector3(712.6, 4093.3, 33.7),
			SpawnPoint = vector4(712.8, 4080.2, 29.3, 181.0),
			StorePos   = vector3(705.1, 4110.1, 30.2),
			StoreTP    = vector4(711.9, 4110.5, 31.3, 180.0)
		},

		{ -- Elysian Fields, nearby the airport
			GaragePos  = vector3(23.8, -2806.8, 4.8),
			SpawnPoint = vector4(23.3, -2828.6, 0.8, 181.0),
			StorePos   = vector3(-1.0, -2799.2, 0.5),
			StoreTP    = vector4(12.6, -2793.8, 2.5, 355.2)
		},

		{ -- Barbareno Rd
			GaragePos  = vector3(-3414.75, 953.13, 7.3),
			SpawnPoint = vector4(-3448.9, 953.8, 0.0, 75.0),
			StorePos   = vector3(-3436.5, 946.6, 0.3),
			StoreTP    = vector4(-3427.0, 952.6, 8.3, 0.0)
		},

	},

	BoatShops = {

		{ -- Shank St, nearby campaign boat garage
			Outside = vector3(-773.7, -1495.2, 1.6),
			Inside = vector4(-798.5, -1503.1, -0.4, 120.0)
		}

	}

}

Config.Vehicles = {
	{model = 'seashark', label = 'Seashark', price = 12500},
	{model = 'seashark3', label = 'Seashark 3', price = 16500},
	{model = 'dinghy', label = 'Dinghy', price = 35000},
	{model = 'dinghy2', label = 'Dinghy 2', price = 30000},
	{model = 'dinghy3', label = 'Dinghy 3', price = 35000},
	{model = 'dinghy4', label = 'Dinghy 4', price = 35000},
	{model = 'suntrap', label = 'Suntrap', price = 40000},
	{model = 'jetmax', label = 'Jetmax', price = 45000},
	{model = 'toro', label = 'Toro', price = 50000},
	{model = 'toro2', label = 'Toro 2', price = 55000},
	{model = 'speeder', label = 'Speeder', price = 60000},
	{model = 'speeder2', label = 'Speeder 2', price = 65000},
	{model = 'squalo', label = 'Squalo', price = 55000},
	{model = 'tropic', label = 'Tropic', price = 58000},
	{model = 'tropi2c', label = 'Tropic 2', price = 59000},
	{model = 'marquis', label = 'Velero', price = 280000},
	{model = 'submersible', label = 'Submersible', price = 350000},
	{model = 'submersible2', label = 'Submersible 2', price = 350000},
}