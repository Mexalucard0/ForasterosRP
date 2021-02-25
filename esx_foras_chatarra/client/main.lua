ESX = nil
local cachedBins = {}
local closestBin = nil
local isNearBin = false
local isESXLoaded = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5)
    end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    PlayerData = ESX.GetPlayerData()
    
    isESXLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)


Citizen.CreateThread(function()
    while isESXLoaded == false do Citizen.Wait(5) end
    while true do
        isNearBin = IsNearBin()
        Citizen.Wait(2000)
    end
end)

Citizen.CreateThread(function()
    while isESXLoaded == false do Citizen.Wait(5) end

    while true do
        if isNearBin then
            local binCoords = GetEntityCoords(closestBin)

            ESX.ShowFloatingHelpNotification(
                'Presiona ~y~E~s~ para rebuscar en la basura',
                binCoords + vector3(0.0, 0.0, 1.0))

            if IsControlJustReleased(0, 38) then
                table.insert(cachedBins, closestBin)

                if #cachedBins >= Config.MaxBinsToExplore then
                    table.remove(cachedBins, 1)
                end

                OpenTrashCan()
            end
        end
        Citizen.Wait(5)
    end
end)

function IsNearBin()
    local player = GetPlayerPed(-1)
    local playerloc = GetEntityCoords(player, 0)
    for i = 1, #Config.BinsAvailable do
        local entity = GetClosestObjectOfType(playerloc, 1.0, GetHashKey(
                                                  Config.BinsAvailable[i]),
                                              false)

        if DoesEntityExist(entity) and not IsBinCached(entity) then
            closestBin = entity
            return true
        end
    end
    return false
end

function IsBinCached(bin)
    local found = false

    for k, v in pairs(cachedBins) do 
        if v == bin then 
            found = true 
        end 
    end

    return found
end

function OpenTrashCan()
    TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
    exports['mole_notifications']:MoleShowProgressBar(9000, 'Rebuscando...')
    Citizen.Wait(9500)
    TriggerServerEvent('foras_chatarra:search')
    PlaySound(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', 0, 0, 1)
    ClearPedTasks(PlayerPedId())
end

-- VENDER --
Citizen.CreateThread(function()
    while true do
        local player = GetPlayerPed(-1)
        local distance = GetDistanceBetweenCoords(GetEntityCoords(player), Config.SellPoint, true)
        if distance <= Config.DistanceToDrawMarker and isInJob() then
            DrawMarker(27, Config.SellPoint, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.2, 1.2, 0.4), 76, 190, 253, 100, false, false, false, true)
            if distance <= 1.5 then
                ESX.ShowFloatingHelpNotification('Presiona ~y~E~s~ para abrir el menu', vector3(Config.SellPoint.x, Config.SellPoint.y, Config.SellPoint.z + 2))
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('foras_chatarra:sell')
                    Citizen.Wait(2000)
                end
            end
        end
        Citizen.Wait(1)
    end
end)


function isInJob()
    for k, v in pairs(Config.AllowedJobs) do
        if PlayerData ~= nil and (PlayerData.job.name == v) then
            return true
        else
            return false
        end
    end
end