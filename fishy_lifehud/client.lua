Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.getPercent()
        end)
        Citizen.Wait(200)
        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.getPercent()
        end)
        Citizen.Wait(200)
        TriggerEvent('esx_status:getStatus', 'stress', function(status)
            stress = status.getPercent()
        end)
        Citizen.Wait(200)
    end
    Citizen.Wait(200)
end)


Citizen.CreateThread(function()
    Citizen.Wait(200)
    SendNUIMessage({
        action = 'showui'
    })
    while true do
        
        local player = PlayerPedId()
        SendNUIMessage({
            action = 'tick',
            source = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))),
            show = IsPauseMenuActive(),
            health = (GetEntityHealth(player) - 100),
            armor = GetPedArmour(player),
        })

        SendNUIMessage({
            action = 'Status',
            hunger = hunger,
            thirst = thirst,
            stress = stress,
            stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
        })
        Citizen.Wait(200)
    end
end)



Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)
