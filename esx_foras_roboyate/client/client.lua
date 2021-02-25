-------------------------------------
------- Created by Hamza#1234 -------
------------------------------------- 

ESX 						= nil
local PlayerData            = {}
local YachtHeist 			= {}
local Goons 				= {}
local drillRect 			= 0.0
local stealingRect 			= 0.0
local jobPlayer 			= false
local takingCashClient		= false
local drillingClient 		= false
local HeistComplete 		= false
local blipYate				= nil

local trolleyNetObj
local emptyTrolleyNetObj

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('foras_roboyate:load')
AddEventHandler('foras_roboyate:load', function(list)
    YachtHeist = list
end)

RegisterNetEvent('foras_roboyate:statusRecentlyRobbed')
AddEventHandler('foras_roboyate:statusRecentlyRobbed', function(id,status)
    if id ~= nil or status ~= nil then 
        YachtHeist[id].recentlyRobbed = status
    end
end)

RegisterNetEvent('foras_roboyate:setblip')
AddEventHandler('foras_roboyate:setblip', function(position)
		blipYate = AddBlipForCoord(-2072.4143066406,-1020.1676025391,5.8841509819031)
		SetBlipSprite(blipYate, 161)
		SetBlipScale(blipYate, 2.0)
		SetBlipColour(blipYate, 3)
		PulseBlip(blipYate)
end)

RegisterNetEvent('foras_roboyate:killblip')
AddEventHandler('foras_roboyate:killblip',function()
		print("Estoy en la funcion cliente killblip")
		RemoveBlip(blipYate)
end)

RegisterNetEvent('foras_roboyate:statusSend')
AddEventHandler('foras_roboyate:statusSend', function(id,status)
    if id ~= nil or status ~= nil then 
        YachtHeist[id].started = status
    end
end)

RegisterNetEvent('foras_roboyate:statusGoonsSpawnedSend')
AddEventHandler('foras_roboyate:statusGoonsSpawnedSend', function(id,status)
    if id ~= nil or status ~= nil then 
        YachtHeist[id].GoonsSpawned = status
    end
end)

RegisterNetEvent('foras_roboyate:statusJobPlayerSend')
AddEventHandler('foras_roboyate:statusJobPlayerSend', function(id,status)
    if id ~= nil or status ~= nil then 
        YachtHeist[id].JobPlayer = status
    end
end)

RegisterNetEvent('foras_roboyate:statusHackSend')
AddEventHandler('foras_roboyate:statusHackSend', function(id,state)
    if id ~= nil or state ~= nil then  
        YachtHeist[id].keypadHacked = state
    end
end)

RegisterNetEvent('foras_roboyate:statusCurrentlyHackingSend')
AddEventHandler('foras_roboyate:statusCurrentlyHackingSend', function(id,state)
    if id ~= nil or state ~= nil then  
        YachtHeist[id].currentlyHacking = state
    end
end)

RegisterNetEvent('foras_roboyate:statusVaultSend')
AddEventHandler('foras_roboyate:statusVaultSend', function(id,state)
    if id ~= nil or state ~= nil then  
        YachtHeist[id].vaultLocked = state
    end
end)

RegisterNetEvent('foras_roboyate:statusDrillingSend')
AddEventHandler('foras_roboyate:statusDrillingSend', function(id,state)
    if id ~= nil or state ~= nil then  
        YachtHeist[id].drilling = state
    end
end)

RegisterNetEvent('foras_roboyate:statusSafeRobbedSend')
AddEventHandler('foras_roboyate:statusSafeRobbedSend', function(id,state)
    if id ~= nil or state ~= nil then  
        YachtHeist[id].safeRobbed = state
    end
end)

RegisterNetEvent('foras_roboyate:statusStealingSend')
AddEventHandler('foras_roboyate:statusStealingSend', function(id,state)
    if id ~= nil or state ~= nil then  
        YachtHeist[id].stealing = state
    end
end)

RegisterNetEvent('foras_roboyate:statusCashTakenSend')
AddEventHandler('foras_roboyate:statusCashTakenSend', function(id,state)
    if id ~= nil or state ~= nil then  
        YachtHeist[id].cashTaken = state
    end
end)

