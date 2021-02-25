Config = {}
Config.Locale = 'es'

Config.Price = 100

Config.DrawDistance = 10.0
Config.MarkerType   = 27
Config.MarkerSize   = {x = 2.5, y = 2.5, z = 1.0}
Config.MarkerColor  = {r = 76, g = 190, b = 253}
Config.Zones = {}

Config.Shops = {
	{x=72.254,    y=-1399.102, z=28.376, blip = true},
	{x=-703.776,  y=-152.258,  z=36.415, blip = true},
	{x=-167.863,  y=-298.969,  z=38.733, blip = true},
	{x=428.694,   y=-800.106,  z=28.491, blip = true},
	{x=-829.413,  y=-1073.710, z=10.328, blip = true},
	{x=-1447.797, y=-242.461,  z=48.820, blip = true},
	{x=11.632,    y=6514.224,  z=30.877, blip = true},
	{x=123.646,   y=-219.440,  z=53.557, blip = true},
	{x=1696.291,  y=4829.312,  z=41.063, blip = true},
	{x=618.093,   y=2759.629,  z=41.088, blip = true},
	{x=1190.550,  y=2713.441,  z=37.222, blip = true},
	{x=-1193.429, y=-772.262,  z=16.324, blip = true},
	{x=-3172.496, y=1048.133,  z=19.863, blip = true},
	{x=-1108.441, y=2708.923,  z=18.107, blip = true},
	{x=456.63,    y=-988.83,  z=29.69, blip = false},
	{x=-456.73,   y=6013.93, z=30.72, blip = false},
	{x=-437.85,   y= -308.34, z=33.91, blip = false},
	{x=1486.62,    y=1131.46, z=113.34, blip = false},
	{x=296.88,    y=-596.65, z=42.29, blip = false}
}

for i=1, #Config.Shops, 1 do
	Config.Zones['Shop_' .. i] = {
		Pos   = Config.Shops[i],
		Size  = Config.MarkerSize,
		Color = Config.MarkerColor,
		Type  = Config.MarkerType
	}
end
