ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local _voicegpsActive = false
local _gpsCoords = nil

local _justPlayed1000M, _justPlayed200M, _justPlayedFollowRoad, _justPlayedImmediate, _playedStartDriveAudio, _justPlayedRecalc, _voiceGpsEnabled, _welcomeShowed
local _justPlayedArrived = true
local _lastDirection, _lastDistance = 0,0

--[[
0 = You Have Arrived
1 = Recalculating Route, Please make a u-turn where safe  
2 = Please Proceed the Highlighted Route  
3 = In (distToNxJunction) Turn Left  
4 = In (distToNxJunction) Turn Right  
5 = In (distToNxJunction) Go Straight  
6 = In (distToNxJunction) Keep Left  
7 = In (distToNxJunction) Keep Right
8 = In (distToNxJunction) Join the freeway  
9 = In (distToNxJunction) Exit Freeway  
]]--
RegisterNetEvent("esx_mole_status:voicegps")
AddEventHandler("esx_mole_status:voicegps", function(source)
    SetGpsActive(true)
    local player = GetPlayerPed(-1)
    _gpsRunning = true
    while _gpsRunning == true do
        ::continue::
        local vehicle = GetVehiclePedIsIn(player,false)
        if(vehicle ~= nil) then
            local blip = GetFirstBlipInfoId(8)
            if(IsWaypointActive() == false or blip == nil)then
                if(_playedStartDriveAudio and not _justPlayedArrived) then
                    ESX.UI.Speech('male', 'a')
                    ESX.UI.Speech('female', "Has llegado a tu destino.") 
                    _justPlayedArrived = true
                    Citizen.Wait(2000)
                    _gpsRunning = false
                end
                _playedStartDriveAudio = false
                Citizen.Wait(1000)
                goto continue
            end
            local coord = GetBlipCoords(blip)

            _justPlayedArrived = false
            if (not _playedStartDriveAudio) then
                fullStreetName = GetStreetNameForCoord(coord)
                ESX.UI.Speech('female', "Iniciando ruta hacia " ..  fullStreetName)
                ESX.ShowNotification("Iniciando ruta hacia " ..  fullStreetName)
                Citizen.Wait(2000)
                _playedStartDriveAudio = true
                goto continue
            end
            _justPlayedArrived = false
            
            local chk,dir,_,dist = GenerateDirectionsToCoord(coord.x,coord.y,coord.z, true)
        
            if (dir > 8 or dir < 0)then
                Citizen.Wait(1000)
                goto continue
            end

            --0 : You arrived at your destination
            --1 : Going The Wrong wAY...recalculating
            --2: Follow this lane and wait for more instructions
            --3: On the next intersection, turn left. (distance on p6)
            --4: On the next intersection, turn right. (distance on p6)
            --5: On the next intersection, go straight. (distance on p6)
            --6: Take the next return to the left. (distance on p6)
            --7: Take the next return to the right. (distance on p6)
            --8: Exit motorway

            if (_lastDirection ~= dir or (_lastDirection == dir and _lastDistance - dist < -50))then
                _justPlayed200M = false;
                _justPlayedImmediate = false;
                _justPlayed1000M = false;
            end

            if (dist > 175 and dist < 300 and not _justPlayed200M and dir ~= 5)then
                ESX.UI.Speech('female', "200 metros") 
                _justPlayed200M = true;
                Citizen.Wait(2100)
                PlayDirectionAudio(dir, dist)
            end

            if (dist > 500 and dist < 1000 and not _justPlayed1000M and dir ~= 5) then
                ESX.UI.Speech('female', "1000 metros") 
                _justPlayed1000M = true
                Citizen.Wait(2200)
                PlayDirectionAudio(dir, dist)
            end
            
            if (not _justPlayedImmediate and dist < 55 and dist > 20 and dir ~= 5)then
                _justPlayedImmediate = true
                PlayDirectionAudio(dir, dist)
            elseif (dist < 20 and dir ~= 5)then
                _lastDirection = 0;
                _justPlayed1000M = false;
                _justPlayed200M = false;
                _justPlayedImmediate = true;
            end

            if (dir == 2 and not _justPlayedFollowRoad and _lastDirection ~= 5)then
                _justPlayedFollowRoad = true;
            elseif (dir ~= 2) then
                _justPlayedFollowRoad = false;
            end
            if (dir == 1 and not _justPlayedRecalc)then
            
                _justPlayedRecalc = true;
                ESX.UI.Speech('female', "Recalculando ruta. Espera por favor.") 
                Citizen.Wait(3000)
            elseif (dir ~= 1)then
                _justPlayedRecalc = false;
            end

            _lastDirection = dir
            _lastDistance = dist

            _justPlayedArrived = true
        end
        Citizen.Wait(1)
    end
end)
function PlayDirectionAudio(dir, dist)
    local dontPlayStreetName = false
    local roadName = ""

    if (dir == 3 or dir == 4)then
        roadName, dontPlayStreetName = GetCorrectTurningRoadName(dir, dist)
    end
    if(dir == 6)then
        -- Not 100%
        ESX.UI.Speech('female', "Gira a la izquierda en la próxima intersección") 
        Citizen.Wait(900)
    elseif(dir == 7)then
        -- Not 100%
        ESX.UI.Speech('female', "Gira a la derecha en la próxima intersección") 
        Citizen.Wait(900)
    elseif(dir==3)then
        -- Turn left at next intersection
        local text = "Gira a la izquierda"
        if (dist < 175 and dist > 30 and not dontPlayStreetName)then
            text = text .. " en " .. roadName
        end
        ESX.UI.Speech('female', text)
    elseif(dir==4)then
        -- Turn right at next intersection
        local text = "Gira a la derecha"
        if (dist < 175 and dist > 30 and not dontPlayStreetName)then
            text = text .. " en " .. roadName
        end
        ESX.UI.Speech('female', text)
    elseif(dir==5)then
        -- Straight ahead at next intersection
        -- Played way too much
        -- PlayAudio("straight");
    elseif(dir == 1) then
        -- Driver went wrong way -- remaking route
        ESX.UI.Speech('female', "Recalculando ruta. Espera por favor.") 
        Citizen.Wait(3000)
    elseif(dir == 8) then
        ESX.UI.Speech('female', "Sal de la autopista.") 
        Citizen.Wait(3000)
            --//PlayAudio("exitMotorwayToRight");
    end