keyPressed = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped,true)
        for k,v in pairs(YachtHeist) do
            v.startPos[1] = v.startPos[1]
            v.startPos[2] = v.startPos[2]
            v.startPos[3] = v.startPos[3]
			if not v.started and (ESX.PlayerData.job and ESX.PlayerData.job.name ~= Config.PoliceDBname) then
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.startPos[1], v.startPos[2], v.startPos[3], true) <= 10.0 then
					DrawMarker(27, v.startPos[1], v.startPos[2], v.startPos[3]-0.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.25, 1.25, 1.25, 76, 190, 253, 100, false, true, 2, true, false, false, false)
				end    
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.startPos[1], v.startPos[2], v.startPos[3], true) <= 1.5 then
					DrawText3Ds(v.startPos[1], v.startPos[2], v.startPos[3], "Presiona ~y~E~s~ para atracar el Yate")
				end
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.startPos[1], v.startPos[2], v.startPos[3], true) <= 1.0 then
					if IsControlJustPressed(0,38) and not keyPressed then
						ESX.TriggerServerCallback('foras_roboyate:getCooldownHeist', function(NoCooldown)
							if NoCooldown then
								keyPressed = true
								ESX.TriggerServerCallback('foras_roboyate:GetPoliceOnline', function(PoliceCountOK)
									if PoliceCountOK then
										TriggerServerEvent("foras_roboyate:status", k, true)
										toggleHeistStart(k,v)
										ESX.ShowNotification("Encuentra la habitación que contiene la bóveda")
									else
										ESX.ShowNotification("La bóveda está cerrada debido a la falta de policía en la ciudad.")
										keyPressed = false
									end
								end)
							else
								keyPressed = false
							end
						end)
						break;
					end
				end
			end
        end
    end
end)
 
function toggleHeistStart(k,v)
    local ped = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(ped, true))
	exports['mole_notifications']:MoleShowProgressBar(1000, "COMENZANDO...")
	Citizen.Wait(1000) 
	ESX.ShowNotification('Elimina a los agentes de seguridad del yate')
	TriggerEvent("foras_roboyate:HeistMainEvent",k,v)
	SpawnTrolleyEvent(k,v)
	PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
	keyPressed = false
end

