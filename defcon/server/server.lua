ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("alertas", function(source)
local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'police' then
        TriggerClientEvent("PoliceAlerts", source)
    else
        print("No eres policia")
    end
end, false)

NivelDeAlerta = 0

RegisterServerEvent('macaco_alerts:tac0')
AddEventHandler('macaco_alerts:tac0', function()
    NivelDeAlerta = 0
end)

RegisterServerEvent('macaco_alerts:tac1')
AddEventHandler('macaco_alerts:tac1', function()
    NivelDeAlerta = 1
end)

RegisterServerEvent('macaco_alerts:tac2')
AddEventHandler('macaco_alerts:tac2', function()
    NivelDeAlerta = 2
end)

RegisterServerEvent('macaco_alerts:tac3')
AddEventHandler('macaco_alerts:tac3', function()
    NivelDeAlerta = 3
end)

RegisterServerEvent('macaco_alerts:tac4')
AddEventHandler('macaco_alerts:tac4', function()
    NivelDeAlerta = 4
end)

RegisterServerEvent('macaco_alerts:tac5')
AddEventHandler('macaco_alerts:tac5', function()
    NivelDeAlerta = 5
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if NivelDeAlerta == 0 then
    	TriggerClientEvent('macaco_alerts:tac0_c', -1)
    elseif NivelDeAlerta == 1 then
    	TriggerClientEvent('macaco_alerts:tac1_c', -1)
    elseif NivelDeAlerta == 2 then
        TriggerClientEvent('macaco_alerts:tac2_c', -1)
    elseif NivelDeAlerta == 3 then
        TriggerClientEvent('macaco_alerts:tac3_c', -1)
    elseif NivelDeAlerta == 4 then
        TriggerClientEvent('macaco_alerts:tac4_c', -1)
    elseif NivelDeAlerta == 5 then
    	TriggerClientEvent('macaco_alerts:tac5_c', -1)
    end
end
end)
