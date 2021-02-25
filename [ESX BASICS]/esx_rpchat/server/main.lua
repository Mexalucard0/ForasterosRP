ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('es:invalidCommandHandler', function(source, command_args, user)
	CancelEvent()
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', _U('unknown_command', command_args[1]) } })
end)

RegisterCommand('ooc', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	--DrawOnHead(source, args,{ r = 255, g = 50, b = 0, alpha = 200 })
	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('ooc_prefix', ''..source..' '..name), args, { 255, 153, 153, 0 })
	
end, false)

RegisterCommand('civil', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	--DrawOnHead(source, args,{ r = 255, g = 50, b = 0, alpha = 200 })
	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('civil_prefix', ''..source..' '), args, { 255, 255, 153, 0 })
	
end, false)

RegisterCommand('ayuda', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('ayuda_prefix', '['..source..'] '..name), args }, color = { 255, 100, 0 } })
	--print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('id', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	--DrawOnHead(source, args,{ r = 255, g = 50, b = 0, alpha = 200 })
	TriggerClientEvent('chat:addMessage', -1, { args = { _U('id_prefix', ''..source..' '), args }, color = { 255, 0, 255 } })
	
end, false)

RegisterCommand('msg', function(source, args, user)

	if GetPlayerName(tonumber(args[1])) then
		local player = tonumber(args[1])
		table.remove(args, 1)
		
		TriggerClientEvent('chat:addMessage', player, {args = {"^5[MSG] "..GetPlayerName(source).. " [" .. source .. "] : ^7" ..table.concat(args, " ")}, color = {255, 255, 255}})
		TriggerClientEvent('chat:addMessage', source, {args = {"^1Has Enviado un MSG a  ^4"..GetPlayerName(player).. "^6 [" .. player .. "] ^3[con el mensaje]: ^0" ..table.concat(args, " ")}, color = {255, 153, 0}})

	else
		TriggerClientEvent('chatMessage', source, "SISTEMA", {255, 0, 0}, "ID de jugador incorrecta!")
	end

end,false)


RegisterCommand('taxi', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "taxi" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('taxi_prefix', name), args }, color = { 255, 227, 51 } })

	end
end, false)



RegisterCommand('mecanico', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "mechanic" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('meca_prefix', name), args }, color = { 102, 255, 153 } })

	end
end, false)


RegisterCommand('lspd', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "police" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('pol_prefix', name), args }, color = { 94, 161, 224 } })

	end
end, false)

RegisterCommand('cas', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "casino" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('cas_prefix', name), args }, color = { 102, 0, 102 } })

	end
end, false)

RegisterCommand('lsfd', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "ambulance" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('ems_prefix', name), args }, color = { 255, 51, 51 } })

	end
end, false)


RegisterCommand('twt', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('twt_prefix', name), args }, color = { 151, 19, 19} })
	
end, false)


RegisterCommand('cambiara/anoncuandoqueraiselanonimodetwitter', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('anon_prefix', '['..source..'] '), args }, color = { 0, 153, 204 } })
	
end, false)

RegisterCommand('me', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	DrawOnHead(source, args,{ r = 255, g = 50, b = 0, alpha = 200 })
	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('me_prefix', '['..source..'] '..name), args, { 204, 0, 104 })
	
end, false)


RegisterCommand('do', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
    DrawOnHead(source, args, { r = 0, g = 120, b = 255, alpha = 200 })
	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('do_prefix', '['..source..'] '..name), args, { 255, 187, 51 })
	
end, false)

RegisterCommand('oop', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('oop_prefix', '['..source..'] '..name), args, { 85, 85, 85 })
	--print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('change', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('change_prefix', '['..source..'] '), args }, color = { 146, 40, 191 } })
	--print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('f', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('f_prefix', '['..source..'] '..name), args }, color = { 146, 40, 191 } })
	--print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('insta', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('insta_prefix', name), args }, color = { 146, 40, 191 } })
	--print(('%s: %s'):format(name, args))
end, false)


function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})

	if result[1] and result[1].firstname and result[1].lastname then
		if Config.OnlyFirstname then
			return result[1].firstname
		else
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	else
		return GetPlayerName(source)
	end
end
local logEnabled = true

function DrawOnHead(playerid, text, color)
	TriggerClientEvent('esx_rpchat:drawOnHead', -1, text, color, playerid)
end
