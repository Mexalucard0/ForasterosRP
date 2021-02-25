myInstance = 0
myInstancePlayers = {}

EnterInstance = function(instanceId)
    myInstance = instanceId
    TriggerServerEvent("motel:enterInstance",myInstance)
    --print("Id instancia "..instanceId)
    exports["mumble-voip"]:SetCallChannel(instanceId + 700)
    TriggerEvent('mumble:instanceVoice')
end

ExitInstance = function()
    exports["mumble-voip"]:SetCallChannel(0)
    TriggerEvent('mumble:exitInstanceVoice')
    TriggerServerEvent("motel:exitInstance",myInstance)
    myInstance = 0
    myInstancePlayers = {}
end

Citizen.CreateThread(function()
    Citizen.Wait(0)

    while true do
        local sleepThread = 500

        local ped = PlayerPedId()

        if cachedData["insideMotel"] then
            sleepThread = 5
         
            for _, player in pairs(GetActivePlayers()) do
                
                local playerId = GetPlayerServerId(player)
                --print("playerId: "..playerId)
                if inMyInstance(playerId) == false then
                    --print("No esta en mi instancia "..playerId)
                    local playerPed = GetPlayerPed(player)
                    if playerPed ~= ped  then
                        --print("No soy yo "..playerId)
                        if DoesEntityExist(playerPed) then
                            SetEntityCoords(playerPed)
                            SetEntityLocallyInvisible(playerPed)
                            SetEntityNoCollisionEntity(ped, playerPed, true)
                        end
                    end
                end
            end
        end

        Citizen.Wait(sleepThread)
    end
end)

function inMyInstance(id)
    local found = false
    for i=1, #myInstancePlayers do
        if myInstancePlayers[i] == id then
            found = true
            break
        end
    end
    return found
end

RegisterNetEvent("motel:receiveInstancePlayers")
AddEventHandler("motel:receiveInstancePlayers", function(instanceTable) 
    myInstancePlayers = instanceTable
end)