RegisterNetEvent('foras_roboyate:HeistMainEvent')
AddEventHandler('foras_roboyate:HeistMainEvent', function(k,v)
	local Goons = {}
	local ped = GetPlayerPed(-1)
	HeistComplete = false
	
	while not HeistComplete do
		Citizen.Wait(0)
		
		if v.started == true then
		
			local coords = GetEntityCoords(ped)
				-- Goons Spawn, not hostile:
			if (Vdist(coords.x, coords.y, coords.z, v.loc[1], v.loc[2], v.loc[3]) < 50) and not v.GoonsSpawned then
				v.GoonsSpawned = true
				TriggerServerEvent("foras_roboyate:goonsSpawned", k, true)
				Citizen.Wait(1500)
				ClearAreaOfPeds(v.loc[1], v.loc[2], v.loc[3], 50, 1)
				SetPedRelationshipGroupHash(ped, GetHashKey("PLAYER"))
				AddRelationshipGroup('HeistGuards')
				local i = 0
				for k,v in pairs(v.Goons) do
					RequestModel(GetHashKey(v.ped))
					while not HasModelLoaded(GetHashKey(v.ped)) do
						Wait(1)
					end
					Goons[i] = CreatePed(4, GetHashKey(v.ped), v.x, v.y, v.z, v.h, false, true)
					NetworkRegisterEntityAsNetworked(Goons[i])
					SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(Goons[i]), true)
					SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(Goons[i]), true)
					SetPedCanSwitchWeapon(Goons[i], true)
					SetPedArmour(Goons[i], 100)
					SetPedAccuracy(Goons[i], 60)
					DecorSetBool(Goons[i], "MRFIANOANIM", true)
					SetEntityInvincible(Goons[i], false)
					SetEntityVisible(Goons[i], true)
					SetEntityAsMissionEntity(Goons[i])
					RequestAnimDict(v.animDict) 
					while not HasAnimDictLoaded(v.animDict) do
						Citizen.Wait(0) 
					end 
					TaskPlayAnim(Goons[i], v.animDict, v.animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
					GiveWeaponToPed(Goons[i], GetHashKey(v.weapon), 255, false, false)
					SetPedDropsWeaponsWhenDead(Goons[i], false)
					SetPedFleeAttributes(Goons[i], 0, false)	
					SetPedRelationshipGroupHash(Goons[i], GetHashKey("HeistGuards"))	
					TaskGuardCurrentPosition(Goons[i], 3.0, 3.0, 1)
					i = i +1
				end
			end
			-- Gonns turning hostile:
			if (Vdist(coords.x, coords.y, coords.z, v.loc[1], v.loc[2], v.loc[3]) < 15) and not v.JobPlayer then
				v.JobPlayer = true
				TriggerServerEvent("foras_roboyate:JobPlayer", k, true)
				Citizen.Wait(1500)
				SetPedRelationshipGroupHash(ped, GetHashKey("PLAYER"))
				AddRelationshipGroup('HeistGuards')
				local i = 0
				for k,v in pairs(v.Goons) do
					ClearPedTasksImmediately(Goons[i])
					i = i +1
				end
				SetRelationshipBetweenGroups(0, GetHashKey("HeistGuards"), GetHashKey("HeistGuards"))
				SetRelationshipBetweenGroups(5, GetHashKey("HeistGuards"), GetHashKey("PLAYER"))
				SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("HeistGuards"))
			end
		end		
	end	
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped,true)
        for k,v in pairs(YachtHeist) do
            v.keypad[1] = v.keypad[1]
            v.keypad[2] = v.keypad[2]
            v.keypad[3] = v.keypad[3]
			if v.started == true then
				if v.keypadHacked == false and v.currentlyHacking == false then
					if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.keypad[1], v.keypad[2], v.keypad[3], true) <= 1.5 then
						if (ESX.PlayerData.job and ESX.PlayerData.job.name ~= Config.PoliceDBname) then
							DrawText3Ds(v.keypad[1], v.keypad[2], v.keypad[3], "Presiona ~y~E~s~ para ~y~hackear el panel~s~")
						end
					end
					if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.keypad[1], v.keypad[2], v.keypad[3], true) <= 1.0 then
						if IsControlJustPressed(0,38) and (ESX.PlayerData.job and ESX.PlayerData.job.name ~= Config.PoliceDBname) then
							HackKeypadEvent(k,v)
							break;
						end
					end
				end
			end
        end
    end
end)

function SpawnTrolleyEvent(k,v)
	local trolley = GetHashKey("hei_prop_hei_cash_trolly_01")
	RequestModel(trolley)
	while not HasModelLoaded(trolley) do
		Citizen.Wait(100)
	end
	local trolleyObject = CreateObject(trolley, v.trolleyPos[1], v.trolleyPos[2], v.trolleyPos[3], true)
	SetEntityRotation(trolleyObject, 0.0, 0.0, v.trolleyPos[4]+180.0)
	PlaceObjectOnGroundProperly(trolleyObject)
	SetEntityAsMissionEntity(trolleyObject, true, true)
	trolleyNetObj = ObjToNet(trolleyObject)
	SetModelAsNoLongerNeeded(trolley)
end

