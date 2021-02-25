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

--FLAG ENABLED - CONVERTED INTEGER - DESCRIPTION
--00000000000000000000000000000001 - 1 - stop before vehicles
--00000000000000000000000000000010 - 2 - stop before peds
--00000000000000000000000000000100 - 4 - avoid vehicles
--00000000000000000000000000001000 - 8 - avoid empty vehicles
--00000000000000000000000000010000 - 16 - avoid peds
--00000000000000000000000000100000 - 32 - avoid objects
--00000000000000000000000001000000 - 64 - ?
--00000000000000000000000010000000 - 128 - stop at traffic lights
--00000000000000000000000100000000 - 256 - use blinkers
--00000000000000000000001000000000 - 512 - allow going wrong way (only does it if the correct lane is full, will try to reach the correct lane again as soon as possible)
--00000000000000000000010000000000 - 1024 - go in reverse gear (backwards)
--00000000000000000000100000000000 - 2048 - ?
--00000000000000000001000000000000 - 4096 - ?
--00000000000000000010000000000000 - 8192 - ?
--00000000000000000100000000000000 - 16384 - ?
--00000000000000001000000000000000 - 32768 - ?
--00000000000000010000000000000000 - 65536 - ?
--00000000000000100000000000000000 - 131072 - ?
--00000000000001000000000000000000 - 262144 - Take shortest path (Removes most pathing limits, the driver even goes on dirtroads)
--00000000000010000000000000000000 - 524288 - Probably avoid offroad?
--00000000000100000000000000000000 - 1048576 - ?
--00000000001000000000000000000000 - 2097152 - ?
--00000000010000000000000000000000 - 4194304 - Ignore roads (Uses local pathing, only works within 200~ meters around the player)
--00000000100000000000000000000000 - 8388608 - ?
--00000001000000000000000000000000 - 16777216 - Ignore all pathing (Goes straight to destination)
--00000010000000000000000000000000 - 33554432 - ?
--00000100000000000000000000000000 - 67108864 - ?
--00001000000000000000000000000000 - 134217728 - ?
--00010000000000000000000000000000 - 268435456 - ?
--00100000000000000000000000000000 - 536870912 - avoid highways when possible (will use the highway if there is no other way to get to the destination)
--01000000000000000000000000000000 - 1073741824 - ?```



local autopilotCoords = nil
local autopilotSpeed = 80
RegisterNetEvent("esx_mole_status:startAutopilot")
AddEventHandler("esx_mole_status:startAutopilot", function(source)
	if(autopilotActive == false)then
		local player = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(player,false)
		local model = GetEntityModel(vehicle)
		local displaytext = GetDisplayNameFromVehicleModel(model)
		print(displaytext)
		if(displaytext == 'MODELS')then
			if(seatbeltIsOn == false)then
				ESX.SendNotification('TESLA AUTOPILOT: Debes tener el cinturón puesto para usar el AutoPilot')
				--TriggerEvent("mole_notifications:SendNotification", {text = "TESLA AUTOPILOT: Debes tener el cinturón puesto para usar el AutoPilot", type = "error", timeout = 1400})
			else
				local blip = GetFirstBlipInfoId(8)
				if (blip ~= nil and blip ~= 0) then
					local coord = GetBlipCoords(blip)
					local _, roadCoords = GetClosestRoad(coord.x,coord.y,coord.z, 1.0, 1)
					autopilotCoords = roadCoords

					local streetA, streetB = GetStreetNameAtCoord(autopilotCoords.x, autopilotCoords.y, autopilotCoords.z)
					local street = {}
					
					if streetA ~= 0 then
						table.insert( street, GetStreetNameFromHashKey( streetA ) )
					end
					
					if streetB ~= 0 then
						table.insert( street, GetStreetNameFromHashKey( streetB ) )
					end
					local fullStreetName = table.concat( street, " & " )
					ESX.SendNotification("TESLA AUTOPILOT: Iniciando ruta hacia " .. fullStreetName)
					TriggerEvent("mole_notifications:SendNotification", {text = "TESLA AUTOPILOT: Iniciando ruta hacia " .. fullStreetName, type = "info", timeout = 1400})
                    TriggerEvent('esx_mole_status:voicegps')
					TaskVehicleDriveToCoordLongrange(player, vehicle, roadCoords, autopilotSpeed/3.6, 1023- 128, 15.0)
					TriggerEvent('vehiclecontrol:lockspeed', vehicle, autopilotSpeed/3.6)
					SetEntityMaxSpeed(vehicle, autopilotSpeed/3.6)
					autopilotActive = true
				else
					ESX.SendNotification("TESLA AUTOPILOT: Por favor, seleccione el destino en el GPS")
					TriggerEvent("mole_notifications:SendNotification", {text = "TESLA AUTOPILOT: Por favor, seleccione el destino en el GPS", type = "info", timeout = 1400})
				end
			end
		end
	end
end)

function DeactivateAutopilot()
	autopilotActive = false
	autopilotCoords = nil
	ClearPedTasks(PlayerPedId())
	local player = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(player,false)
	if(vehicle ~= nil)then
		TriggerEvent('vehiclecontrol:lockspeed', vehicle)
	end
	ESX.SendNotification('TESLA AUTOPILOT: Desactivado')
    TriggerEvent("mole_notifications:SendNotification", {text = "TESLA AUTOPILOT: Desactivado", type = "error", timeout = 1400})
    TriggerEvent('esx_mole_status:voicegpsoff')
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1) -- no need to check it every frame
        if autopilotActive then
            if IsControlJustPressed(0, Keys['A']) or IsControlJustPressed(0, Keys['W']) or IsControlJustPressed(0, Keys['S']) or IsControlJustPressed(0, Keys['D']) then
                DeactivateAutopilot()
            end
        end
    end
end)
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(200) -- no need to check it every frame
      if autopilotActive then
           local coords = GetEntityCoords(GetPlayerPed(-1))
           local blip = GetFirstBlipInfoId(8)
           local dist = Vdist(coords.x, coords.y, coords.z, autopilotCoords.x, autopilotCoords.y, coords.z)
           if dist <= 15 then
              local player = GetPlayerPed(-1)
              local vehicle = GetVehiclePedIsIn(player,false)
              ClearPedTasks(player)
              -- smooth slowdown and stop:
              SetVehicleForwardSpeed(vehicle,19.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,15.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,11.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,6.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,0.0)
			  --
			  ESX.SendNotification('TESLA AUTOPILOT: Ha llegado a su destino')
			  TriggerEvent("mole_notifications:SendNotification", {text = "TESLA AUTOPILOT: Ha llegado a su destino", type = "info", timeout = 1400})
              DeactivateAutopilot()
           end
      end
    end
end)

