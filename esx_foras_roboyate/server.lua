-------------------------------------
------- Created by Hamza#1234 -------
------------------------------------- 

local ESX 				= nil

local HeistTimer = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local YachtHeist 		= Config.Yacht

AddEventHandler('esx:playerLoaded', function(source)
    TriggerClientEvent('foras_roboyate:load', source, YachtHeist)
end)

RegisterServerEvent('foras_roboyate:refreshHeist')
AddEventHandler('foras_roboyate:refreshHeist', function()
    TriggerClientEvent('foras_roboyate:load', -1, YachtHeist)
end)

RegisterServerEvent('foras_roboyate:goonsSpawned')
AddEventHandler('foras_roboyate:goonsSpawned', function(id, status)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].GoonsSpawned=status
        TriggerClientEvent('foras_roboyate:statusGoonsSpawnedSend', -1, YachtHeist[id].pairs, status)
    end
    YachtHeist[id].GoonsSpawned=status
    TriggerClientEvent('foras_roboyate:statusGoonsSpawnedSend', -1, id, status)
end)

RegisterServerEvent('foras_roboyate:JobPlayer')
AddEventHandler('foras_roboyate:JobPlayer', function(id, status)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].JobPlayer=status
        TriggerClientEvent('foras_roboyate:statusJobPlayerSend', -1, YachtHeist[id].pairs, status)
    end
    YachtHeist[id].JobPlayer=status
    TriggerClientEvent('foras_roboyate:statusJobPlayerSend', -1, id, status)
end)

RegisterServerEvent('foras_roboyate:status')
AddEventHandler('foras_roboyate:status', function(id, status)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].started=status
        TriggerClientEvent('foras_roboyate:statusSend', -1, YachtHeist[id].pairs, status)
    end
    YachtHeist[id].started=status
    TriggerClientEvent('foras_roboyate:statusSend', -1, id, status)
end)

local policeOnline

