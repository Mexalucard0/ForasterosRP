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

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_jailclothes:preso')
AddEventHandler('esx_jailclothes:preso', function(isFemale)
	TriggerEvent('skinchanger:getSkin', function(skin)
		
		local clothesSkin = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1']  = 146+84, ['torso_2']  = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 0,   
			['pants_1']  = 3,   ['pants_2']  = 7,   
			['shoes_1']  = 12,	['shoes_2']  = 12,  
			['chain_1']  = 0,	['chain_2']  = 0
		}
		if isFemale then
			 clothesSkin = {
				['tshirt_1'] = 15,   ['tshirt_2'] = 0,
				['torso_1']  = 202,  ['torso_2']  = 2,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms']     = 4,   
				['pants_1']  = 150,	['pants_2']  = 6,  
				['shoes_1']  = 1,	['shoes_2']  = 1,   
				['chain_1']  = 0,	['chain_2']  = 2
			}
		end
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

AddEventHandler('esx_jailclothes:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = 'Presiona ~y~E~s~ para acceder al menu'
end)

AddEventHandler('esx_jailclothes:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

function OpenMainMenu()
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', 
	function(skin, jobSkin)
		local elements = {}

		table.insert(elements, {label = ('Recuperar tu ropa'), value = 'restore'})
		table.insert(elements, {label = ('Ropa de preso'), value = 'preso'})
		
		ESX.UI.Menu.CloseAll()	

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'action_menu',
		{
			title    = ('Prisión'),
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)
			if data.current.value == 'restore' then			
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
				ESX.UI.Menu.CloseAll()	
			elseif data.current.value == 'preso' then
				TriggerEvent('esx_jailclothes:preso', skin.sex == 1)
				ESX.UI.Menu.CloseAll()	
			end
		end)
	end)
end

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
			TriggerEvent('esx_jailclothes:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_jailclothes:hasExitedMarker', LastZone)
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
				OpenMainMenu()
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)