Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = {r = 76, g = 190, b = 253,  a = 100}
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 0

Config.Locale = 'es'

Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlatePrefixNumbers  = 3
Config.PlateLetters  = 3
Config.PlateSuffixNumbers  = 2

Config.PlateUseSpace = false

Config.Zones = {
	['Concesionario Sur'] = {
		DbKey = 'sur',
		Label = 'Concesionario Sur',
		IsVip = false,
		Points = {
			ShopEntering = {
				Pos   = { x = -33.45, y = -1102.1, z = 25.42 },
				Size  = { x = 1.5, y = 1.5, z = 0.3 },
				Type  = 27
			},
			ShopInside = {
				Pos     = { x = -44.21, y = -1098.3, z = 25.42 },
				Size    = { x = 1.5, y = 1.5, z = 1.0 },
				Heading = 116.39,
				Type    = -1
			},
			ShopOutside = {
				Pos     = { x = -52.31, y = -1110.27, z = 25.44  },
				Size    = { x = 1.5, y = 1.5, z = 1.0 },
				Heading = 69.48,
				Type    = -1
			}
		}
	},
	['Concesionario Vip'] = {
		DbKey = 'vip',
		Label = 'Concesionario Vip',
		IsVip = true,
		Points = {
			ShopEntering = {
				Pos   = { x = -795.91, y = -221.46, z = 36.08 },
				Size  = { x = 1.5, y = 1.5, z = 0.3 },
				Type  = 27
			},
			ShopInside = {
				Pos     = { x = -783.56, y = -223.77, z = 36.32 },
				Size    = { x = 1.5, y = 1.5, z = 1.0 },
				Heading = 134.86,
				Type    = -1
			},
			ShopOutside = {
				Pos     = { x = -770.23, y = -231.31, z = 37.08  },
				Size    = { x = 1.5, y = 1.5, z = 1.0 },
				Heading = 205.59,
				Type    = -1
			}
		}
	},
	['Concesionario Norte'] = {
		DbKey = 'norte',
		Label = 'Concesionario Norte',
		IsVip = false,
		Points = {
			ShopEntering = {
				Pos   = { x = 2511.91, y = 4109.19, z = 37.58 },
				Size  = { x = 1.5, y = 1.5, z = 0.3 },
				Type  = 27
			},
			ShopInside = {
				Pos     = { x = 2501.03, y =  4080.55, z = 38.61 },
				Size    = { x = 1.5, y = 1.5, z = 1.0 },
				Heading = 66.75,
				Type    = -1
			},
			ShopOutside = {
				Pos     = { x = 2464.76, y = 4073.83, z = 38.06  },
				Size    = { x = 1.5, y = 1.5, z = 1.0 },
				Heading = 244.39,
				Type    = -1
			}
		}
	}
}