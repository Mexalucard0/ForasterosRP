local disPlayerNames = 2
local showIds = false
playerDistances = {}
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
RegisterCommand(
    "id",
    function(source, args) --Change "tow" value to change activation command.
        showIds = true
        disPlayerNames = 2
    end,
    false
)
RegisterCommand(
    "noid",
    function(source, args) --Change "tow" value to change activation command.
        showIds = false
    end,
    false
)
RegisterCommand(
    "idspectate",
    function(source, args) --Change "tow" value to change activation command.
        ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
            if playerRank == "admin" or playerRank == "superadmin" or playerRank == "mod" then
                showIds = true
                disPlayerNames = 100
            end
        end)
    end,
    false
)
Citizen.CreateThread(function()
    Wait(50)
    while true do
        if(showIds)then
            for id = 0, 255 do 
                if NetworkIsPlayerActive(id) then
                    if GetPlayerPed(id) ~= GetPlayerPed(-1) then
                        if (playerDistances[id] ~= nil and playerDistances[id] < disPlayerNames) then
                            x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                            if NetworkIsPlayerTalking(id) then
                                DrawText3D(x2, y2, z2+1.2, GetPlayerServerId(id), 0,255,0)
                            else
                                DrawText3D(x2, y2, z2+1.2, GetPlayerServerId(id), 255,255,255)
                            end
                        end  
                    end
                end
            end
        end
        Citizen.Wait(5)
    end
end)

Citizen.CreateThread(function()
    while true do
        --for _, id in ipairs(GetActivePlayers()) do
        if(showIds)then
            for id = 0, 255 do
                if GetPlayerPed(id) ~= GetPlayerPed(-1) then
                    x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                    x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                    distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
                    playerDistances[id] = distance
                end
            end
        end
        Citizen.Wait(1000)
    end
end)

function DrawText3D(x,y,z, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.60*scale)
        SetTextFont(0)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
