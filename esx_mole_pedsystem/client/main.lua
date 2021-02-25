local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX								= nil
local HasAlreadyEnteredMarker	= false
local LastZone					= nil
local CurrentAction				= nil
local CurrentActionMsg			= ''
local CurrentActionData			= {}
local CurrentActionMsgCoords = nil
local isDead					= false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	local xPlayer = ESX.GetPlayerData()
	if(xPlayer.identifier == 'steam:11000010000612d' 
	or xPlayer.identifier == 'steam:11000010cfabf9d' 
	or xPlayer.identifier == 'steam:110000108310d16'  
	or xPlayer.identifier == 'steam:1100001359d96f9' or xPlayer.identifier == 'steam:11000010e4072eb'  
	or xPlayer.identifier == 'steam:11000013ec08e27'
	or xPlayer.identifier == 'steam:110000109958b05' --mole2
	or xPlayer.identifier == 'steam:110000142333b63' --mole2
	or xPlayer.identifier == 'steam:11000010489fdc9' --mole2
	or xPlayer.identifier == 'steam:1100001064feb06'
	or xPlayer.identifier == 'steam:11000010197192c'
	or xPlayer.identifier == 'steam:11000013257bad9'
) then
		EnableGodLoop()
	end
end)

function OpenAccessoryMenu()
	local elements = {
	}
	local xPlayer = ESX.GetPlayerData()
	local allowStaffPeds = false
	if(xPlayer.identifier == 'steam:11000010000612d' --mole
		or xPlayer.identifier == 'steam:110000108310d16' --rai1
		or xPlayer.identifier == 'steam:1100001359d96f9' --dipeerz1
		or xPlayer.identifier == 'steam:11000010e4072eb' --yisus
		or xPlayer.identifier == 'steam:11000013dabbd1d' --blako2
		or xPlayer.identifier == 'steam:11000013daf44ec' --rai2
		or xPlayer.identifier == 'steam:11000013db3a49b' --dipeerz2
		or xPlayer.identifier == 'steam:11000013ec08e27' --mole2
		or xPlayer.identifier == 'steam:110000109958b05' --mole2
		or xPlayer.identifier == 'steam:110000142333b63' --mole2
		or xPlayer.identifier == 'steam:11000010489fdc9' --mole2
		or xPlayer.identifier == 'steam:1100001064feb06'
		or xPlayer.identifier == 'steam:11000010197192c'
		or xPlayer.identifier == 'steam:11000013257bad9'
	) then
		allowStaffPeds = true
	end
	local needOriginal = false
	for _,v in pairs(Config.Peds) do
		if((v.identifier == 'zombie' and zombieEnabled) or xPlayer.identifier == v.identifier or (allowStaffPeds and v.identifier == 'staff') or xPlayer.identifier == 'steam:11000010000612d' or xPlayer.identifier == 'steam:11000010e4072eb')then
			table.insert(elements, v)
			needOriginal = true
		end
	end
	if(needOriginal)then
		table.insert(elements, 1, {label = 'Avatar original', value = 'moleavataroff'})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_unset_accessory',
	{
		title = 'Menú Peds',
		align = 'bottom-right',
		elements = elements
	}, function(data, menu)
		menu.close()
		SetUnsetPed(data.current)
	end, function(data, menu)
		menu.close()
	end)
end

local godmode = false
function EnableGodLoop()
	Citizen.CreateThread(function() --Superman Mode
		while true do
			Wait(1)
			if (godmode == true) then
				local forceJump = false
				local playerPed = GetPlayerPed(-1)
				local coords = Citizen.InvokeNative(0x0A794A5A57F8DF91, playerPed, Citizen.ResultAsVector())
				local SupermanZ = 0.0
				local pedInParachuteFreeFall = IsPedInParachuteFreeFall(playerPed)
				if(not pedInParachuteFreeFall and IsPedJumping(playerPed) and IsControlPressed(1, 38))then
					SupermanZ = 25.0
					forceJump = true
				end
				local x, y =  0, 0
				if pedInParachuteFreeFall then
					if IsControlPressed(1, 32) then --w
						x = coords.x * 1.3
						y = coords.y * 1.3
						SupermanZ = 1.5
					elseif IsControlPressed(1,33) then --x
						x = coords.x * -1.3
						y = coords.y * -1.3
						SupermanZ = 0.225
					end
					if IsControlPressed(1, 127) then --baja
						SupermanZ = 0.0
					elseif IsControlPressed(1, 126) then --sube
						SupermanZ = SupermanZ + 1.0
					else
						if(SupermanZ > 5) then
							SupermanZ = SupermanZ / 2
							forceJump = true
						else
							SupermanZ = 0.225
						end
					end
				end
				GiveWeaponToPed(playerPed, GetHashKey("gadget_parachute"), 1, false, false)
				if pedInParachuteFreeFall or forceJump then
					ApplyForceToEntity(playerPed, 1, x, y, SupermanZ, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
				end
			end
		end
	end)
	Citizen.CreateThread(function() --Godmode
		local ped = GetPlayerPed(-1)
		while true do
			Citizen.Wait(1)
			if (godmode == true) then
				SetEntityInvincible(ped, true)
				SetPlayerInvincible(PlayerId(), true)
				SetPedCanRagdoll(ped, false)
				ClearPedBloodDamage(ped)
				ResetPedVisibleDamage(ped)
				ClearPedLastWeaponDamage(ped)
				SetEntityProofs(ped, true, true, true, true, true, true, true, true)
				SetEntityOnlyDamagedByPlayer(ped, false)
				SetEntityCanBeDamaged(ped, false)
			elseif (godmode == false) then
				SetEntityInvincible(ped, false)
				SetPlayerInvincible(PlayerId(), false)
				SetPedCanRagdoll(ped, true)
				ClearPedLastWeaponDamage(ped)
				SetEntityProofs(ped, false, false, false, false, false, false, false, false)
				SetEntityOnlyDamagedByPlayer(ped, true)
				SetEntityCanBeDamaged(ped, true)
			end
		end
	end)
end

local isCustomPed = false

RegisterCommand('fixpj', function()
	local hp = GetEntityHealth(GetPlayerPed(-1))
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		local isMale = skin.sex == 0
		godmode = false
		TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
				TriggerEvent('esx:restoreLoadout')
				TriggerEvent('dpc:ApplyClothing')
				SetEntityHealth(GetPlayerPed(-1), hp)
			end)
			Citizen.Wait(1000)
			ExecuteCommand('arma')
			Citizen.Wait(1000)
			ExecuteCommand('arma')
		end)
	end)