function HackKeypadEvent(k,v)
    local ped = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(ped, true))
    ESX.TriggerServerCallback("foras_roboyate:getHackerDevice", function(hackerDevice)
		if hackerDevice then
			if GetDistanceBetweenCoords(x,y,z, v.keypad[1], v.keypad[2], v.keypad[3],true) <= 1.0 then
				TriggerServerEvent("foras_roboyate:currentlyHacking", k, true)
				local animDict = "anim@heists@keypad@"
				local animLib = "idle_a"
			
				RequestAnimDict(animDict)
				while not HasAnimDictLoaded(animDict) do
					Citizen.Wait(50)
				end
				
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"),true)
				Citizen.Wait(500)
				
				FreezeEntityPosition(ped, true)
				exports['mole_notifications']:MoleShowProgressBar(8500, "CONNECTING")
				TaskPlayAnim(ped, animDict, animLib, 2.0, -2.0, -1, 1, 0, 0, 0, 0 )
				Citizen.Wait(3500)
				TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', -1, true)
				Citizen.Wait(5000)
				TriggerEvent("mhacking:show")
				TriggerEvent("mhacking:start",7,25,HackingEvent)
			end
		end
	end)
end

function HackingEvent(success)
	local ped = GetPlayerPed(-1)
	local coords = GetEntityCoords(ped)
	TriggerEvent('mhacking:hide')
	for k,v in pairs(YachtHeist) do
		if success then			
			TriggerServerEvent("foras_roboyate:statusHack", k, true)
			PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
			--TriggerEvent("chatMessage", "Police", {255, 185, 0}, "^7A ^1Heist is ^7in progress. ^7The Yacht is temporarily shut down!")
			Citizen.Wait(1000)
		else
			TriggerServerEvent("foras_roboyate:statusHack", k, false)
			--TriggerEvent("chatMessage", "Police", {255, 185, 0}, "^7A ^1Heist is ^7in progress. ^7The Yacht is temporarily shut down!")
			Citizen.Wait(1000)
		end
		TriggerServerEvent("foras_roboyate:currentlyHacking", k, false)
	end
	ClearPedTasks(ped)
	FreezeEntityPosition(ped, false)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped,true)
        for k,v in pairs(YachtHeist) do
            v.vaultDoor[1] = v.vaultDoor[1]
            v.vaultDoor[2] = v.vaultDoor[2]
            v.vaultDoor[3] = v.vaultDoor[3]
			if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.vaultDoor[1], v.vaultDoor[2], v.vaultDoor[3], true) <= 1.5 then
				local doorVault = GetClosestObjectOfType(v.vaultDoor[1], v.vaultDoor[2], v.vaultDoor[3], 1.5, v.vaultModel, false, false, false)
				if doorVault ~= 0 then
					if v.vaultLocked then
                        if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.vaultDoor[1], v.vaultDoor[2], v.vaultDoor[3], true) <= 1.5 then
                            if v.keypadHacked == true then
								DrawText3Ds(v.vaultDoor[1], v.vaultDoor[2], v.vaultDoor[3], "Presiona ~y~E~s~ parar ~y~abrir la bóveda~s~")
							end
                        end
                        local vaultLocked, heading = GetStateOfClosestDoorOfType(v.vaultModel, v.vaultDoor[1], v.vaultDoor[2], v.vaultDoor[3], v.vaultLocked, 0)
                        if heading > -0.01 and heading < 0.01 then
                            FreezeEntityPosition(doorVault, v.vaultLocked)
                        end
					else
                        if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.vaultDoor[1], v.vaultDoor[2], v.vaultDoor[3], true) <= 2.0 then
                            if v.started == true and (ESX.PlayerData.job and ESX.PlayerData.job.name == Config.PoliceDBname) then
								DrawText3Ds(v.keypad[1], v.keypad[2], v.keypad[3], "Presiona ~y~E~s~ para ~y~asegurar la bóveda~s~")
							end	
                        end
                        FreezeEntityPosition(doorVault, v.vaultLocked)
					end
				end
			end
            if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.vaultDoor[1], v.vaultDoor[2], v.vaultDoor[3], true) <= 1.0 then
				if v.started == true and v.keypadHacked == true and v.vaultLocked == true and (ESX.PlayerData.job and ESX.PlayerData.job.name ~= Config.PoliceDBname) then		
					if IsControlJustPressed(0,38) then
						VaultDoorEvent(k,v)
						break;
					end
				end
				if v.started == true and (ESX.PlayerData.job and ESX.PlayerData.job.name == Config.PoliceDBname) then		
					if IsControlJustPressed(0,38) and v.vaultLocked == false then
						PoliceSecureEvent(k,v)
						break;
					end		
					if IsControlJustPressed(0,38) and v.vaultLocked == true then
						VaultDoorEvent(k,v)
						break;
					end
				end
            end
        end
    end
