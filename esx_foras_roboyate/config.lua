Config = {}

Config.Yacht = {
    [1] = { 
		loc = {-2072.4143066406,-1020.1676025391,5.8841509819031},
		blipName = "Yate",
		blipSprite = 455,
		blipColor = 5,
		blipScale = 0.8,
		recentlyRobbed = false,
		startPos = {-2031.47,-1037.98,2.56},
		started = false,
		keypad = {-2070.0031738281,-1019.9599804688,5.8841547966003},
		keypadHacked = false,
		currentlyHacking = false,
		vaultDoor = {-2069.3786621094,-1019.3640136719,5.8841371536255},
		vaultLocked = true,
		vaultModel = -2050208642,
		safe = {-2067.7509765625,-1018.80,5.8820877075195},
		safeRobbed = false,
		drilling = false,
		trolleyPos = {-2069.4367675781,-1021.3533325195,5.8819766044617,75.73348236084},
		cashTaken = false,
		stealing = false,
		JobPlayer = false,
		GoonsSpawned = false,
		Goons = {
			NPC1 = { x = -2077.05, y = -1021.92, z = 5.88, h = 307.71, ped = 'G_M_Y_Lost_02', animDict = 'amb@world_human_cop_idles@female@base', animName = 'base', weapon = 'WEAPON_PISTOL', },
			NPC2 = { x = -2077.48, y = -1016.60, z = 5.88, h = 243.91, ped = 'G_M_Y_MexGang_01', animDict = 'rcmme_amanda1', animName = 'stand_loop_cop', weapon = 'WEAPON_PISTOL', },
			NPC3 = { x = -2071.25, y = -1020.63, z = 5.88, h = 5.57, ped = 'G_M_Y_SalvaBoss_01', animDict = 'amb@world_human_leaning@male@wall@back@legs_crossed@base', animName = 'base', weapon = 'WEAPON_PISTOL' },
			NPC4 = { x = -2071.25, y = -1020.63, z = 5.88, h = 5.57, ped = 'G_M_Y_SalvaBoss_01', animDict = 'amb@world_human_leaning@male@wall@back@legs_crossed@base', animName = 'base', weapon = 'WEAPON_PISTOL' },
		}
	},
}

Config.PoliceDBname = "police"				-- name for policejob in database
Config.RequiredPolice = 8 					-- required police online for starting heist
Config.EnablePlayerMoneyBag = true			-- enable/disable wearing a bag after cash animation
Config.CooldownTimer = 240					-- in minutes

Config.HackerDevice = "phone"		-- database name for hacking item
Config.DrillItem = "drill"					-- database name for drill item

-- Reward Settings:
Config.RewardBasedOnCops = false	-- enable or disable rewards based on police online
Config.SafeBoxItem = "thermal_charge"	-- database name for item in safe
Config.CashTake = math.random(3500,4500)			-- min cash to give (fajo total :45)
Config.SafeMinCash = 18000			-- min cash to give
Config.SafeMaxCash = 20000			-- max cash to give
Config.SafeMinItem = 1				-- min item to give
Config.SafeMaxItem = 4				-- max item to give
