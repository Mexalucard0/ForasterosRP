local holdingup = false
local bank = ""
local secondsRemaining = 0
local blipRobbery = nil
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - width/1.530, y - height/0.75)
end

RegisterNetEvent('esx_foras_farmacia:currentlyrobbing')
AddEventHandler('esx_foras_farmacia:currentlyrobbing', function(robb)
	holdingup = true
	bank = robb
	secondsRemaining = 420
end)

RegisterNetEvent('esx_foras_farmacia:killblip')
AddEventHandler('esx_foras_farmacia:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_foras_farmacia:setblip')
AddEventHandler('esx_foras_farmacia:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_foras_farmacia:toofarlocal')
AddEventHandler('esx_foras_farmacia:toofarlocal', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)


RegisterNetEvent('esx_foras_farmacia:robberycomplete')
AddEventHandler('esx_foras_farmacia:robberycomplete', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_complete') .. Banks[bank].reward)
	bank = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('esx_foras_farmacia:startpendrive')
AddEventHandler('esx_foras_farmacia:startpendrive', function(source)
	ExecuteCommand('me inserta el pendrive')
	ExecuteCommand('do se verían cosas extrañas pasar en la pantalla')
	PendriveAnimation()
end)

function PendriveAnimation()
	local playerPed = GetPlayerPed(-1)
	SetEntityCoords(playerPed, -251.39, 6325.91, 32.44, 0, 0, 0, false)
	SetEntityHeading(playerPed, 137.05)
	
	ESX.Streaming.RequestAnimDict('anim@heists@ornate_bank@hack', function()
		TaskPlayAnim(playerPed, 'anim@heists@ornate_bank@hack', 'hack_enter', 1.0, -1.0, 4800, 0, 1, true, true, true)
		Citizen.Wait(4900)
		ClearPedSecondaryTask(playerPed)
		EnableAllControlActions()
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if holdingup then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(Banks)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 51)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 1)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('bank_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)
incircle = false

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Banks)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
					DrawMarker(27, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 1.5001, 76, 190, 253, 100, 0, 0, 0, 1)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						ESX.ShowFloatingHelpNotification(_U('press_to_rob') .. v.nameofbank, vector3(pos2.x, pos2.y, pos2.z +1))
						incircle = true
						if IsControlJustReleased(1, 51) then
							TriggerServerEvent('esx_foras_farmacia:rob', k)
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then

			drawTxt(0.90, 2.25, 1.0,1.0,0.4, _U('robbery_of') .. secondsRemaining .. _U('seconds_remaining'), 255, 255, 255, 255)

			local pos2 = Banks[bank].position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
				TriggerServerEvent('esx_foras_farmacia:toofar', bank)
			end
		end

		Citizen.Wait(0)
	end
end)