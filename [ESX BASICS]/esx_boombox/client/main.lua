Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
xSound = exports.xsound
local menuOpen = false
local adminMenuOpen = false
local wasOpen = false
local lastEntity = nil
local currentAction = nil
local currentData = nil
local boomBoxName = nil
local boomBoxOwner = "nil"

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx_boombox:place_boombox_allowed")
AddEventHandler("esx_boombox:place_boombox_allowed", function()
    local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_boombox_01"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance  = GetDistanceBetweenCoords(coords, objCoords, true)
        if(distance < Config.Distance)then
            TriggerServerEvent("esx_boombox:set_boombox_allowed", false)
            return
        end
    end
    TriggerServerEvent("esx_boombox:set_boombox_allowed", true)
end)
RegisterNetEvent("esx_boombox:place_boombox")
AddEventHandler("esx_boombox:place_boombox", function()
	local playerPed = PlayerPedId()
	local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    startAnimation("anim@heists@money_grab@briefcase","put_down_case")
    Citizen.Wait(1000)
    ClearPedTasks(PlayerPedId())
    ESX.Game.SpawnObject("prop_boombox_01", objectCoords, function(obj)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(obj)
        boomBoxName = GetPlayerName(PlayerId()) .. "_boombox"
        boomBoxOwner = GetPlayerName(PlayerId())
        TriggerServerEvent("esx_boombox:set_boombox", boomBoxName, objectCoords)
        Citizen.Wait(1000)
        if not DoesEntityExist(obj) then
            TriggerServerEvent("esx_boombox:remove_boombox", objectCoords, boomBoxName)
            currentData = nil
            ESX.ShowNotification("No se pudo colocar la radio")
        else
            ESX.ShowNotification(_U('put_boombox'))
        end
    end)
end)

function OpenBoomboxMenu()
    menuOpen = true
    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "boombox", {
        title   = _U("boombox_menu_title"),
        align   = Config.menuAlignment,
        elements = {
            {label = _U("get_boombox"), value = "get_boombox"},
            {label = _U("play_music"), value = "play"},
            {label = 'Poner emisora de radio', value = "playradio"},
            {label = _U("volume_music"), value = "volume"},
            {label = _U("stop_music"), value = "stop"}
        }
    }, function(data, menu)
        local playerPed = PlayerPedId()
        local lCoords = GetEntityCoords(playerPed)
        if data.current.value == "get_boombox" then
            menuOpen = false
            menu.close()
            pickupBoomBox(lCoords)
        elseif data.current.value == "play" then
            play(lCoords)
        elseif data.current.value == "stop" then
            if xSound:soundExists(boomBoxName) then
                stop(lCoords)
                menuOpen = false
                menu.close()
            else
                TriggerEvent("esx:showNotification", _U("not_found"))
                menu.close()
            end
        elseif data.current.value == "volume" then
            setVolume(lCoords)
        elseif data.current.value == "playradio" then
            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "boomboxr", {
                title   = _U("boombox_menu_title"),
                align   = Config.menuAlignment,
                elements = {
                    { value = "http://icecast.molecorp.club:8000/stream", volume = 1.0, label = "MOLECORP FM" },
                    { value = "http://flucast-m05-04.flumotion.com/cope/rockfm.mp3", volume = 0.8, label = "ROCK FM" },
                    { value = "http://20133.live.streamtheworld.com/LOS40.mp3", volume = 0.8, label = "LOS40" },
                    { value = "https://20853.live.streamtheworld.com/OWR_INTERNATIONAL.mp3?s=1425918835", volume = 0.8, label = "TOMORROWLAND" },
                    { value = "http://flucast-b03-03.flumotion.com/cope/megastar.mp3", volume = 0.8, label = "MEGASTAR FM" },
                    { value = "http://flucast-b06-01.flumotion.com/cope/net2.mp3", volume = 0.8, label = "LA COPE" },
                    { value = "http://22323.live.streamtheworld.com/LOS40_CLASSIC.mp3", volume = 0.8, label = "LOS40 CLASSIC" },
                    { value = "http://kissfm.kissfmradio.cires21.com/kissfm.mp3", volume = 0.8, label = "KISS FM" },
                    { value = "http://sc8.streammystation.com:7430/stream", volume = 0.8, label = "WKNC FM" },
                    { value = "https://str2b.openstream.co/540?aw_0_1st.collectionid=3077&stationId=3077&publisherId=564", volume = 0.6, label = "REGGAETON FM" },
                    { value = "http://69.175.13.130:8110/", volume = 0.8, label = "HOT FM" },
                    { value = "http://allzic01.ice.infomaniak.ch/allzic01.mp3", volume = 0.8, label = "RAP FM" },
                    { value = "http://air.radiorecord.ru:805/hbass_320", volume = 0.8, label = "HARDBASS RU FM" },
                    { value = "http://149.56.185.83:8164/stream", volume = 0.8, label = "Fusion Hip Hop" },
                    { value = "https://icecast.unitedradio.it/105Trap.mp3", volume = 0.8, label = "105 Trap ITA FM" },
                    { value = "http://100newwave.ice.infomaniak.ch/100poprock.mp3", volume = 0.8, label = "100 Pop Rock" },
                    { value = "http://198.50.235.3:20006/stream", volume = 0.8, label = "Otaku FM" },
                    { value = "http://37.59.254.31:8024/;?type=http&nocache=137839", volume = 0.9, label = "IBIZA GLOBAL RADIO" },
                }
            }, function(data2, menu2)
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
                local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_boombox_01"), false, false, false)
                local objCoords = GetEntityCoords(object)
                TriggerServerEvent("esx_boombox:play_music", boomBoxName, data2.current.value, 1, objCoords)
                TriggerServerEvent("esx_boombox:set_volume", boomBoxName, data2.current.volume)
                ESX.ShowNotification("Cargando emisora " .. data2.current.label)
                menuOpen = false
                menu2.close()
            end, function(data2, menu2)
                    menuOpen = false
                    menu2.close()
                end)
        end
    end, function(data, menu)
        menuOpen = false
        menu.close()
    end)
