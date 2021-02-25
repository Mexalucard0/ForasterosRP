local voice = {default = 4.0, shout = 10.0, whisper = 2.0, current = 0, car = 20.0, level = nil, microphone1 = 25.0} --old shouth 12.5

ESX = nil
local userWasTalking = false;
local isCarMode = false
local haveMicrophone = false
local haveEmergencyMicrophone = false
local xPlayer = nil
local isMumbleEnabled = GetConvarInt('mumblevoip_enabled', 0)

if(isMumbleEnabled == 1)then
	Citizen.CreateThread(function()
		SendNUIMessage({
			updateVoice = true,
			value = { disable = true }
		})
	end)
	return
end

Citizen.CreateThread(function()
  	while ESX == nil do
    	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    	Citizen.Wait(0)
  	end

  	while (ESX.GetPlayerData() == nil or  ESX.GetPlayerData().inventory == nil) do
		Citizen.Wait(100)
  		xPlayer = ESX.GetPlayerData()

  		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].name == 'microphone' and  xPlayer.inventory[i].count > 0 then
				haveMicrophone = true
				break
			end

			if xPlayer.inventory[i].name == 'emergencymicrophone' and  xPlayer.inventory[i].count > 0 then
				haveEmergencyMicrophone = true
				break
			end
 		end
	end
 	SendNUIMessage({
		updateVoice = true,
		value = { enable = true }
	})
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)
	if(item.name == 'microphone')then
		haveMicrophone = true
	end
end)
RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)
	if(item.name == 'microphone')then
		haveMicrophone = false
	end
end)


AddEventHandler('onClientMapStart', function()
	if voice.current == 1 then
		NetworkSetTalkerProximity(voice.shout)
	elseif voice.current == 2 then
		NetworkSetTalkerProximity(voice.whisper)
	else
		NetworkSetTalkerProximity(voice.default)
	end
end)

Citizen.CreateThread(function()
	local wasInVehicle = false
	while true do
		Citizen.Wait(1)
		if(isMumbleEnabled == 0)then
		if IsControlJustPressed(1,  20) and isCarMode == false then
			if(haveEmergencyMicrophone)then
				voice.current = (voice.current + 1) % 5
			elseif(haveMicrophone)then
				voice.current = (voice.current + 1) % 4
			else
				voice.current = (voice.current + 1) % 3
			end
			
			if voice.current == 0 then
				NetworkSetTalkerProximity(voice.default)
				voice.level = 'Normal'
			elseif voice.current == 1 then
				NetworkSetTalkerProximity(voice.shout)
				voice.level = 'Grito'
			elseif voice.current == 2 then
				NetworkSetTalkerProximity(voice.whisper)
				voice.level = 'Susurro'
			elseif haveMicrophone == true and voice.current == 3 then
				NetworkSetTalkerProximity(voice.microphone1)
				voice.level = 'Microfono'
			end
			SendNUIMessage({
                updateVoice = true,
                value = { level = voice.level }
            })
		end

		if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			if(wasInVehicle == false)then
				wasInVehicle = true
				NetworkSetTalkerProximity(voice.car)
				voice.level = 'Coche'
				isCarMode = true
                SendNUIMessage({
                    updateVoice = true,
                    value = { level = voice.level }
                })
			end
		else
			if(wasInVehicle == true)then
				isCarMode = false
				wasInVehicle = false
				if voice.current == 0 then
					NetworkSetTalkerProximity(voice.default)
					voice.level = 'Normal'
				elseif voice.current == 1 then
					NetworkSetTalkerProximity(voice.shout)
					voice.level = 'Grito'
				elseif voice.current == 2 then
					NetworkSetTalkerProximity(voice.whisper)
					voice.level = 'Susurro'
				end
                SendNUIMessage({
                    updateVoice = true,
                    value = { level = voice.level }
                })
			end
		end

		if(isCarMode) then
			voice.level = 'Coche'
		elseif voice.current == 0 then
			voice.level = 'Normal'
		elseif voice.current == 1 then
			voice.level = 'Grito'
		elseif voice.current == 2 then
			voice.level = 'Susurro'
		end
		
		if (NetworkIsPlayerTalking(PlayerId()) and not userWasTalking) then
            userWasTalking = true
            SendNUIMessage({
                updateVoice = true,
                value = { level = voice.level, color = 'lime'}
            })
		elseif (not NetworkIsPlayerTalking(PlayerId()) and userWasTalking) then
            userWasTalking = false
            SendNUIMessage({
                updateVoice = true,
                value = { level = voice.level, color = 'darkgray'}
            })
		end
	end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
    SendNUIMessage({
		updateVoice = true,
		value = { level = 'Normal', color = 'darkgray'}
	})
	NetworkSetTalkerProximity(voice.default)
end)