end)

function VaultDoorEvent(k,v)
    local ped = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(ped, true))
    if GetDistanceBetweenCoords(x,y,z, v.vaultDoor[1], v.vaultDoor[2], v.vaultDoor[3],true) <= 1.0 then
        TriggerServerEvent("foras_roboyate:statusVault", k, false)
		Citizen.Wait(100)
		PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
    end
end

function PoliceSecureEvent(k,v)
    local ped = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(ped, true))
    if GetDistanceBetweenCoords(x,y,z, v.keypad[1], v.keypad[2], v.keypad[3],true) <= 0.5 then
		FreezeEntityPosition(ped, true)
        TriggerServerEvent("foras_roboyate:HeistIsBeingReset", k)
		exports['mole_notifications']:MoleShowProgressBar(1000, "SECURING")
		Citizen.Wait(1000)
		PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
		--TriggerEvent("chatMessage", "Police:", {255, 185, 0}, "^7The Yacht has been ^2secured ^7by the ^5Police ^7and is now open again!")
		FreezeEntityPosition(ped, false)
		Citizen.Wait(1000)
		if NetworkDoesEntityExistWithNetworkId(trolleyNetObj) then
			local trolleyInactive = NetToObj(trolleyNetObj)
			Citizen.Wait(250) 
			while not NetworkHasControlOfEntity(trolleyInactive) do
				Citizen.Wait(0)
				NetworkRequestControlOfEntity(trolleyInactive)
			end
			Citizen.Wait(250) 
			DeleteObject(trolleyInactive)
		end 
		Citizen.Wait(1000) 
		if NetworkDoesEntityExistWithNetworkId(emptyTrolleyNetObj) then
			local emptyTrolleyInactive = NetToObj(emptyTrolleyNetObj)
			Citizen.Wait(250) 
			while not NetworkHasControlOfEntity(emptyTrolleyInactive) do
				Citizen.Wait(0)
				NetworkRequestControlOfEntity(emptyTrolleyInactive)
			end
			Citizen.Wait(250) 
			DeleteObject(emptyTrolleyInactive)
		end
    else
		ESX.ShowNotification("Acercate al dispositivo de seguridad")
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped,true)
        for k,v in pairs(YachtHeist) do
            v.safe[1] = v.safe[1]
            v.safe[2] = v.safe[2]
            v.safe[3] = v.safe[3]
			local distAB = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.safe[1], v.safe[2], v.safe[3], true) 
			if v.started == true and (ESX.PlayerData.job and ESX.PlayerData.job.name ~= Config.PoliceDBname) then
				if v.vaultLocked == false and v.keypadHacked == true and v.safeRobbed == false then
					if distAB <= 1.5 and v.drilling == false then
						DrawText3Ds(v.safe[1], v.safe[2], v.safe[3], "Presiona ~y~E~s~ para ~y~taladrar~s~")
						if distAB <= 1.0 then
							if IsControlJustPressed(0,38) and v.drilling == false then
								Citizen.Wait(100)
								SafeDrillStartEvent(k,v)
								break;
							end
						end
					end
					if distAB <= 1.5 and v.drilling == true then
						DrawText3Ds(v.safe[1], v.safe[2], v.safe[3], "Presiona ~y~E~s~ para ~y~parar~s~")
						if distAB <= 1.0 then
							if IsControlJustPressed(0,38) and v.drilling == true then
								Citizen.Wait(100)
								SafeDrillStopEvent(k,v)
								break;
							end
						end
					end
				end
			end
        end
    end
end)

