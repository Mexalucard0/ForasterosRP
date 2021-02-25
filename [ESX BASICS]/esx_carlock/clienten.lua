ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

end)


Citizen.CreateThread(function()
	local dict = "anim@mp_player_intmenu@key_fob@"
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(5)
	end
	while true do
	  Citizen.Wait(5)
	  if (IsControlJustPressed(1, 303)) then
		  local coords = GetEntityCoords(GetPlayerPed(-1))
		  local hasAlreadyLocked = false
		  cars = ESX.Game.GetVehiclesInArea(coords, 30)
		  local carstrie = {}
		  local cars_dist = {}
		  notowned = 0
		  if #cars == 0 then
			  ESX.ShowNotification("No hay vehículos cerca.")
		  else
			  for j=1, #cars, 1 do
				  local coordscar = GetEntityCoords(cars[j])
				  local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
				  table.insert(cars_dist, {cars[j], distance})
			  end
			  for k=1, #cars_dist, 1 do
				  local z = -1
				  local distance, car = 999
				  for l=1, #cars_dist, 1 do
					  if cars_dist[l][2] < distance then
						  distance = cars_dist[l][2]
						  car = cars_dist[l][1]
						  z = l
					  end
				  end
				  if z ~= -1 then
					  table.remove(cars_dist, z)
					  table.insert(carstrie, car)
				  end
			  end
			  for i=1, #carstrie, 1 do
				  local veh = carstrie[i];
				  local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
				  ESX.TriggerServerCallback('carlock:isVehicleOwner', function(owner)
					  if owner and hasAlreadyLocked ~= true then
						  local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
						  vehicleLabel = GetLabelText(vehicleLabel)
						  local lock = GetVehicleDoorLockStatus(veh)
						  if lock == 1 or lock == 0 then --vehiculo abierto
							  SetVehicleDoorShut(veh, 0, false)
							  SetVehicleDoorShut(veh, 1, false)
							  SetVehicleDoorShut(veh, 2, false)
							  SetVehicleDoorShut(veh, 3, false)
							  SetVehicleDoorsLocked(veh, 2)
							  SetVehicleDoorsLockedForAllPlayers(veh, true)
							  PlayVehicleDoorCloseSound(veh, 1)
							  ESX.ShowNotification('Has ~r~cerrado~s~ tu ~y~'..vehicleLabel..'~s~.')
							  if not IsPedInAnyVehicle(PlayerPedId(), true) then
								  TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							  end
							  TriggerServerEvent('carlock:setVehicleLocked', plate, true)
							  hasAlreadyLocked = true
						  elseif lock == 2 then --vehiculo cerrado
							  SetVehicleDoorsLockedForAllPlayers(veh, false)
							  SetVehicleDoorsLocked(veh,1)
							  SetVehicleDoorsLockedForPlayer(veh, PlayerId(), false)
							  PlayVehicleDoorOpenSound(veh, 0)
							  ESX.ShowNotification('Has ~g~abierto~s~ tu ~y~'..vehicleLabel..'~s~.')
							  if not IsPedInAnyVehicle(PlayerPedId(), true) then
								  TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							  end
							  TriggerServerEvent('carlock:setVehicleLocked', plate, false)
							  hasAlreadyLocked = true
						  end
					  else
						  notowned = notowned + 1
					  end
					  if notowned == #carstrie then
						  ESX.ShowNotification("No hay vehículos cerrados cerca.")
					  end	
				  end, plate)
			  end			
		  end
	  end
	end
  end)
  
  RegisterNetEvent("carlock:onSetVehicleLocked")
  AddEventHandler("carlock:onSetVehicleLocked", function(plate, locked)
	  while ESX == nil do
		  Citizen.Wait(100)
	  end
	  local coords = GetEntityCoords(GetPlayerPed(-1))
	  local hasAlreadyLocked = false
	  local cars = ESX.Game.GetVehiclesInArea(coords, 30)
	  for j=1, #cars, 1 do
		  veh = cars[j]
		  local vehplate = ESX.Math.Trim(GetVehicleNumberPlateText(cars[j]))
		  if(vehplate == plate)then
			  local lock = GetVehicleDoorLockStatus(veh)
			  if lock == 1 or lock == 0 then --vehiculo abierto
				  if(locked == true)then
					  SetVehicleDoorShut(veh, 0, false)
					  SetVehicleDoorShut(veh, 1, false)
					  SetVehicleDoorShut(veh, 2, false)
					  SetVehicleDoorShut(veh, 3, false)
					  SetVehicleDoorsLocked(veh, 2)
				  end
			  elseif lock == 2 then --vehiculo cerrado
				  if(locked == false)then
					  SetVehicleDoorsLocked(veh,1)
				  end
			  end
		  end
	  end
  end)