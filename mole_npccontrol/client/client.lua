local removeCops = true
local controlPopulation = true
local disableWeaponDrops = true
local disableWantedLevel = true
local fixOnesyncPedNotMove = false
local clearAreasOfPeds = true
local groupRelationship = true

local onesync_enableInfinity = GetConvar('onesync_enableInfinity', "false") == "true"
if(onesync_enableInfinity)then
print('npccontrol onesync_enableInfinity enabled')
end
MSX = nil
xPlayerData = nil
myStats = {}
myStatsPending = {}
myStrengthModifier = 1
Citizen.CreateThread(
    function()
        while MSX == nil do
            TriggerEvent(
                "msx:getSharedObject",
                function(obj)
                    MSX = obj
                end
            )
            Citizen.Wait(10)
        end
        xPlayerData = MSX.GetPlayerData()
        MSX.TriggerServerCallback('msx:getPlayerStats', function(stats)
			myStats = stats
			setStrenghtModifier(myStats)
        end)
    end
)
RegisterNetEvent('msx:onPlayerStatsChanged')
AddEventHandler('msx:onPlayerStatsChanged', function(stats, statsPending)
    myStats = stats	
	myStatsPending = statsPending
	setStrenghtModifier(myStats)
end)
function setStrenghtModifier(myStats)
	if(myStats ~= nil and myStats.strength ~= nil)then
		myStrengthModifier = 1 + (myStats.strength / 500)
	end
end

Citizen.CreateThread(function()
	--trenes
	--SwitchTrainTrack(0, true)
	--SwitchTrainTrack(3, true)
	--N_0x21973bbf8d17edfa(0, 120000)
	--SetRandomTrains(true)

	
	while removeCops do
		Citizen.Wait(1000)
		local playerPed = GetPlayerPed(-1)
		local playerLocalisation = GetEntityCoords(playerPed)
		ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
	end
end)

local clearAreas = {}
Citizen.CreateThread(function()
	local area = 50.0
	local coords = { 
		vector3(-2203.8056640625,3144.7922363281,32.810153961182),--	base militar
		vector3(-1879.8515625,2063.3408203125,140.9842376709),-- viñedo
		vector3(-625.84436035156,234.16148376465,81.88159942627),-- italiano
		vector3(1856.10,3679.10,33.7), --comisaria sandy
		vector3(440.84,-983.14, 30.69), --comisaria
		vector3(505.09, -3143.03, 5.07), --atlas security
		vector3(483.49, -3113.86, 5.31), --atlas security1
		vector3(536.65, -3117.58, 12.68), --atlas security2
		vector3(493.66, -3221.06, 5.07), --atlas security3
		vector3(477.15, -3264.56, 5.07), --atlas security4
		vector3(473.48, -3191.81, 6.07), --atlas security4
		vector3(490.34, -3118.96, 6.07), --atlas security4
		vector3(-1389.79, -615.78, 30.82), --bahamas
	}
	while clearAreasOfPeds do
		Citizen.Wait(2000)
		clearAreas = {}
		for _,coord in pairs(coords)do
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), coord, true ) < area then
				table.insert(clearAreas, coord)
			end
		end
	end