local attachedDrill
local effect
local drillSound
function SafeDrillStartEvent(k,v)
    local ped = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(ped, true))
    ESX.TriggerServerCallback("foras_roboyate:getDrillItem", function(drillItem)
		if drillItem then
			if GetDistanceBetweenCoords(x,y,z, v.safe[1], v.safe[2], v.safe[3],true) <= 1.0 then
				TriggerServerEvent("foras_roboyate:drilling", k, true)
				drillingClient = true
				
				FreezeEntityPosition(ped, true)
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"),true)
				Citizen.Wait(500)
				local animDict = "anim@heists@fleeca_bank@drilling"
				local animLib = "drill_straight_idle"
				
				RequestAnimDict(animDict)
				while not HasAnimDictLoaded(animDict) do
					Citizen.Wait(50)
				end
				
				local drillProp = GetHashKey('hei_prop_heist_drill')
				local boneIndex = GetPedBoneIndex(ped, 28422)
				
				RequestModel(drillProp)
				while not HasModelLoaded(drillProp) do
					Citizen.Wait(100)
				end
				
				TaskPlayAnim(ped,animDict,animLib,1.0, -1.0, -1, 2, 0, 0, 0, 0)
				
				attachedDrill = CreateObject(drillProp, 1.0, 1.0, 1.0, 1, 1, 0)
				AttachEntityToEntity(attachedDrill, ped, boneIndex, 0.0, 0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
				
				SetEntityAsMissionEntity(attachedDrill, true, true)
				
				RequestAmbientAudioBank("DLC_HEIST_FLEECA_SOUNDSET", 0)
				RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL", 0)
				RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2", 0)
				drillSound = GetSoundId()
				
				Citizen.Wait(750)
						
				PlaySoundFromEntity(drillSound, "Drill", attachedDrill, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
				
				Citizen.Wait(200)
				
				local particleDictionary = "scr_fbi5a"
				local particleName = "scr_bio_grille_cutting"

				RequestNamedPtfxAsset(particleDictionary)
				while not HasNamedPtfxAssetLoaded(particleDictionary) do
				  Citizen.Wait(0)
				end

				SetPtfxAssetNextCall(particleDictionary)
				effect = StartParticleFxLoopedOnEntity(particleName, attachedDrill, 0.0, -0.6, 0.0, 0.0, 0.0, 0.0, 2.0, 0, 0, 0)
				ShakeGameplayCam("ROAD_VIBRATION_SHAKE", 1.0)
			end
		end
	end)
end

function SafeDrillStopEvent(k,v)
    local ped = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(ped, true))
	TriggerServerEvent("foras_roboyate:drilling", k, false)
	drillingClient = false
	ClearPedTasksImmediately(ped)
	StopSound(drillSound)
	ReleaseSoundId(drillSound)
    DeleteEntity(attachedDrill)
    FreezeEntityPosition(ped, false)
    StopParticleFxLooped(effect, 0)
    StopGameplayCamShaking(true)
end

function drawRct(x, y, width, height, r, g, b, a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
		for k,v in pairs(YachtHeist) do
			if v.drilling and tonumber(drillRect) < 100.0 then
				drillRect = drillRect + 1
				Citizen.Wait(1000)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
    Citizen.Wait(0)
		for k,v in pairs(YachtHeist) do
			if v.drilling and drillingClient == true then
				-- background bar:
				drawRct(0.40, 0.95, 0.1430, 0.035, 0, 0, 0, 80)
				-- progress bar:
				drawRct(0.40, 0.95, (0.1429/100*drillRect) , 0.034, 238, 19, 52, 125)
				--text settings:
				SetTextScale(0.4, 0.4)
				SetTextFont(4)
				SetTextProportional(1)
				SetTextColour(255, 255, 255, 255)
				SetTextEdge(2, 0, 0, 0, 150)
				SetTextEntry("STRING")
				SetTextCentre(1)
				AddTextComponentString('TALADRANDO')
				DrawText(0.47,0.952)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed(-1)
		local coords = GetEntityCoords(ped,true)
		for k,v in pairs(YachtHeist) do
			if drillRect == 100.0 then
				TriggerServerEvent("foras_roboyate:drilling", k, false)
				drillingClient = false
				TriggerServerEvent("foras_roboyate:safeRobbed", k, true)
				Citizen.Wait(200)
				drillRect = 0
				ClearPedTasksImmediately(ped)
				StopSound(drillSound)
				ReleaseSoundId(drillSound)
				DeleteEntity(attachedDrill)
				FreezeEntityPosition(ped, false)
				StopParticleFxLooped(effect, 0)
				StopGameplayCamShaking(true)
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped,true)
        for k,v in pairs(YachtHeist) do
            v.trolleyPos[1] = v.trolleyPos[1]
            v.trolleyPos[2] = v.trolleyPos[2]
            v.trolleyPos[3] = v.trolleyPos[3]
			local distAB = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.trolleyPos[1], v.trolleyPos[2], v.trolleyPos[3], true) 
			if v.started == true and (ESX.PlayerData.job and ESX.PlayerData.job.name ~= Config.PoliceDBname) then
				if v.vaultLocked == false and v.keypadHacked == true and v.cashTaken == false then
					if NetworkDoesEntityExistWithNetworkId(trolleyNetObj) then
						if distAB <= 1.5 and v.stealing == false then
							DrawText3Ds(v.trolleyPos[1], v.trolleyPos[2], v.trolleyPos[3], "Presiona ~y~E~s~ para ~b~coger dinero~s~")
						end	
						if distAB <= 1.0 and v.stealing == false then
							if IsControlJustPressed(0,38) then
								Citizen.Wait(100)
								TakeCashEvent(k,v)
								break;
							end
						end
					end
				end
			end
        end
    end
