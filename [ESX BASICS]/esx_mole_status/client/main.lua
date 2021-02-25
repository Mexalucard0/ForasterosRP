ESX                           = nil

local xPlayerData                = {}

armourSet = false
isStressed = false
wasStressed = false
myStats = {}
myStatsPending = {}
CurrentStatusData = {}
local isPaused = false
local radarShowing = true;
local loopIsRuning = false;
local tickLoopIsRuning = false;
local cineon = false



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.TriggerServerCallback('esx:getPlayerStats', function(stats)
		myStats = stats
		ApplyStats()
	end)

	xPlayerData = ESX.GetPlayerData()
	TriggerServerEvent('esx_jobCounter:get')
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	xPlayerData = ESX.GetPlayerData()
	SetEntityMaxHealth(GetPlayerPed(-1), 200) -- igualar mujeres
	TriggerServerEvent('esx_jobCounter:get')
	Citizen.Wait(5000)
	print("Player loaded")
	ESX.TriggerServerCallback('esx:getPlayerStats', function(stats)
		myStats = stats
		ApplyStats()
	end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  xPlayerData.job = job
  forceRadarShow = false
  forceRadarShowScript = {}
end)
RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
  xPlayerData.job2 = job2
  forceRadarShow = false
  forceRadarShowScript = {}
end)

RegisterNetEvent('esx:onPlayerStatsChanged')
AddEventHandler('esx:onPlayerStatsChanged', function(stats, statsPending)
	myStats = stats	
	myStatsPending = statsPending	
	ApplyStats()
end)

function ApplyStats()
    if(myStats.lung == nil)then
        myStats.lung = 0.0
    end
    maxUnderwaterTimeRemaining =  10.0 + tonumber(myStats.lung)
    SetPedMaxTimeUnderwater(GetPlayerPed(-1), maxUnderwaterTimeRemaining + 0.0)
    maxTimeUnderwaterToRaiseStatsUp = maxUnderwaterTimeRemaining * 5
end

infiniteStaminaEnabled = false
function EnableInfiniteStamina()
	infiniteStaminaEnabled = true
	StatSetInt(GetHashKey('MP0_STAMINA'), 50, 1) 
end
function DisableInfiniteStamina()
	infiniteStaminaEnabled = false
	StatSetInt(GetHashKey('MP0_STAMINA'), 0, 1) 
end

currentTimeUnderWater  = 0
maxTimeUnderwaterToRaiseStatsUp = 10
Citizen.CreateThread(function()
	while true do
		if(IsPedSwimmingUnderWater(PlayerPedId())) then
			currentTimeUnderWater = currentTimeUnderWater + 1
			if(currentTimeUnderWater > maxTimeUnderwaterToRaiseStatsUp)then
				currentTimeUnderWater = 0
				ESX.TriggerServerCallback('esx:modifyPlayerStat', function(stats)
					myStats = stats
					ApplyStats()
				end, 'lung', 1)
			end
		end
		Citizen.Wait(1000)
	end
end)

previousCarDamage = nil

function round(num) 
	if num >= 0 then return math.floor(num+.5) 
	else return math.ceil(num-.5) end