ESX.RegisterServerCallback("foras_roboyate:GetPoliceOnline",function(source,cb)
	local Players = ESX.GetPlayers()
	policeOnline = 0
	for i = 1, #Players do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		if xPlayer["job"]["name"] == Config.PoliceDBname then
			policeOnline = policeOnline + 1
		end
	end
	if policeOnline >= Config.RequiredPolice then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('foras_roboyate:statusHack')
AddEventHandler('foras_roboyate:statusHack', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].keypadHacked=state
        TriggerClientEvent('foras_roboyate:statusHackSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].keypadHacked=state
    TriggerClientEvent('foras_roboyate:statusHackSend', -1, id, state)
end)

RegisterServerEvent('foras_roboyate:currentlyHacking')
AddEventHandler('foras_roboyate:currentlyHacking', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].currentlyHacking=state
        TriggerClientEvent('foras_roboyate:statusCurrentlyHackingSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].currentlyHacking=state
    TriggerClientEvent('foras_roboyate:statusCurrentlyHackingSend', -1, id, state)
end)

RegisterServerEvent('foras_roboyate:statusVault')
AddEventHandler('foras_roboyate:statusVault', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].vaultLocked=state
        TriggerClientEvent('foras_roboyate:statusVaultSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].vaultLocked=state
    TriggerClientEvent('foras_roboyate:statusVaultSend', -1, id, state)
end)

RegisterServerEvent('foras_roboyate:HeistIsBeingReset')
AddEventHandler('foras_roboyate:HeistIsBeingReset', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
	-- started:
	YachtHeist[id].started=false
    TriggerClientEvent('foras_roboyate:statusSend', -1, id, false)
	Citizen.Wait(1000)
	-- recently robbed:
	TriggerEvent("foras_roboyate:heistCooldown")
	YachtHeist[id].recentlyRobbed=true
    TriggerClientEvent('foras_roboyate:statusRecentlyRobbed', -1, id, true)
	-- hacked:
    YachtHeist[id].keypadHacked=false
    TriggerClientEvent('foras_roboyate:statusHackSend', -1, id, false)
	-- currently hacking:
    YachtHeist[id].currentlyHacking=false
    TriggerClientEvent('foras_roboyate:statusCurrentlyHackingSend', -1, id, false)
	-- vault:
    YachtHeist[id].vaultLocked=true
    TriggerClientEvent('foras_roboyate:statusVaultSend', -1, id, true)
	-- safe:
    YachtHeist[id].safeRobbed=false
    TriggerClientEvent('foras_roboyate:statusSafeRobbedSend', -1, id, false)
	-- drilling:
    YachtHeist[id].drilling=false
    TriggerClientEvent('foras_roboyate:statusDrillingSend', -1, id, false)
	-- cashTaken:
    YachtHeist[id].cashTaken=false
    TriggerClientEvent('foras_roboyate:statusCashTakenSend', -1, id, false)
	-- stealing:
    YachtHeist[id].stealing=false
    TriggerClientEvent('foras_roboyate:statusStealingSend', -1, id, false)
	-- GoonsSpawned:
    YachtHeist[id].GoonsSpawned=false
    TriggerClientEvent('foras_roboyate:statusGoonsSpawnedSend', -1, id, false)
	-- JobPlayer:
    YachtHeist[id].JobPlayer=status
    TriggerClientEvent('foras_roboyate:statusJobPlayerSend', -1, id, status)
end)

RegisterServerEvent('foras_roboyate:drilling')
AddEventHandler('foras_roboyate:drilling', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].drilling=state
        TriggerClientEvent('foras_roboyate:statusDrillingSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].drilling=state
    TriggerClientEvent('foras_roboyate:statusDrillingSend', -1, id, state)
end)

RegisterServerEvent('foras_roboyate:stealing')
AddEventHandler('foras_roboyate:stealing', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].stealing=state
        TriggerClientEvent('foras_roboyate:statusStealingSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].stealing=state
    TriggerClientEvent('foras_roboyate:statusStealingSend', -1, id, state)
end)

RegisterServerEvent('foras_roboyate:cashTaken')
AddEventHandler('foras_roboyate:cashTaken', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].cashTaken=state
        TriggerClientEvent('foras_roboyate:statusCashTakenSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].cashTaken=state
    TriggerClientEvent('foras_roboyate:statusCashTakenSend', -1, id, state)
end)

RegisterServerEvent('foras_roboyate:safeRobbed')
AddEventHandler('foras_roboyate:safeRobbed', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].safeRobbed=state
        TriggerClientEvent('foras_roboyate:statusSafeRobbedSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].safeRobbed=state
    TriggerClientEvent('foras_roboyate:statusSafeRobbedSend', -1, id, state)
	
	if policeOnline > 5 then
		policeReward = 5
	else
		policeReward = policeOnline
	end
	local cashReward = 0
	local itemReward = 0
	if Config.RewardBasedOnCops then
		cashReward = ((math.random(Config.SafeMinCash,Config.SafeMaxCash) * 1000) * policeReward)
		itemReward = ((math.random(Config.SafeMinItem,Config.SafeMaxItem) * 10) * policeReward)
	else
		cashReward = (math.random(Config.SafeMinCash,Config.SafeMaxCash) * 1000)
		itemReward = (math.random(Config.SafeMinItem,Config.SafeMaxItem) * 10)
	end
	xPlayer.addInventoryItem(Config.SafeBoxItem,itemReward)
	xPlayer.addMoney(cashReward)
	TriggerClientEvent("esx:showNotification",source,"You received: ~r~$"..cashReward.."~s~ money and ~b~"..itemReward.."x~s~ ~y~Gold Watches~s~")
end)

ESX.RegisterServerCallback("foras_roboyate:updateCashTaken",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if policeOnline > 5 then
		policeReward = 5
	else
		policeReward = policeOnline
	end
	if xPlayer then
		local randomMoney = 0
		if Config.RewardBasedOnCops then
			randomMoney = ((CashTake * 100) * policeReward)
		else
			randomMoney = (CashTake * 100)
		end
		xPlayer.addMoney(randomMoney)
		cb(randomMoney)
	end
end)

-- Server Callback to get inventory hackerDevice:
ESX.RegisterServerCallback("foras_roboyate:getHackerDevice",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(Config.HackerDevice).count >= 1 then
		cb(true)
	else
		cb(false)
		TriggerClientEvent("esx:showNotification",source,"You need a ~y~Hacker Device~s~ to hack the terminal!")
	end
end)

-- Server Callback to get inventory drill:
ESX.RegisterServerCallback("foras_roboyate:getDrillItem",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(Config.DrillItem).count >= 1 then
		cb(true)
	else
		cb(false)
		TriggerClientEvent("esx:showNotification",source,"You need a ~y~Drill~s~ to drill the safe!")
	end
end)

ESX.RegisterServerCallback("foras_roboyate:getCooldownHeist",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if YachtHeist[1].recentlyRobbed == false then
		cb(true)
	else
		cb(false)
		TriggerClientEvent("esx:showNotification",source,string.format("New heist available in: ~b~%s minutes~s~",GetCooldownTimer()))
	end
end)

-- server side for cooldown timer
RegisterServerEvent("foras_roboyate:heistCooldown")
AddEventHandler("foras_roboyate:heistCooldown",function()
	table.insert(HeistTimer,{time = (Config.CooldownTimer * 60000)}) -- cooldown timer for doing missions
end)

-- thread for syncing the cooldown timer
Citizen.CreateThread(function() -- do not touch this thread function!
	while true do
	Citizen.Wait(1000)
		for k,v in pairs(HeistTimer) do
			if v.time <= 0 then
				YachtHeist[1].recentlyRobbed=false
				TriggerClientEvent('foras_roboyate:statusRecentlyRobbed', -1, 1, false)
			else
				v.time = v.time - 1000
			end
		end
	end
end)

function GetCooldownTimer()
	for k,v in pairs(HeistTimer) do
		if v.time > 0 then
			return math.ceil(v.time/60000)
		end
	end
end
