ESX = nil
key_to_teleport = 38
positions = {--[[
    {{1111.11, 257.44, -47.00, 1.63}, {980.00, 57.0, 115.0, 52},{255, 157, 0}, "Pulsa E para ir al apartamento/casino"},
    {{970.01, 63.45, 111.55, 53}, {967.88, 63.46, 111.55, 54},{255, 255, 0}, "Pulsa E para ir a la terraza/apartamento"},
    {{931.44, 43.5, 80.11, 0}, {1089.64, 205.79, -50.0, 0},{255, 255, 0}, "Pulsa E para Entrar/Salir del casino"},
    {{-1569.42, -3017.11, -75.36, 358.0 }, {195.23,-3167.4, 4.82, 88.0},{255, 255, 0}, "Pulsa E para Entrar/Salir del Galaxy"},
    {{-329.68, 6154.16, 31.31},{-1947.0, -12.08, 90.67}, {255,255,0}, "Pulsa E para Entrar/Salir de la iglesia"},
    {{-329.355, 6150.34, 31.31},{-1945.53, -13.39, 90.67}, {255,255,0}, "Pulsa E para Entrar/Salir de la iglesia"}--]]
    {{-1584.87, 776.49, 188.19, 118.7}, {896.42, -3245.78, -99.24, 92.21},{255, 157, 0}, "Pulsa E para Entrar/Salir del bunker"}, --Bunker
    {{1109.18, -3163.51, -38.62, 358.34}, {-55.54, 6398.54, 30.00, 46.7},{27, 38, 49}, "Pulsa E para Entrar/Salir del garaje"}, --TheLost
    {{999.91, -3163.44, -39.91, 270.11}, {126.93, -1941.95, 18.63, 79.1},{27, 38, 49}, "Pulsa E para Entrar/Salir del garaje"}, --GroveStreet
    {{967.61, -1025.02, 39.84, 272.35}, {971.15, -2992.68, -40.65, 185.59},{240, 102, 12}, "Pulsa E para Entrar/Salir del garaje"}, --RRCLUB
    {{239.12, 383.3, 104.90, 78.67}, {4600.72, 2589.59, 09.70, 302.92},{240, 102, 12}, "Pulsa E para Entrar/Salir del garaje"}, --Actividad Circuito
    --{{3540.74, 3675.3, 27.12, 167.1}, {3540.76, 3675.46, 19.99, 167.1},{240, 102, 12}, "Pulsa E utilizar el ascensor"}, --HumaneLabs
    {{967.79, -1828.95, 29.90, 358.28}, {201.34, -1002.92, -100.00, 92.3},{27, 38, 49}, "Pulsa E para Entrar/Salir del garaje"}, --Marabunta
    {{0.24, 0.2, -1.89, 21.96}, {240.18, -810.53, 28.24, 70.62},{27, 38, 49}, "Pulsa E para ir al garaje"}, --Respawn Punto 0
    {{935.93, 47.18, 80.1, 328.72}, {1089.75, 205.78, -50.0, 359.36}, {27, 38, 49}, "Pulsa E para Entrar/Salir al Casino"}, --Diamond Casino
    {{1119.38, 267.32, -46.84, 21.96}, {965.11, 58.47, 111.55, 70.62},{27, 38, 49}, "Pulsa E para Entrar/Salir al Casino"}, --Diamond Casino AZOTEA
    {{-68.44, -800.61, 43.23, 21.96}, {-77.54, -826.69, 242.39, 70.62},{108, 225, 74}, "Pulsa E para Entrar/Salir al Maze Bank"}, --MAZE BANK 1
    {{-86.01, -815.33, 35.09, 21.96}, {-75.56, -827.11, 241.38, 70.62},{108, 225, 74}, "Pulsa E para Entrar/Salir al Maze Bank"}, --MAZE BANK 2
    {{-77.54, -826.69, 242.39, 21.96}, {-68.44, -800.61, 43.23, 70.62},{108, 225, 74}, "Pulsa E para Entrar/Salir al Maze Bank"}, --MAZE BANK 3
    {{-75.56, -827.11, 242.38, 21.96}, {-86.01, -815.33, 35.09, 70.62},{108, 225, 74}, "Pulsa E para Entrar/Salir al Maze Bank"}, --MAZE BANK 4

    
    
   
}

Citizen.CreateThread(function()
	while MESXSX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

local player = GetPlayerPed(-1)
local playerPositionToTp = nil

RegisterNetEvent('mole_tp:lastPlayerPositionTp')
AddEventHandler('mole_tp:lastPlayerPositionTp', function(position)
    playerPositionToTp = position
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)

        for _,location in ipairs(positions) do
            teleport_text = location[4]
            loc1 = {
                x=location[1][1],
                y=location[1][2],
                z=location[1][3],
                heading=location[1][4]
            }
            loc2 = {
                x=location[2][1],
                y=location[2][2],
                z=location[2][3],
                heading=location[2][4]
            }
            Red = location[3][1]
            Green = location[3][2]
            Blue = location[3][3]

            DrawMarker(1, loc1.x, loc1.y, loc1.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, Red, Green, Blue, 200, 0, 0, 0, 0)
            DrawMarker(1, loc2.x, loc2.y, loc2.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, Red, Green, Blue, 200, 0, 0, 0, 0)

            if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc1.x, loc1.y, loc1.z, 2) then 
                alert(teleport_text)
                
                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(GetVehiclePedIsUsing(player), loc2.heading)
                    else
                        SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(player, loc2.heading)
                    end
                end

            elseif CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc2.x, loc2.y, loc2.z, 2) then
                alert(teleport_text)

                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(GetVehiclePedIsUsing(player), loc1.heading)
                    else
                        SetEntityCoords(player, loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(player, loc1.heading)
                    end
                end
            end            
        end

        DrawMarker(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, Red, Green, Blue, 200, 0, 0, 0, 0)

        if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, 0, 0, 0, 2) then 
            alert('Presiona ~INPUT_CONTEXT~ para restaurar tu posición')
            if IsControlJustReleased(1, key_to_teleport) then
                if playerPositionToTp ~= nil then
                    SetEntityCoords(player, playerPositionToTp.x, playerPositionToTp.y, playerPositionToTp.z)
                else
                    SetEntityCoords(player, 258.39776611328, -773.76208496094, 30.670236587524) --Garaje central
                end
            end
        end  
        
    end
end)

function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end

function alert(msg)
    ESX.ShowHelpNotification(msg)
end