end

function OpenAdminMenu(boomBoxes)
    local elements = {}
    adminMenuOpen = true
    if boomBoxes == nil then
        ESX.ShowNotification(_U('no_boomboxes'))
    else
        for id,pos in pairs(boomBoxes) do
            table.insert(elements, {label = id, value = id})
        end
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boombox', {
            title = _U('boombox_admin_menu_title'),
            align = Config.menuAlignment,
            elements = elements
        }, function(data, menu)
            if data.current.value == nil then
            else
                boomBoxName = data.current.value
                menu.close()
                OpenBoomboxMenu()
            end
        end, function(data, menu)
            menu.close()
        end)
    end
end

function pickupBoomBox(coords)
    if DoesEntityExist(currentData) then
        NetworkRequestControlOfEntity(currentData)
        startAnimation("anim@heists@narcotics@trash","pickup")
        Citizen.Wait(700)
        SetEntityAsMissionEntity(currentData,false,true)
        stop(coords)
        DeleteEntity(currentData)
        ESX.Game.DeleteObject(currentData)
        if not DoesEntityExist(currentData) then
            TriggerServerEvent("esx_boombox:remove_boombox", coords, boomBoxName)
            currentData = nil
        end
        boomBoxName = nil
        boomBoxOwner = "nil"
        Citizen.Wait(500)
        ClearPedTasks(PlayerPedId())
    else
        TriggerEvent("esx:showNotification", _U("no_boombox"))
    end
end

function setVolume(coords)
    ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "setvolume",
        {
            title = _U("set_volume"),
        }, function(data, menu)
            local value = tonumber(data.value) / 100
            if value < 0 or value > 1 then
                ESX.ShowNotification(_U("sound_limit"))
            else
                TriggerServerEvent("esx_boombox:set_volume", boomBoxName, value)
                menu.close()
            end
        end, function(data, menu)
            menu.close()
        end)
end

function play(coords)
    ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "play",
        {
            title = _U("play_id"),
        }, function(data, menu)
            local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_boombox_01"), false, false, false)
            local objCoords = GetEntityCoords(object)
            TriggerServerEvent("esx_boombox:play_music", boomBoxName, data.value, 1, objCoords)
            ESX.ShowNotification("Cargando musica de youtube " .. data.value)
            menu.close()
        end, function(data, menu)
            menu.close()
        end)
end

function stop(coords)
            local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_boombox_01"), false, false, false)
            local objCoords = GetEntityCoords(object)
            local playerPed = PlayerPedId()
            local lCoords = GetEntityCoords(playerPed)
            local distance = #(coords - objCoords)
            if(distance < 50) then
                TriggerServerEvent("esx_boombox:stop_music", boomBoxName)
            else
                TriggerEvent("esx:showNotification", _U("boombox_tooFar"))
                return
            end
end

function getClosestBoomBox(boomBoxes)
    local closestBoomboxPos = nil
    local closestBoomboxName = nil
    for k,v in pairs(boomBoxes) do
        local plyPos = GetEntityCoords(GetPlayerPed(-1))
        local dist = GetVecDist(plyPos, v)
        if dist < 50.0 then
            if closestBoomboxName and GetVecDist(plyPos, closestBoomboxPos) < dist then
                closestBoomboxName = k
                closestBoomboxPos = v
            else
                closestBoomboxName = k
                closestBoomboxPos = v
            end
        end
    end
    while closestBoomboxName ~= nil do
        boomBoxName = closestBoomboxName
        OpenBoomboxMenu()
        closestBoomboxPos = nil
        closestBoomboxName = nil
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        local playerPed = PlayerPedId()
        local coords    = GetEntityCoords(playerPed)

        local closestDistance = -1
        local closestEntity   = nil

        local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_boombox_01"), false, false, false)

        if DoesEntityExist(object) then
            local objCoords = GetEntityCoords(object)
            local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

            if closestDistance == -1 or closestDistance > distance then
                closestDistance = distance
                closestEntity   = object
            end
        end

        if closestDistance ~= -1 and closestDistance <= 3.0 then
            if lastEntity ~= closestEntity and not menuOpen then
                ESX.ShowHelpNotification(_U("boombox_help"))
                lastEntity = closestEntity
                currentAction = "music"
                currentData = closestEntity
            end
        else
            if lastEntity then
                lastEntity = nil
                currentAction = nil
                currentData = nil
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if currentAction then
            if IsControlPressed(0, Keys[Config.boomboxKey]) and currentAction == "music" then
                if trim(boomBoxOwner) == trim(GetPlayerName(PlayerId())) then
                    OpenBoomboxMenu()
                elseif ESX.PlayerData.job.name == "police" then
                    ESX.TriggerServerCallback('esx_boombox:GetBoomBoxes', function(boomBoxes)
                        if boomBoxes then
                          getClosestBoomBox(boomBoxes)
                        else
                            TriggerEvent("esx:showNotification", _U("not_found"))
                        end
                      end)
                else
                    TriggerEvent("esx:showNotification", _U("dont_own"))
                end
            end
        end
    end
end)


RegisterNetEvent('esx_boombox:boomboxes_menu')
AddEventHandler('esx_boombox:boomboxes_menu', function(data) OpenAdminMenu(data); end)