end, false)

function SetUnsetPed(accessory)
	if accessory.value == "moleavataroff" then
		if(isCustomPed) then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				local isMale = skin.sex == 0
				godmode = false
				TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
						TriggerEvent('esx:restoreLoadout')
						TriggerEvent('dpc:ApplyClothing')
					end)
				end)

			end)
			isCustomPed = false
		end
	elseif accessory.value == "moleavatar" then
		local modelHash = GetHashKey(accessory.haskey)
		godmode = true
		ESX.Streaming.RequestModel(modelHash, function()
			SetPlayerModel(PlayerId(), modelHash)
			SetPedDefaultComponentVariation(PlayerPedId())
			SetModelAsNoLongerNeeded(modelHash)
			TriggerEvent('esx:restoreLoadout')
			SetPedComponentVariation(PlayerPedId(), 8, 0, 0, 2)
		end)
		isCustomPed = true
	elseif accessory.value == "customavatar" then
		local modelHash = GetHashKey(accessory.haskey)
		godmode = false
		SetPedDefaultComponentVariation(PlayerPedId())
		ESX.Streaming.RequestModel(modelHash, function()
			SetPlayerModel(PlayerId(), modelHash)
			SetPedDefaultComponentVariation(PlayerPedId())
			SetModelAsNoLongerNeeded(modelHash)
			TriggerEvent('esx:restoreLoadout')
			SetPedComponentVariation(PlayerPedId(), 8, 0, 0, 2)
			SetEntityMaxHealth(PlayerPedId(), 200)
			Citizen.Wait(1000)
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
				TriggerEvent('esx:restoreLoadout')
				TriggerEvent('dpc:ApplyClothing')
			end)
		end)
		isCustomPed = true
	elseif accessory.value == "animalavatar" then
		local modelHash = GetHashKey(accessory.haskey)
		godmode = false
		ESX.Streaming.RequestModel(modelHash, function()
			SetPlayerModel(PlayerId(), modelHash)
			TriggerEvent('esx:restoreLoadout')
			SetPedDefaultComponentVariation(PlayerPedId())
			--SetPedComponentVariation(PlayerPedId(), 8, 0, 0, 2)
			SetPedEnveffScale(GetPlayerPed(-1), 0.2)
			SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 0)
			SetCanAttackFriendly(GetPlayerPed(-1), false, false)
		end)
		isCustomPed = true
	else
		ESX.ShowNotification("Ha ocurrido un error a la hora de poner el ped")
	end
end

AddEventHandler('playerSpawned', function()
	isDead = false
	TriggerServerEvent('mole:refreshpurga')
	TriggerServerEvent('mole:refreshzombie')
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)


-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustReleased(0, 84) and IsInputDisabled(0) and not isDead then
			OpenAccessoryMenu()
		end
	end
end)

local purgaEnabled = false
RegisterNetEvent('mole:purgaenabled')
AddEventHandler('mole:purgaenabled',function(enabled)
	purgaEnabled = enabled
	if(purgaEnabled)then
		print("sistema de purga habilitado")
	end
end)
local zombieEnabled = false
RegisterNetEvent('mole:zombieenabled')
AddEventHandler('mole:zombieenabled',function(enabled)
	zombieEnabled = enabled
	if(zombieEnabled)then
		print("sistema de zombi habilitado")
	end
end)
RegisterNetEvent('skinchanger:modelLoaded')
AddEventHandler('skinchanger:modelLoaded', function()
	if(zombieEnabled)then
		local ped = GetPlayerPed(-1)
		ApplyPedDamagePack(ped,"BigHitByVehicle", 0.0, 9.0)
		ApplyPedDamagePack(ped,"SCR_Dumpster", 0.0, 9.0)
		ApplyPedDamagePack(ped,"SCR_Torture", 0.0, 9.0)
	end
end)
