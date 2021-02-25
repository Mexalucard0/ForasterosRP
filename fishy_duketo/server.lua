ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('fishy:duketo:getinfo')
AddEventHandler('fishy:duketo:getinfo', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local job
	if xPlayer ~= nil then
		if xPlayer.job.label == xPlayer.job.grade_label then
			job = xPlayer.job.grade_label
		else
			job = xPlayer.job.label .. ' | ' .. xPlayer.job.grade_label
		end

		local info = {
			job = job,
			money = xPlayer.getMoney(),
			bankMoney = xPlayer.getAccount('bank').money,
			blackMoney = xPlayer.getAccount('black_money').money
		}

		TriggerClientEvent('fishy_duketo:setinfo', source, info)
	end
end)