end
function GetStatusData(minimal)
	local status = {}

	for i=1, #CurrentStatusData, 1 do
		if minimal then
			table.insert(status, {
				name    = CurrentStatusData[i].name,
				val     = CurrentStatusData[i].val,
				percent = CurrentStatusData[i].percent,
				blinkOnLow = not CurrentStatusData[i].reverse,
				blinkOnHigh = CurrentStatusData[i].reverse
			})
		else
			table.insert(status, {
				name    = CurrentStatusData[i].name,
				val     = CurrentStatusData[i].val,
				color   = CurrentStatusData[i].color,
				visible = CurrentStatusData[i].visible(CurrentStatusData[i]),
				max     = CurrentStatusData[i].max,
				percent = CurrentStatusData[i].percent,
				blinkOnLow = not CurrentStatusData[i].reverse,
				blinkOnHigh = CurrentStatusData[i].reverse
			})
		end
	end
	if(IsPedSwimmingUnderWater(PlayerPedId())) then
		local air = GetPlayerUnderwaterTimeRemaining(PlayerId())
		if air < 0.0 then
			air = 0.0
		end
		air = (air * 100 / maxUnderwaterTimeRemaining)
		table.insert(status, {
			name    = 'air',
			val     = round(air),
			visible = true,
			max     = maxUnderwaterTimeRemaining,
			percent = air,
			blinkOnLow = true,
			blinkOnHigh = false
		})
	else	
		table.insert(status, {
			name    = 'air',
			val     = 0,
			visible = false,
			max     = 10,
			percent = 0,
			blinkOnLow = true,
			blinkOnHigh = false
		})

	end	
	local playerVehicleIn = IsPlayerInVehicle()
	local playerPed = GetPlayerPed(-1)
	local playerMaxHealth = GetEntityMaxHealth(playerPed) - 100
	local playerHealth = GetEntityHealth(playerPed) - 100
	if(playerMaxHealth <= 0) then
		health = 0
	else
		health = (playerHealth * 100 / playerMaxHealth)
	end
	if(health < 0)then health = 0 end
	table.insert(status, {
		name    = 'health',
		val     = round(health),
		visible = radarShowing == false or true,
		max     = 100,
		percent = round(health),
		blinkOnLow = true,
		blinkOnHigh = false
	})
	stamina = 100-GetPlayerSprintStaminaRemaining(PlayerId())
	staminaPercent = round((stamina / 100) * 100)
	if(myStats.stamina ~= nil)then
		if(staminaPercent < 100 - (myStats.stamina / 2))then
			if(infiniteStaminaEnabled == true)then
				DisableInfiniteStamina()
			end
		else
			if(infiniteStaminaEnabled == false)then
				EnableInfiniteStamina()
			end
		end
	end
	table.insert(status, {
		name    = 'stamina',
		val     = round(stamina),
		visible = (playerVehicleIn == false),
		max     = 100,
		percent = staminaPercent,
		blinkOnLow = true,
		blinkOnHigh = false
	})
	armour = GetPedArmour(PlayerPedId())
	table.insert(status, {
		name    = 'armour',
		val     = round(armour),
		visible = (radarShowing == false or true) and round((armour / 100) * 100) > 0,
		max     = 100,
		percent = round((armour / 100) * 100),
		blinkOnLow = false,
		blinkOnHigh = false
	})
	if(armour == 0 and armourSet == true)then
		armourSet = false
		print('quitando armadura')
		TriggerEvent('skinchanger:getSkin', function(skin)
			if(skin.sex == 0)then
				TriggerEvent('skinchanger:loadClothes', skin, { ['bproof_1'] = 0,  ['bproof_2'] = 0 })
			else
				TriggerEvent('skinchanger:loadClothes', skin, { ['bproof_1'] = 0,  ['bproof_2'] = 0 })
			end
		end)
	end
	--[[if(playerVehicleIn == false) then
		fuel = 100
	else
		fuel = exports["esx_mole_fuel"]:GetFuel(playerVehicleIn)
	end
	table.insert(status, {
		name    = 'fuel',
		val     = round(fuel),
		visible = (playerVehicleIn ~= false),
		max     = 100,
		percent = round((fuel / 100) * 100),
		blinkOnLow = true,
		blinkOnHigh = false
	})
	if(playerVehicleIn ~= false) then
		cardamage = GetVehicleEngineHealth(playerVehicleIn)
	else
		cardamage = 0
	end
	table.insert(status, {
		name    = 'cardamage',
		val     = round(cardamage),
		visible = (playerVehicleIn ~= false),
		max     = 1000,
		percent = round((cardamage / 1000) * 100),
		blinkOnLow = true,
		blinkOnHigh = false
	})
	]]--
	return status