end)
Citizen.CreateThread(function()
	local area = 50.0
	while clearAreasOfPeds do
		if(#clearAreas > 0)then
			Citizen.Wait(100)
			for k,coords in pairs(clearAreas) do
				ClearAreaOfPeds(coords, area, 1)
				RemoveVehiclesFromGeneratorsInArea(coords.x -area, coords.y -area, coords.z -15, coords.x +area, coords.y +area , coords.z +15)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
	--[[
    DT_PoliceAutomobile = 1,  
    DT_PoliceHelicopter = 2,  
    DT_FireDepartment = 3,  
    DT_SwatAutomobile = 4,  
    DT_AmbulanceDepartment = 5,  
    DT_PoliceRiders = 6,  
    DT_PoliceVehicleRequest = 7,  
    DT_PoliceRoadBlock = 8,  
    DT_PoliceAutomobileWaitPulledOver = 9,  
    DT_PoliceAutomobileWaitCruising = 10,  
    DT_Gangs = 11,  
    DT_SwatHelicopter = 12,  
    DT_PoliceBoat = 13,  
    DT_ArmyVehicle = 14,  
    DT_BikerBackup = 15  
]]--
	for i = 1, 15 do
		EnableDispatchService(i, false)
	end
	while controlPopulation do
		DisablePlayerVehicleRewards(PlayerId())
		SetVehicleDensityMultiplierThisFrame(0.8)
		SetParkedVehicleDensityMultiplierThisFrame(0.1)
		Citizen.Wait(1)
	end
end)

Citizen.CreateThread(function()
    while disableWeaponDrops do
        Citizen.Wait(1000)
        Citizen.CreateThread(function()
			local handle, ped = FindFirstPed()
			local finished = false 
		
			repeat 
				if not IsEntityDead(ped) then
					SetPedDropsWeaponsWhenDead(ped, false) 
				end
				finished, ped = FindNextPed(handle)
			until not finished
		
			EndFindPed(handle)
		end)
    end
end)

Citizen.CreateThread(function()
	SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 0.28 * myStrengthModifier)--inconsciente de 8
	SetWeaponDamageModifier(GetHashKey("WEAPON_NIGHTSTICK"), 0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_BAT"), 0.45)--mata de 3
	SetWeaponDamageModifier(GetHashKey("WEAPON_GOLFCLUB"), 0.45)
	SetWeaponDamageModifier(GetHashKey("WEAPON_CROWBAR"), 0.45)--mata de 3
	SetWeaponDamageModifier(GetHashKey("WEAPON_HAMMER"), 0.5)--mata de 3
	SetWeaponDamageModifier(GetHashKey("WEAPON_FLASHLIGHT"), 0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_WRENCH"), 0.5)--mata de 3
	SetWeaponDamageModifier(GetHashKey("WEAPON_KNIFE"), 1.0)
	SetWeaponDamageModifier(GetHashKey("WEAPON_SWITCHBLADE"), 1.0)
	SetWeaponDamageModifier(GetHashKey("WEAPON_HATCHET"), 1.0)
	SetWeaponDamageModifier(GetHashKey("WEAPON_FIREEXTINGUISHER"), 0.0)
	SetWeaponDamageModifier(GetHashKey("WEAPON_SNOWBALL"), 0.0)
	SetWeaponDamageModifier(GetHashKey("WEAPON_KNUCKLE"), 0.3)--mata de 
	SetWeaponDamageModifier(GetHashKey("WEAPON_PISTOL"), 0.75)--mata de 6
	SetWeaponDamageModifier(GetHashKey("WEAPON_HEAVYPISTOL"), 0.63)--mata de 4
	SetWeaponDamageModifier(GetHashKey("WEAPON_PISTOL50"), 0.72)--mata de 3	
	SetWeaponDamageModifier(GetHashKey("WEAPON_SAWNOFFSHOTGUN"), 1.3)--mata de 2
	SetWeaponDamageModifier(GetHashKey("WEAPON_PUMPSHOTGUN"), 2.0)--mata de 2	
	SetWeaponDamageModifier(GetHashKey("WEAPON_COMBATPDW"), 0.8)--mata de 5
	SetWeaponDamageModifier(GetHashKey("WEAPON_ASSAULTRIFLE"), 1.0)--mata de 4
	SetWeaponDamageModifier(GetHashKey("WEAPON_COMPACTRIFLE"), 0.85)--mata de 4
	SetWeaponDamageModifier(GetHashKey("WEAPON_MICROSMG"), 1.0)--mata de 5
	SetWeaponDamageModifier(GetHashKey("WEAPON_SNSPISTOL"), 0.6)--mata de 7
--mk2
    SetWeaponDamageModifier(GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), 0.8)--mata de 4
    SetWeaponDamageModifier(GetHashKey("WEAPON_SNSPISTOL_MK2"), 0.6)--mata de 6
    SetWeaponDamageModifier(GetHashKey("WEAPON_SNSPISTOL_MK2"), 0.6)--mata de 6


end)


Citizen.CreateThread(function()
	while disableWantedLevel do
		Wait(1000)
		local playerId = PlayerId()
        local wantedLevel = GetPlayerWantedLevel(playerId)
        if wantedLevel ~= 0 then
		    SetPlayerWantedLevel(playerId, 0, false)
		    SetPlayerWantedLevelNow(playerId, false)
            SetPlayerWantedLevelNoDrop(playerId, 0, false)
        end
	end
end)

local relationshipTypes = {
	'GANG_1',
	'GANG_2',
	'GANG_9',
	'GANG_10',
	'AMBIENT_GANG_LOST',
	'AMBIENT_GANG_MEXICAN',
	'AMBIENT_GANG_FAMILY',
	'AMBIENT_GANG_BALLAS',
	'AMBIENT_GANG_MARABUNTE',
	'AMBIENT_GANG_CULT',
	'AMBIENT_GANG_SALVA',
	'AMBIENT_GANG_WEICHENG',
	'AMBIENT_GANG_HILLBILLY',
	'DEALER',
	--'COP',
	'PRIVATE_SECURITY',
	'SECURITY_GUARD',
	'ARMY',
	'MEDIC',
	'FIREMAN',
	'HATES_PLAYER',
	'NO_RELATIONSHIP',
	'SPECIAL',
	'MISSION2',
	'MISSION3',
	'MISSION4',
	'MISSION5',
	'MISSION6',
	'MISSION7',
	'MISSION8'
}

Citizen.CreateThread(function()
	while groupRelationship do
		Citizen.Wait(5000)
		for _, group in ipairs(relationshipTypes) do
			SetRelationshipBetweenGroups(1, GetHashKey('PLAYER'), GetHashKey(group)) -- could be removed
			SetRelationshipBetweenGroups(1, GetHashKey(group), GetHashKey('PLAYER'))
		end
	end
end)

local debugLog = false
function DebugLog(msg)
	if(debugLog == true)then
		print(msg)
	end
end

RegisterCommand(
	"pedstatus",
	function(source, args, rawCommand)
		print('buscando ped')
		local count = 0
		local player = GetPlayerPed(-1)
		local playerloc = GetEntityCoords(player, 0)
		local handle, ped = FindFirstPed()
		repeat
			success, ped = FindNextPed(handle)
			local pos = GetEntityCoords(ped)
			local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
			if DoesEntityExist(ped)then
				if IsPedAPlayer(ped) == false and ped  ~= GetPlayerPed(-1) then
						if(not IsPedInAnyVehicle(ped) and IsPedStopped(ped))then
							print('Found IA ped ' .. ped)
							if(DecorExistOn(ped, 'MRFIAENTITY')) then
								print('IA ped is MRF.IA')
							else
								print('IA ped is native')
							end
							print('Ped is Still ' .. pos ..  ' distance ' .. distance)
							count = count +1
						--	ClearPedTasksImmediately(ped)
						--	TaskWanderStandard(ped, true, true)
						end
					
				end
			end
		until not success
		EndFindPed(handle)
		print('fin buscando ped, encontrados quietos ' .. count)
	end,
	false
)
local stopedPeds = {}
Citizen.CreateThread(function()
	local player = GetPlayerPed(-1)
	
	while fixOnesyncPedNotMove do
		local player = GetPlayerPed(-1)
		local playerloc = GetEntityCoords(player, 0)
		local handle, ped = FindFirstPed()
		repeat
			Wait(100)
			success, ped = FindNextPed(handle)
			local pos = GetEntityCoords(ped)
			local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
			if DoesEntityExist(ped)then
				if IsPedAPlayer(ped) == false and ped  ~= GetPlayerPed(-1) and IsPedHuman(ped) then
					if(distance < 100) then
						if(not IsPedInAnyVehicle(ped) and not IsPedSittingInAnyVehicle(ped) and IsPedStopped(ped) and IsPedOnFoot(ped))then
							local isMRF = 'Native'
							local noAnim = false
							if(DecorExistOn(ped, 'MRFIAENTITY')) then
								isMRF = 'MRF.IA'
							end
							if(DecorExistOn(ped, 'MRFIANOANIM')) then
								noAnim = true
							end
							if(IsPedDeadOrDying(ped))then
								DebugLog(isMRF ..'Ped is dead ' .. ped  .. ' ' .. pos ..  ' distance ' .. distance)
							--	SetEntityAsNoLongerNeeded(ped)
							--	DeleteEntity(ped)
							elseif(noAnim == false) then
								DebugLog(isMRF ..'Ped is stoped ' .. ped  .. ' ' .. pos ..  ' distance ' .. distance)
								ClearPedTasksImmediately(ped)
								TaskWanderStandard(ped, true, true)
								if(stopedPeds[ped] ~= nil)then
									stopedPeds[ped] = stopedPeds[ped] +1
									if(stopedPeds[ped] == 3)then
										DebugLog(isMRF ..'Ped is locked, removing ' .. ped  .. ' ' .. pos ..  ' distance ' .. distance)
						--				SetEntityAsNoLongerNeeded(ped)
						--				DeleteEntity(ped)
										stopedPeds[ped] = nil
									end
								else
									stopedPeds[ped] = 0
								end
							end
						else
							if(stopedPeds[ped] ~= nil)then
								stopedPeds[ped] = nil
							end
						end
					else
						if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 0.0,0.0,0.0, true) < 1)then
					--		DebugLog('Delete OOB ped')
					--		SetEntityAsNoLongerNeeded(ped)
						end
					end
				end
			end
		until not success
		EndFindPed(handle)
		Wait(5000)
	
	end
end)
