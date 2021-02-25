function distanceToObject(object)
    local playerPed = PlayerPedId()
    local lCoords = GetEntityCoords(playerPed)
    local distance  = GetDistanceBetweenCoords(lCoords, object, true)
    return distance
end

function startAnimation(lib,anim)
    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 1, 0, false, false, false)
    end)
end

function trim(s)
    return s:match( "^%s*(.-)%s*$" )
end

function GetVecDist(v1,v2)
    if not v1 or not v2 or not v1.x or not v2.x then return 0; end
    return math.sqrt(  ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) )+( (v1.z or 0) - (v2.z or 0) )*( (v1.z or 0) - (v2.z or 0) )  )
  end