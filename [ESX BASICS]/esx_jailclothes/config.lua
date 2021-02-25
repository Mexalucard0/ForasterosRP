Config = {}
Config.Locale = 'es'

Config.DrawDistance = 10.0
Config.MarkerType   = 27
Config.MarkerSize   = {x = 1.2, y = 1.2, z = 1.2}
Config.MarkerColor  = {r = 76, g = 190, b = 253}
Config.Zones = {}

Config.Shops = {
	{x = 1831.6568603516, y = 2584.7822265625, z = 45.052320098877}
}

for i=1, #Config.Shops, 1 do
	Config.Zones['Shop_' .. i] = {
		Pos   = Config.Shops[i],
		Size  = Config.MarkerSize,
		Color = Config.MarkerColor,
		Type  = Config.MarkerType
	}
end