end
function IsPlayerInVehicle()
	local playerPed = GetPlayerPed(-1)
	local playerVeh = GetVehiclePedIsIn(playerPed, false)
	if(GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
		return playerVeh
	end
	return false
end
AddEventHandler('esx_status:registerStatus', function(name, default, color, reverse, visible, tickCallback)
	print("[esx_status] " .. name .. ' registered')
	local status = CreateStatus(name, default, color, reverse, visible, tickCallback)
	table.insert(CurrentStatusData, status)
end)

local previousStatusData = nil
local lastDataChanged = false
function DoTickLoop()
	if(tickLoopIsRuning == false) then
		tickLoopIsRuning = true
		Citizen.CreateThread(function()
			while true do
				for i=1, #CurrentStatusData, 1 do
					CurrentStatusData[i].onTick()
				end
				Citizen.Wait(1000)
			end
		end)
	end
end

DoTickLoop()
function DoLoop()
	if(loopIsRuning == false) then
		loopIsRuning = true
		Citizen.CreateThread(function()
			local previousDamage = 0
			while true do
				local newStatusData = GetStatusData()
				local dataChanged = false
				if(previousStatusData == nil)then
					previousStatusData = newStatusData
					dataChanged = true
				end
				for i=1, #newStatusData, 1 do
					if(newStatusData[i].name == 'stress') then
						if(isStressed == true)then
							if(newStatusData[i].percent < 80)then
								isStressed = false
								TriggerEvent("esx_status:isStressed",isStressed)
							--	SetPlayerCameraNormal()
							end
						else
							if(newStatusData[i].percent >= 80)then
								isStressed =  true
								TriggerEvent("esx_status:isStressed",isStressed)
							--	SetPlayerCameraStress()
							end
						end
					end
					if(newStatusData[i].name == 'cardamage') then
						if(newStatusData[i].visible) then
							if(newStatusData[i].percent >= 35 and previousDamage > newStatusData[i].percent + 1) then
								TriggerEvent("esx_status:add","stress",50000)
							end
							previousDamage = newStatusData[i].percent
						else
							previousDamage = 0
						end
					end
					if(newStatusData[i].percent ~= previousStatusData[i].percent or newStatusData[i].visible ~= previousStatusData[i].visible) then
						dataChanged = true
						break
					end
				end
				previousStatusData = newStatusData
				if(dataChanged == true)then
					SendNUIMessage({
						update = true,
						status = newStatusData
					})
				end
				Citizen.Wait(250)
			end
		end)
	end
end
DoLoop()

RegisterNetEvent('esx_status:load')
AddEventHandler('esx_status:load', function(status)
	for i=1, #CurrentStatusData, 1 do
		for j=1, #status, 1 do
			if CurrentStatusData[i].name == status[j].name then
				CurrentStatusData[i].set(status[j].val)
			end
		end
	end
end)

RegisterNetEvent('esx_status:set')
AddEventHandler('esx_status:set', function(name, val)
	for i=1, #CurrentStatusData, 1 do
		if CurrentStatusData[i].name == name then
			CurrentStatusData[i].set(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('esx_status:update', GetStatusData(true))
end)

RegisterNetEvent('esx_status:add')
AddEventHandler('esx_status:add', function(name, val)
	if(name == 'stress' and val > 0)then
		if(myStats.yoga ~= nil)then
			val = val - ESX.Math.Round((val  * (myStats.yoga / 2)) /100)
		end
	end
	for i=1, #CurrentStatusData, 1 do
		if CurrentStatusData[i].name == name then
			CurrentStatusData[i].add(val)
			--print('added to status ' .. name .. " " .. val)
			break
		end
	end
	local data = GetStatusData()
	SendNUIMessage({
		update = true,
		status = data
	})

	TriggerServerEvent('esx_status:update', GetStatusData(true))
end)

RegisterNetEvent('esx_status:remove')
AddEventHandler('esx_status:remove', function(name, val)
	for i=1, #CurrentStatusData, 1 do
		if CurrentStatusData[i].name == name then
			CurrentStatusData[i].remove(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('esx_status:update', GetStatusData(true))
end)

AddEventHandler('esx_status:getStatus', function(name, cb)
	cb(getStatus(name))
end)
function getStatus(name)
	for i=1, #CurrentStatusData, 1 do
		if CurrentStatusData[i].name == name then
			return CurrentStatusData[i]
		end
	end
	return nil
end
AddEventHandler('esx_status:setDisplay', function(val)
	SendNUIMessage({
		setDisplay = true,
		display    = val
	})
end)
local forceRadarShowScript = {}
local forceRadarShow = false
local forceRadarHideScript = {}
local forceRadarHide = false

Citizen.CreateThread(function()
	local isBigMapEnabled = false
	local showFullMap = false
	while true do
		Citizen.Wait(1)
		if IsControlJustReleased(0, 243) then -- `
			if isBigMapEnabled then
				showFullMap = not showFullMap
				if not showFullMap then
					isBigMapEnabled = false
				end
			else
				isBigMapEnabled = true
			end

			SetBigmapActive(isBigMapEnabled, showFullMap)
		end
	end
end)

-- Pause menu disable hud display
Citizen.CreateThread(function()
	SendNUIMessage({
		setMinimap = true,
		minimap  = exports.mole_utils:GetMinimapAnchor()
	})
	SendNUIMessage({
		setStyle = true,
		value  = Config.Style
	})
	while true do
		Citizen.Wait(1000)
		if IsPauseMenuActive() and not isPaused then
			isPaused = true
			SendNUIMessage({
				paused = true,
				value = true
			})
			TriggerEvent('esx_status:setDisplay', 0.0)
		elseif not IsPauseMenuActive() and isPaused then
			isPaused = false 
			SendNUIMessage({
				paused = true,
				value = false
			})
			TriggerEvent('esx_status:setDisplay', 0.5)
		end
		--local playerPed = GetPlayerPed(-1)
		--local playerVeh = GetVehiclePedIsIn(playerPed, false)
		--if(GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
		if((IsPedInAnyVehicle(PlayerPedId(), false) and IsEntityVisible(PlayerPedId())) and forceRadarHide == false or forceRadarShow)then
			SendNUIMessage({
				setMinimap = true,
				minimap  = exports.mole_utils:GetMinimapAnchor()
			})
			radarShowing = true;
			SendNUIMessage({
				radarChanged = true,
				isShowing    = true
			})
			DisplayRadar(true)
		else
			radarShowing = false;
			SendNUIMessage({
				radarChanged = true,
				isShowing    = false
			})
			DisplayRadar(false)
		end
	end
end)
function ForceShowRadar()
	if(#forceRadarShow > 0)then
		return true
	end
	return false
end
RegisterNetEvent('esx_status:forceRadarShow')
AddEventHandler('esx_status:forceRadarShow', function(sourceScript, mode)
	if(mode) then
		forceRadarShowScript[sourceScript] = true
	else
		forceRadarShowScript[sourceScript] = nil
	end
	forceRadarShow = false
	for k,v in pairs(forceRadarShowScript)do
		if(v)then
			forceRadarShow = true
		end
	end
end)
RegisterNetEvent('esx_status:forceRadarHide')
AddEventHandler('esx_status:forceRadarHide', function(sourceScript, mode)
	if(mode) then
		forceRadarHideScript[sourceScript] = true
	else
		forceRadarHideScript[sourceScript] = nil
	end
	forceRadarHide = false
	for k,v in pairs(forceRadarHideScript)do
		if(v)then
			forceRadarHide = true
		end
	end
end)
-- Loaded event
Citizen.CreateThread(function()
	print('status loaded')
	TriggerEvent('esx_status:loaded')
end)

-- Update server
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.UpdateInterval)

		TriggerServerEvent('esx_status:update', GetStatusData(true))
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if isStressed then
			wasStressed = true
			if IsPedMale(GetPlayerPed(-1)) then
				playMovement("move_m@depressed@a")
			else
				playMovement("move_f@depressed@a")
			end
		else
			if(wasStressed)then
				wasStressed = false
				ResetPedMovementClipset(GetPlayerPed(-1), 0)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1)
	  if isStressed == true then
		DisableControlAction(0,21,true) -- disable sprint
		DisableControlAction(0,22,true) -- disable jump
		DisableControlAction(0,170,true) -- disable f3
	  end
	end
  end)

  function playMovement(clipset)
	RequestAnimSet(clipset)
	local i = 0
	while not HasAnimSetLoaded(clipset) and i < 25 do
	  Citizen.Wait(10)
	  i = i+1
	end
	SetPedMovementClipset(GetPlayerPed(-1), clipset, true)
  end

  Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(10)
		local MyPed = GetPlayerPed(-1)
		if(IsPedShooting(MyPed))then
			local armed, weapon = GetCurrentPedWeapon(MyPed)
			if(weapon ~= 883325847)then
				TriggerEvent("esx_status:add", 'stress', 1000)
			end
		end
	end
end)

-- bajar streess en bici
Citizen.CreateThread(function()
	local lastPosition = nil
	while true do 
		Citizen.Wait(5000)
		local MyPed = GetPlayerPed(-1)
		local veh = GetVehiclePedIsIn(MyPed, false)
		if(veh ~= 0 and GetVehicleClass(veh) == 13) then
			local currentCoords = GetEntityCoords(MyPed)
			if(lastPosition ~= currentCoords)then
				lastPosition = currentCoords
				TriggerEvent("esx_status:remove", 'stress', 5000)
			end
		end
	end
end)

function SetPlayerCameraStress()
	local PlayerPed = PlayerPedId()
	ShakeGameplayCam("DRUNK_SHAKE", 1.0)
	--StartScreenEffect("DrugsMichaelAliensFight", 50000, 1)
	--StartScreenEffect("DrugsMichaelAliensFightIn", 50000, 1)
	SetPedMotionBlur(PlayerPed, true)
	--SetPedIsDrunk(PlayerPed, true)
	SetTimecycleModifier("spectator6")

end

-- Return to reality
function SetPlayerCameraNormal()

	Citizen.CreateThread(function()
		local playerPed = PlayerPedId()
		level = -1
		timing = false
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(playerPed, 0)
		--SetPedIsDrunk(playerPed, false)
		SetPedMotionBlur(playerPed, false)
		ClearPedSecondaryTask(playerPed)
		ShakeGameplayCam("DRUNK_SHAKE", 0.0)
		--StopScreenEffect("DrugsMichaelAliensFight")
		--StopScreenEffect("DrugsMichaelAliensFightIn")

	end)
end

local hurt = false

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if GetEntityHealth(GetPlayerPed(-1)) <= 159 then
            setHurt()
        elseif hurt and GetEntityHealth(GetPlayerPed(-1)) > 160 then
            setNotHurt()
        end
    end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end

function setNotHurt()
    hurt = false
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
end

RegisterNetEvent('mole_status_hud:disabled')
AddEventHandler('mole_status_hud:disabled', function(type)
	SendNUIMessage({
		disableHUD = true,
		value = type
	})
end)

RegisterNetEvent('mole_status_hud:enabled')
AddEventHandler('mole_status_hud:enabled', function()
	cineon = false
	TriggerEvent('esx_status:forceRadarHide', 'cine', false)
	SendNUIMessage({
		disableHUD = true,
		value = false
	})
end)
Citizen.CreateThread(function()
	while true do
		if(cineon == true)then
			DrawRect(1.0, 1.0, 2.0, 0.25, 0, 0, 0, 255)
			DrawRect(1.0, 0.0, 2.0, 0.25, 0, 0, 0, 255)
			Citizen.Wait(5)
		else
			Citizen.Wait(1000)
		end
	end
end)
RegisterNetEvent('mole_status_cine:disabled')
AddEventHandler('mole_status_cine:disabled', function()
	cineon = true
	TriggerEvent('esx_status:forceRadarHide', 'cine', true)
end)

local knockedOut = false
local wait = math.random(10,60)
local count = 60

Citizen.CreateThread(function()
    while true do
        if IsPedArmed(PlayerPedId(), 6) then
	    	DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
			Citizen.Wait(1)
		else
			Citizen.Wait(500)
		end
    end
end)

Citizen.CreateThread(function()
	while true do
	
		--DisableControlAction(0,140,true)
		local myPed = GetPlayerPed(-1)
		local isPedInMelee = IsPedInMeleeCombat(myPed)
		if(isPedInMelee or knockedOut)then
			if isPedInMelee then
				if GetEntityHealth(myPed) < 135 then
					--SetPlayerInvincible(PlayerId(), true)
					SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
					ESX.ShowNotification("~r~¡Estás inconsciente por "..wait.." segundos!")
					wait = 15
					knockedOut = true
					SetEntityHealth(myPed, 136)
				end
			end
			if knockedOut == true then
				--SetPlayerInvincible(PlayerId(), true)
				DisablePlayerFiring(PlayerId(), true)
				SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
				ResetPedRagdollTimer(myPed)
				
				if wait >= 0 then
					count = count - 1
					if count == 0 then
						count = 60
						wait = wait - 1
						--SetEntityHealth(myPed, GetEntityHealth(myPed)+4)
					end
				else
					ESX.ShowNotification("~r~¡Vuelves a estar consciente!")
					--SetPlayerInvincible(PlayerId(), false)
					knockedOut = false
				end
			end
			Wait(1)
		else
			Wait(1000)
		end
	end
end)
Citizen.CreateThread(function()
	local enabled = false
	SetTimecycleModifier("hud_def_desat_Trevor")
			Wait(3000)
			SetTimecycleModifier("")
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
	while true do
		Wait(1000)
		--DisableControlAction(0,140,true)
		if knockedOut == true and enabled == false then
			enabled = true
			SetTimecycleModifier('BarryFadeOut')
			SetTimecycleModifierStrength(math.min(0.1 / 10, 0.6))
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
			
		elseif(knockedOut == false and enabled == true)then
			enabled = false
			SetTimecycleModifier("")
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
					
		end

	end
end)

RegisterNetEvent("esx_mole_status:UpdateJobsCounter")
AddEventHandler("esx_mole_status:UpdateJobsCounter",function(jobsCount)
	jobsCount.playerId = GetPlayerServerId(PlayerId())
	SendNUIMessage({
		updateJobCounter = true,
		value = jobsCount
	})
end)

RegisterNetEvent("esx_mole_status:zoneui")
AddEventHandler("esx_mole_status:zoneui",function(zoneui)
	SendNUIMessage({
		updateZoneUI = true,
		value = zoneui
	})
end)
RegisterNetEvent("esx_mole_status:rightbottomopacity")
AddEventHandler("esx_mole_status:rightbottomopacity",function(opacity)
	SendNUIMessage({
		updateJobCounterOpacity = true,
		value = opacity
	})
end)
RegisterNetEvent('esx_mole_status:setPedArmour')
AddEventHandler('esx_mole_status:setPedArmour', function(armour, keepSkin)
	if(keepSkin ~= true)then
		TriggerEvent('skinchanger:getSkin', function(skin)
			if(armour == 100)then
				if(skin.sex == 0)then
					TriggerEvent('skinchanger:loadClothes', skin, { ['bproof_1'] = 9,  ['bproof_2'] = 0 })
				else
					TriggerEvent('skinchanger:loadClothes', skin, { ['bproof_1'] = 6,  ['bproof_2'] = 0 })
				end
			elseif(armour == 75)then
				if(skin.sex == 0)then
					TriggerEvent('skinchanger:loadClothes', skin, { ['bproof_1'] = 9,  ['bproof_2'] = 1 })
				else
					TriggerEvent('skinchanger:loadClothes', skin, { ['bproof_1'] = 6,  ['bproof_2'] = 1 })
				end
			elseif(armour == 50)then
				if(skin.sex == 0)then
					TriggerEvent('skinchanger:loadClothes', skin, { ['bproof_1'] = 9,  ['bproof_2'] = 2 })
				else
					TriggerEvent('skinchanger:loadClothes', skin, { ['bproof_1'] = 6,  ['bproof_2'] = 2 })
				end
			end
		end)
	end
	armourSet = true
	SetPedArmour(PlayerPedId(), armour)
end)
RegisterNetEvent('esx_mole_status:showBanner')
AddEventHandler('esx_mole_status:showBanner', function(banner, msg, style, timeout)
	SendNUIMessage({
		showBanner = true,
		banner = banner,
		msg = msg,
		style = style,
		timeout = timeout
	})
end)
