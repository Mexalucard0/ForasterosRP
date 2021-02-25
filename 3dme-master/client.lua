-- ## 3dme : client side
ESX = nil

Citizen.CreateThread(function()
    while not ESX do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)
-- ## Variables
local pedDisplaying = {}

-- ## Functions

-- OBJ : draw text in 3d
-- PARAMETERS :
--      - coords : world coordinates to where you want to draw the text
--      - text : the text to display
local function DrawText3D(coords, text)
    ESX.ShowFloatingHelpNotification(text, vector3(coords.x, coords.y, coords.z))
end

-- OBJ : handle the drawing of text above a ped head
-- PARAMETERS :
--      - coords : world coordinates to where you want to draw the text
--      - text : the text to display
local function Display(ped, text)

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local pedCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - pedCoords)

    if dist <= Config.visual.dist then

        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1

        -- Timer
        local display = true

        Citizen.CreateThread(function()
            Wait(Config.visual.time)
            display = false
        end)

        -- Display
        local offset = 0.8 + pedDisplaying[ped] * 0.1
        while display do
            if HasEntityClearLosToEntity(playerPed, ped, 17 ) then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                z = z + offset
                DrawText3D(vector3(x, y, z), text)
            end
            Wait(0)
        end

        pedDisplaying[ped] = pedDisplaying[ped] - 1

    end
end

-- ## Events

-- Share the display of 3D text
RegisterNetEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, serverId)
    local player = GetPlayerFromServerId(serverId)
    if player ~= -1 then
        local ped = GetPlayerPed(player)
        Display(ped, text)
    end
end)

RegisterNetEvent('3ddo:shareDisplay')
AddEventHandler('3ddo:shareDisplay', function(text, serverId)
    local player = GetPlayerFromServerId(serverId)
    if player ~= -1 then
        local ped = GetPlayerPed(player)
        Display(ped, text)
    end
end)


local LANGUAGE = Config.language
TriggerEvent('chat:addSuggestion', '/' .. Languages[LANGUAGE].commandName, Languages[LANGUAGE].commandDescription, Languages[LANGUAGE].commandSuggestion)
