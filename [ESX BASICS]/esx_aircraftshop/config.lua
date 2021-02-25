Config = {}
Config.Locale = 'es'

Config.DrawDistance = 10.0
Config.MarkerColor  = {r = 76, g = 190, b = 253,  a = 100}

Config.EnableOwnedVehicles = true -- If true then it will set the Vehicle Owner to the Player who bought it.
Config.ResellPercentage    = 0 -- Sets the Resell Percentage | Example: $100 Car will resell for $75
Config.LicenseEnable       = true -- Require people to own a Aircraft License when buying Vehicles? Requires esx_license
Config.LicensePrice        = 2000000 -- Sets the License Price if Config.LicenseEnable is true

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {
	ShopEntering = { -- Marker for Accessing Shop
		Pos   = { x = -940.06, y = -2963.15, z = 18.85 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 27
	},
	ShopInside = { -- Marker for Viewing Vehicles
		Pos     = { x = -1874.76, y = -3137.59, z = 14.94 }, -- { x = -1075.01, y = -2933.22, z = 14.55 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 333.95, -- 59.9
		Type    = -1
	},
	ShopOutside = { -- Marker for Purchasing Vehicles
		Pos     = { x = -965.25, y = -2983.56, z = 14.55 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 59.9,
		Type    = -1
	}	
}
