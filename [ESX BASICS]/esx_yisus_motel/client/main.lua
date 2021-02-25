ESX = nil

cachedData = {
	["motels"] = {},
	["insideMotel"] = false
}

knocking = {}

Citizen.CreateThread(function()
	while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
		--Fetching esx library, due to new to esx using this.

		TriggerEvent("ESX:getSharedObject", function(library) 
			ESX = library 
		end)

		Citizen.Wait(25)
	end

	if ESX.IsPlayerLoaded() then
		Wait(10000)
		Init()
	end

	AddTextEntry("Instructions", Config.HelpTextMessage)
end)

RegisterNetEvent("ESX:playerLoaded")
AddEventHandler("ESX:playerLoaded", function(playerData)
	ESX.PlayerData = playerData
	Wait(10000)
	Init()
end)


RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(newJob)
	ESX.PlayerData["job"] = newJob
end)

RegisterNetEvent("motel:eventHandler")
AddEventHandler("motel:eventHandler", function(response, eventData, id)
	if response == "update_motels" then
		cachedData["motels"] = eventData
	elseif response == "update_storages" then
		if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "main_storage_menu_" .. eventData["storageId"]) then
			local openedMenu = ESX.UI.Menu.GetOpened("default", GetCurrentResourceName(), "main_storage_menu_" .. eventData["storageId"])

			if openedMenu then
				openedMenu.close()
				OpenMoleStorageMenu("motel", eventData["storageId"], "Tu motel", true, false, false, false, function() end)
			end
		end
	elseif response == "invite_player" then
		if eventData["player"]["source"] == GetPlayerServerId(PlayerId()) then
			Citizen.CreateThread(function()
				local startedInvite = GetGameTimer()

				cachedData["invited"] = true
				local invitedPlayerCoords = GetEntityCoords(GetPlayerPed(-1))
				invitedPlayerCoords = vector3(invitedPlayerCoords.x,invitedPlayerCoords.y,invitedPlayerCoords.z + 1)
				while GetGameTimer() - startedInvite < 7500 do
					Citizen.Wait(0)

					ESX.ShowFloatingHelpNotification("Has sido invitado a la habitacion #" .. eventData["motel"]["room"] .. ".<br>Presiona ~y~G~s~ para entrar.", invitedPlayerCoords)

					if IsControlJustPressed(0, 47) then
						EnterMotel(eventData["motel"])

						break
					end
				end

				cachedData["invited"] = false
			end)
		end
	elseif response == "knock_motel" then
		local currentInstance = myInstance

		if currentInstance > 0 and currentInstance == eventData["uniqueId"] then
			knocking[id] = true
			ESX.ShowNotification("Alguien esta tocando tu puerta.")
		end
	else
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(50)

	while ESX.PlayerData == nil do
        Citizen.Wait(50)
	end
	
	cachedData["lastCheck"] = GetGameTimer() - 4750
	for k,v in pairs(Config.LandLord) do
		local pinkCageBlip = AddBlipForCoord(v.Position)

		SetBlipSprite(pinkCageBlip, 475)
		SetBlipScale(pinkCageBlip, 0.7)
		SetBlipColour(pinkCageBlip, 25)
		SetBlipAsShortRange(pinkCageBlip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(k)
		EndTextCommandSetBlipName(pinkCageBlip)
	end
	while true do
		local sleepThread = 500

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		local yourMotel = GetPlayerMotel()

		for k,v in pairs(Config.LandLord) do
			for _, motel in pairs(v.MotelsEntrances) do
				local motelRoom = motel.roomId
				local motelPos = motel.coords
				local dstCheck = GetDistanceBetweenCoords(pedCoords, motelPos, true)
				local dstRange = yourMotel and (yourMotel["room"] == motelRoom and 35.0 or 3.0) or 3.0
				if dstCheck <= dstRange then
					sleepThread = 5

					--[[DrawScriptMarker({
						["type"] = 2,
						["pos"] = motelPos,
						["r"] = 155,
						["g"] = 155,
						["b"] = 155,
						["sizeX"] = 0.3,
						["sizeY"] = 0.3,
						["sizeZ"] = 0.3,
						["rotate"] = true
					})]]

					if dstCheck <= 0.9 then
						local displayText = yourMotel and (yourMotel["room"] == motelRoom and "Presiona ~y~E~s~ para entrar<br>" or "") or ""; displayText = displayText .. "Presiona ~y~R~s~ para abrir el menú"

						if not cachedData["invited"] then
							DrawScriptText(motelPos - vector3(0.0, 0.0, 0.20), displayText)
						end

						if IsControlJustPressed(0, 38) then
							if yourMotel then
								if yourMotel["room"] == motelRoom then
									EnterMotel(yourMotel)
								end
							end
						elseif IsControlJustPressed(0, 45) then
							OpenMotelRoomMenu(motelRoom)
						end
					end
				end
			end
	
			local dstCheck = GetDistanceBetweenCoords(pedCoords, v.Position, true)

			if dstCheck <= 3.0 then
				sleepThread = 5

				if dstCheck <= 0.9 then
					local displayText = "Presiona ~y~E~s~ para alquilar habitación<br>Presiona ~y~R~s~ para cancelar alquiler"
					if not cachedData["purchasing"] then
						DrawScriptText(v.Position, displayText)
					end

					if IsControlJustPressed(0, 38) then
						_G["Open" .. v.Key]()
					end
					if IsControlJustPressed(0, 45) then
						ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_accept_motel", {
							["title"] = "¿Cancelar habitación? <br> Tu armario se perderá",
							["align"] = Config.AlignMenu,
							["elements"] = {
								{
									["label"] = "Sí, estoy seguro",
									["action"] = "yes"
								},
								{
									["label"] = "No, ¡Quieto!",
									["action"] = "no"
								}
							}
						}, function(menuData, menuHandle)
							local action = menuData["current"]["action"]
					
							if action == "yes" then
								ESX.TriggerServerCallback("motel:deleteMotel", function (confirmed)
									if confirmed then
										ESX.ShowNotification("~g~Cancelado ~w~alquiler")
										menuHandle.close()
									else
										ESX.ShowNotification("~r~No tienes habitación en este motel")
										menuHandle.close()
									end
								end)
							else
								menuHandle.close()
							end
						end, function(menuData, menuHandle)
							menuHandle.close()
						end)
					end
				end
			end
		end

		Citizen.Wait(sleepThread)
	end
end)