end)

local totalCashTake = 0
local emptyTrolleyObject
function TakeCashEvent(k,v)
	local ped = PlayerPedId()
	TriggerServerEvent("foras_roboyate:stealing", k, true)
	takingCashClient = true
	local function GrabCashFromTrolley()
		local coords = GetEntityCoords(ped)
		local cashProp = GetHashKey("hei_prop_heist_cash_pile")
		RequestModel(cashProp)
		while not HasModelLoaded(cashProp) do
			Citizen.Wait(100)
		end
		local cashPile = CreateObject(cashProp, coords, true)
		FreezeEntityPosition(cashPile, true)
		SetEntityInvincible(cashPile, true)
		SetEntityNoCollisionEntity(cashPile, ped)
		SetEntityVisible(cashPile, false, false)
		AttachEntityToEntity(cashPile, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
		local takingCashTime = GetGameTimer()
		Citizen.CreateThread(function()
			while GetGameTimer() - takingCashTime < 37000 do
				Citizen.Wait(0)
									
				if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
					if not IsEntityVisible(cashPile) then
						SetEntityVisible(cashPile, true, false)
					end
				end		
				if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
					if IsEntityVisible(cashPile) then
						SetEntityVisible(cashPile, false, false)
						ESX.TriggerServerCallback('foras_roboyate:updateCashTaken', function(cashTaken)
							totalCashTake = totalCashTake + cashTaken
						end)
					end
				end
			end
			DeleteObject(cashPile)
		end)
	end
	local trolleyObjectInUse
	local trolleyObject = NetToObj(trolleyNetObj)
	local emptyTrolleyProp = GetHashKey("hei_prop_hei_cash_trolly_03")
	if IsEntityPlayingAnim(trolleyObject, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
		return ESX.ShowNotification("A player is ~b~already~s~ taking cash.")
	end
	local animDict = "anim@heists@ornate_bank@grab_cash"
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(50)
	end
	RequestModel(emptyTrolleyProp)
	while not HasModelLoaded(emptyTrolleyProp) do
		Citizen.Wait(100)
	end
	RequestModel(GetHashKey("hei_p_m_bag_var22_arm_s"))
	while not HasModelLoaded(GetHashKey("hei_p_m_bag_var22_arm_s")) do
		Citizen.Wait(100)
	end
	while not NetworkHasControlOfEntity(trolleyObject) do
		Citizen.Wait(0)
		NetworkRequestControlOfEntity(trolleyObject)
	end
	bagProp = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
	SetPedComponentVariation(ped, 5, 0, 0, 0)
	-- First Scene:
	scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(trolleyObject), GetEntityRotation(trolleyObject), 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(ped, scene1, animDict, "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(bagProp, scene1, animDict, "bag_intro", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(scene1)
	Citizen.Wait(1500)
	GrabCashFromTrolley()
	-- Second Scene:
	scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(trolleyObject), GetEntityRotation(trolleyObject), 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(ped, scene2, animDict, "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(bagProp, scene2, animDict, "bag_grab", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(trolleyObject, scene2, animDict, "cart_cash_dissapear", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(scene2)
	Citizen.Wait(37000)
	-- Third scene:
	scene3 = NetworkCreateSynchronisedScene(GetEntityCoords(trolleyObject), GetEntityRotation(trolleyObject), 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(ped, scene3, animDict, "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(bagProp, scene3, animDict, "bag_exit", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(scene3)
	-- Scenes are done:
	local emptyTrolley = CreateObject(emptyTrolleyProp, GetEntityCoords(trolleyObject) + vector3(0.0, 0.0, - 0.985), true)
	SetEntityRotation(emptyTrolley, GetEntityRotation(trolleyObject))
	while not NetworkHasControlOfEntity(trolleyObject) do
		Citizen.Wait(0)
		NetworkRequestControlOfEntity(trolleyObject)
	end
	DeleteObject(trolleyObject)
	PlaceObjectOnGroundProperly(emptyTrolley)
	SetEntityAsMissionEntity(emptyTrolley, true, true)
	emptyTrolleyNetObj = ObjToNet(emptyTrolley)
	Citizen.Wait(1900) 
	DeleteObject(bagProp)
	if Config.EnablePlayerMoneyBag == true then
		SetPedComponentVariation(ped, 5, 45, 0, 2)
	end
	RemoveAnimDict(animDict)
	SetModelAsNoLongerNeeded(emptyTrolleyProp)
	SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
	Citizen.Wait(2000)
	TriggerServerEvent("foras_roboyate:cashTaken", k, true)
	TriggerServerEvent("foras_roboyate:stealing", k, false)
	takingCashClient = false
end

Citizen.CreateThread(function()
	while true do
    Citizen.Wait(0)
		for k,v in pairs(YachtHeist) do
			if v.stealing and takingCashClient == true then
				-- background bar:
				drawRct(1.91, 1.95, 0.1430, 0.035, 0, 0, 0, 80)
				-- text settings:
				SetTextScale(0.4, 0.4)
				SetTextFont(4)
				SetTextProportional(1)
				SetTextColour(255, 255, 255, 255)
				SetTextEdge(2, 0, 0, 0, 150)
				SetTextEntry("STRING")
				SetTextCentre(1)
				AddTextComponentString("OBTENIDO:")
				DrawText(1.925,1.9535)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
    Citizen.Wait(0)
		for k,v in pairs(YachtHeist) do
			if v.stealing and takingCashClient == true then
				SetTextScale(0.45, 0.45)
				SetTextFont(4)
				SetTextProportional(1)
				SetTextColour(255, 255, 255, 255)
				SetTextEdge(2, 0, 0, 0, 150)
				SetTextEntry("STRING")
				SetTextCentre(1)
				AddTextComponentString(comma_value("$"..totalCashTake..""))
				DrawText(0.97,0.9523)
			end
		end
	end
end)

-- Function for 3D text:
function DrawText3Ds(x,y,z, text)
	ESX.ShowFloatingHelpNotification(text, vector3(x, y, z +1))
	--[[local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)--]]
end

-- Blip on Map for Heist:
Citizen.CreateThread(function()
  for k,v in pairs(Config.Yacht) do
    local blip = AddBlipForCoord(v.startPos[1], v.startPos[2], v.startPos[3])
    SetBlipSprite (blip, v.blipSprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, v.blipScale)
    SetBlipColour (blip, v.blipColor)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(v.blipName)
    EndTextCommandSetBlipName(blip)
  end
end)

function comma_value(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

-- Refresh Heist State
Citizen.CreateThread(function()
    TriggerServerEvent("foras_roboyate:refreshHeist")
end)