end
function GetStreetNameForCoord(coord)
    local _, roadCoords = GetClosestRoad(coord.x,coord.y,coord.z, 1.0, 1)
    autopilotCoords = roadCoords

    local streetA, streetB = GetStreetNameAtCoord(autopilotCoords.x, autopilotCoords.y, autopilotCoords.z)
    local street = {}
    
    if streetA ~= 0 then
        table.insert( street, GetStreetNameFromHashKey( streetA ) )
    end
    
    if streetB ~= 0 then
        table.insert( street, GetStreetNameFromHashKey( streetB ) )
    end
    local fullStreetName = table.concat( street, " con " )
    return fullStreetName
end
function GetCorrectTurningRoadName(direction, distance)
    local roadName, roadNameXing = GetStreetNameForDirection(distance)
    local playerPed = GetPlayerPed(-1)
    local playerPosition = GetEntityCoords(playerPed)

    local hash, crossingRoadHash = GetStreetNameAtCoord(autopilotCoords.x, autopilotCoords.y, autopilotCoords.z)

    local currentRoad = GetStreetNameFromHashKey(hash)

    incorrectStreetName = (currentRoad == roadName)

    if (incorrectStreetName)then
        local rightVector, forwardVector, upVector, position = GetEntityMatrix(playerPed)
        local leftVector = rightVector * -1;

        if(direction == 3)then
            street, streetXing = GetStreetNameForDirection(distance, leftVector * 5)
            roadName = street;
            incorrectStreetName = (currentRoad == roadName);
        end
        if(direction == 4)then
            street, streetXing = GetStreetNameForDirection(distance, rightVector * 5)
            roadName = street;
            incorrectStreetName = (currentRoad == roadName);
        end
    end

    if (incorrectStreetName)then
        return nil
    end
    return roadName, incorrectStreetName
end
function GetStreetNameForDirection(distance, xyOffset)
    -- North = Y+
    -- South = Y-
    -- East = X+
    -- West = X-

    if (xyOffset == nil)then
        xyOffset = vector3(0, 0, 0)
    end
    local playerPed = GetPlayerPed(-1)
    local position = GetEntityCoords(playerPed)
    local forwardVector = GetEntityForwardVector(playerPed)
    local coords = position + (forwardVector * distance) + xyOffset

    
    local roadPositionXY = vector2(coords.x, coords.y);

    roadGroundZ = -1
    local _, roadGroundZ = GetGroundZFor_3dCoord(roadPositionXY.x, roadPositionXY.y, 10000, false)
    if (roadGroundZ == -1)then
        return nil
    end
    
    local roadPositionXYZ = vector3(roadPositionXY.x, roadPositionXY.y, roadGroundZ)
    local streetHash, streetXingHash = GetStreetNameAtCoord(roadPositionXYZ.x, roadPositionXYZ.y, roadPositionXYZ.z)
    
    local street = GetStreetNameFromHashKey(streetHash);
    local streetXing = nil
    if(streetXingHash ~= 0) then
        streetXing = GetStreetNameFromHashKey(streetXingHash)
    end
    return street, streetXing
end
RegisterNetEvent("esx_mole_status:voicegps")
AddEventHandler("esx_mole_status:voicegps", function(source)
    DeactivateGps()
end)
function DeactivateGps()
	_voicegpsActive = false
    _gpsCoords = nil
    _gpsRunning = false

    _voiceGpsEnabled = false
    _lastDirection = 0;
    _justPlayed200M = false
    _justPlayedArrived = false
    _justPlayedFollowRoad = false
    _justPlayedImmediate = false
    _justPlayedRecalc = false
    _justPlayed1000M = false
    _playedStartDriveAudio = false

	ClearPedTasks(PlayerPedId())
	local player = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(player,false)

end