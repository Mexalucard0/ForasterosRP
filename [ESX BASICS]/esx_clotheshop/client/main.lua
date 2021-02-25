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

ESX                           = nil
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionMsgCoords  = nil
local CurrentActionData       = {}
local HasPaid                 = false
local HasOpenedMenu 		  = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OpenShopMenu()
	HasOpenedMenu = true
	HasPaid = false

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', 
		{
			title = _U('valid_this_purchase'),
			align = 'bottom-right',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
			}
		}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				ESX.TriggerServerCallback('esx_clotheshop:buyClothes', function(bought)
					if bought then
						TriggerEvent('skinchanger:getSkin', function(skin)
							TriggerServerEvent('esx_skin:save', skin)
						end)

						HasPaid = true

						ESX.TriggerServerCallback('esx_clotheshop:checkPropertyDataStore', function(foundStore)
							if foundStore then
								ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'save_dressing',
								{
									title = _U('save_in_dressing'),
									align = 'bottom-right',
									elements = {
										{label = _U('no'),  value = 'no'},
										{label = _U('yes'), value = 'yes'}
									}
								}, function(data2, menu2)
									menu2.close()

									if data2.current.value == 'yes' then
										ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
											title = _U('name_outfit')
										}, function(data3, menu3)
											if data3.value ~= nil and data3.value ~= '' then
												TriggerEvent('skinchanger:getSkin', function(skin)
													TriggerServerEvent('esx_clotheshop:saveOutfit', data3.value, skin)
												end)
												ESX.ShowNotification(_U('saved_outfit'))
												menu3.close()
											else
												ESX.ShowNotification("Debes de introducir un nombre.")
												return
											end
										end, function(data3, menu3)
											menu3.close()
										end)
									end
								end)
							end
						end)

					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)

						ESX.ShowNotification(_U('not_enough_money'))
					end
				end)
			elseif data.current.value == 'no' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_menu')
			CurrentActionData = {}
		end, function(data, menu)
			menu.close()
			HasOpenedMenu = false
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_menu')
			CurrentActionData = {}
		end)

	end, function(data, menu)
		menu.close()
		HasOpenedMenu = false
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('press_menu')
		CurrentActionData = {}

	end, {
		'tshirt_1',
		'tshirt_2',
		'torso_1',
		'torso_2',
		'decals_1',
		'decals_2',
		'arms',
		'arms_2',
		'pants_1',
		'pants_2',
		'shoes_1',
		'shoes_2',
		'chain_1',
		'chain_2',
		'watches_1',
		'watches_2',
		'bracelets_1',
		'bracelets_2',
		'bags_1',
		'bags_2',
		'mask_1',
		'mask_2',
		'bproof_1',
		'bproof_2',
		'chain_1',
		'chain_2',
		'helmet_1',
		'helmet_2',
		'glasses_1',
		'glasses_2',
		'watches_1',
		'watches_2',
		'ears_1',
		'ears_2'
	})

end

AddEventHandler('esx_clotheshop:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_menu')
	CurrentActionData = {}
end)

AddEventHandler('esx_clotheshop:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil

	if HasOpenedMenu and not HasPaid then
		TriggerEvent('esx_skin:getLastSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
			TriggerEvent('dpc:ApplyClothing')
		end)
	end
end)

-- Create Blips
Citizen.CreateThread(function()
    for i=1, #Config.Shops, 1 do
        if Config.Shops[i].blip == true then
          local blip = AddBlipForCoord(Config.Shops[i].x, Config.Shops[i].y, Config.Shops[i].z)

          SetBlipSprite (blip, 73)
          SetBlipDisplay(blip, 4)
          SetBlipScale  (blip, 0.7)
          SetBlipColour (blip, 47)
          SetBlipAsShortRange(blip, true)

          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString(_U('clothes'))
          EndTextCommandSetBlipName(blip)
        end
    end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local coords = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, true, false, false, false)
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				CurrentActionMsgCoords = vector3(v.Pos.x, v.Pos.y, v.Pos.z +2)
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_clotheshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_clotheshop:hasExitedMarker', LastZone)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then
			ESX.ShowFloatingHelpNotification(CurrentActionMsg, CurrentActionMsgCoords)

			if IsControlJustReleased(0, Keys['E']) then
				OpenShopMenu()
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)
