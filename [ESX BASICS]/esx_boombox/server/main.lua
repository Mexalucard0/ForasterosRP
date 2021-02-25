ESX = nil
xSound = exports.xsound
local boomBoxes = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('boombox', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	TriggerClientEvent('esx_boombox:place_boombox', source)
	xPlayer.removeInventoryItem('boombox', 1)
	xPlayer.showNotification(_U('put_boombox'))
end)

RegisterServerEvent('esx_boombox:remove_boombox')
AddEventHandler('esx_boombox:remove_boombox', function(coords, boomboxName)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('boombox', 1) then
		xPlayer.addInventoryItem('boombox', 1)
		boomBoxes[boomboxName] = nil
	end
end)

RegisterServerEvent('esx_boombox:play_music')
AddEventHandler('esx_boombox:play_music', function(idMusic, url, volume, pos)
	xSound:PlayUrlPos(-1, idMusic, url, volume, pos)
	xSound:Distance(-1, idMusic, Config.distance)
	boomBoxes[idMusic] = pos
end)

RegisterServerEvent('esx_boombox:stop_music')
AddEventHandler('esx_boombox:stop_music', function(idMusic)
	xSound:Destroy(-1, idMusic)
end)

RegisterServerEvent('esx_boombox:set_volume')
AddEventHandler('esx_boombox:set_volume', function(idMusic, volume)
	xSound:setVolume(-1, idMusic, volume)
end)

function GetBoomBoxes()
	return boomBoxes
end

RegisterServerEvent('esx_boombox:set_boombox')
AddEventHandler('esx_boombox:set_boombox', function(boombox, coords)
	boomBoxes[boombox] = coords
end)

RegisterCommand("removeSounds", function(source, args, rawCommand)
	if boomBoxes ~= nil then
		if source == 0 then
				for id,pos in pairs(boomBoxes) do
					xSound:Destroy(-1, id)
				end
		else
			local xPlayer = ESX.GetPlayerFromId(source)
			if(hasPermissions(xPlayer)) then
				for id,pos in pairs(boomBoxes) do
					xSound:Destroy(-1, id)
				end
				xPlayer.showNotification(_U('sounds_destroyed'), false, true, 210)
			else
				xPlayer.showNotification("Insufficient Permissions.", false, true, 130)
			end
		end
	end
end, false)

RegisterCommand("boombox", function(source, args, rawCommand)
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if(hasPermissions(xPlayer)) then
			TriggerClientEvent('esx_boombox:boomboxes_menu', source, boomBoxes)
		else
			xPlayer.showNotification("Insufficient Permissions.", false, true, 130)
		end
	end
end, false)

ESX.RegisterServerCallback('esx_boombox:GetBoomBoxes', function(source,cb) cb(GetBoomBoxes() or nil); end)