ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('foras_chatarra:search')
AddEventHandler('foras_chatarra:search', function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    local randomNumber = math.random(0, Config.NoLuckPercentage)
    if randomNumber <= 10 then
        xPlayer.addInventoryItem('chatarra', 1)
        TriggerClientEvent("mole_notifications:SendNotification", {text = 'Has recibido 1x Chatarra', type = "info", timeout = 1400})
        TriggerClientEvent('esx:showNotification', source, 'Has recibido 1x Chatarra')
    else
        TriggerClientEvent("mole_notifications:SendNotification", {text = "Este basurero no tenia nada", type = "error", timeout = 1400})
        print('nada puta')
        TriggerClientEvent('esx:showNotification', source, 'Este basurero no tenia nada')
    end
end)

RegisterServerEvent('foras_chatarra:sell')
AddEventHandler('foras_chatarra:sell', function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    local inventory   = xPlayer.inventory
    local item = xPlayer.getInventoryItem('chatarra')
    print(item.count)
    if item.count >= 1 then
        xPlayer.addMoney(item.count * 25)
        xPlayer.removeInventoryItem('chatarra', item.count)
        TriggerClientEvent('esx:showNotification', source, 'Has vendido ' .. item.count .. ' de chatarra por $' .. item.count * 25)
    elseif item.count == 0 then
        TriggerClientEvent('esx:showNotification', source, 'No tienes ~y~Chatarra~w~ Regresa cuando tengas.')
    end
end)