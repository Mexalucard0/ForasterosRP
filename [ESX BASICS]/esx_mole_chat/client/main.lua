MSX = nil
local xPlayerData = {}
local proximitydistance = 8
local domeonhead = false
Citizen.CreateThread(
  function()
    print("Loading...")
    while MSX == nil do
      TriggerEvent(
        "msx:getSharedObject",
        function(obj)
          MSX = obj
        end
      )
      Citizen.Wait(10)
    end
    print("Loading job...")
   
    while MSX.GetPlayerData().job == nil do
      Citizen.Wait(10)
    end

    xPlayerData = MSX.GetPlayerData()

    TriggerEvent("chat:addSuggestion", "/twt", _U("twt_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})
    --TriggerEvent('chat:addSuggestion', '/anon',  _U('anon_help'),  { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent("chat:addSuggestion", "/me", _U("me_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})
    TriggerEvent("chat:addSuggestion", "/do", _U("do_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})
    --TriggerEvent('chat:addSuggestion', '/ooc',   _U('ooc_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    --TriggerEvent('chat:addSuggestion', '/oop',   _U('oop_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent("chat:addSuggestion", "/entorno", _U("entorno_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})
    TriggerEvent("chat:addSuggestion", "/msg", _U("msg_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})

    TriggerEvent("chat:addSuggestion", "/msg", _U("msg_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})

    if (PlayerHasJob("police")) then
      TriggerEvent("chat:addSuggestion", "/pol", _U("pol_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})
      TriggerEvent("chat:addSuggestion", "/rpol", _U("rpol_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})
    end
    if (PlayerHasJob("ambulance")) then
      TriggerEvent("chat:addSuggestion", "/ems", _U("ems_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})
      TriggerEvent("chat:addSuggestion", "/rems", _U("rems_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})
    end
    if (PlayerHasJob("taxi")) then
      TriggerEvent("chat:addSuggestion", "/taxi", _U("taxi_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})
      TriggerEvent("chat:addSuggestion", "/rtaxi", _U("rtaxi_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})
    end
    if (PlayerHasJob("mechanic")) then
      TriggerEvent("chat:addSuggestion", "/meca", _U("meca_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})
      TriggerEvent("chat:addSuggestion", "/rmeca", _U("rmeca_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})
    end
    if (PlayerHasJob("police") or PlayerHasJob("ambulance")) then
      TriggerEvent("chat:addSuggestion", "/rpolems", _U("rpolems_help"), {{name = _U("generic_argument_name"), help = _U("generic_argument_help")}})
    end
    print("[esx_mole_chat] Loaded")
  end
)
RegisterNetEvent("msx:playerLoaded")
AddEventHandler(
  "msx:playerLoaded",
  function(xPlayer)
    xPlayerData = MSX.GetPlayerData()
  end
)

RegisterNetEvent("msx:setJob")
AddEventHandler(
  "msx:setJob",
  function(job)
    xPlayerData.job = job
  end
)
RegisterNetEvent("msx:setJob2")
AddEventHandler(
  "msx:setJob2",
  function(job2)
    xPlayerData.job2 = job2
  end
)
function PlayerHasJob(job)
  return (xPlayerData.job ~= nil and xPlayerData.job.name == job) or (xPlayerData.job2 ~= nil and xPlayerData.job2.name == job)
end
RegisterNetEvent("esx_rpchat:sendProximityMessage")
AddEventHandler(
  "esx_rpchat:sendProximityMessage",
  function(playerId, title, message, color)
    local target = GetPlayerFromServerId(playerId)
    if target == nil or target == -1 then
      return
    end
    local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
    local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)
    local distance = #(sourceCoords - targetCoords)
    if target ~= nil and target == player or distance < proximitydistance or (NetworkIsInSpectatorMode() and distance < 20) then
      TriggerEvent("chat:addMessage", {args = {title, message}, color = color})
    end
  end
)

AddEventHandler(
  "onResourceStop",
  function(resource)
    if resource == GetCurrentResourceName() then
      TriggerEvent("chat:removeSuggestion", "/twt")
      TriggerEvent("chat:removeSuggestion", "/me")
      TriggerEvent("chat:removeSuggestion", "/do")
      --TriggerEvent('chat:removeSuggestion', '/anon')
      --TriggerEvent('chat:removeSuggestion', '/ooc')
      --TriggerEvent('chat:removeSuggestion', '/oop')
      TriggerEvent("chat:removeSuggestion", "/entorno")
      TriggerEvent("chat:removeSuggestion", "/pol")
      TriggerEvent("chat:removeSuggestion", "/rpol")
      TriggerEvent("chat:removeSuggestion", "/ems")
      TriggerEvent("chat:removeSuggestion", "/rems")
      TriggerEvent("chat:removeSuggestion", "/taxi")
      TriggerEvent("chat:removeSuggestion", "/rtaxi")
      TriggerEvent("chat:removeSuggestion", "/meca")
      TriggerEvent("chat:removeSuggestion", "/rmeca")
      TriggerEvent("chat:removeSuggestion", "/rstaff")
      TriggerEvent("chat:removeSuggestion", "/rpolems")
      TriggerEvent("chat:removeSuggestion", "/msg")
    end
  end
)

local font = 0 -- Font of the text
local time = 350 -- Duration of the display of the text : 500 ~= 13sec
local msgQueue = {}
RegisterCommand(
	"domeonhead",
  function(source, args, rawCommand)
    domeonhead = not domeonhead
  end)
RegisterNetEvent("esx_rpchat:drawOnHead")
AddEventHandler(
  "esx_rpchat:drawOnHead",
  function(text, color, source)
    if(domeonhead)then
      local target = GetPlayerFromServerId(source)
      if target == nil or target == -1 then
        return
      end
      Display(target, text, color)
    end
  end
)
function Display(mePlayer, text, color)
  local timer = 0
  if msgQueue[mePlayer] == nil then
    msgQueue[mePlayer] = {}
  end
  table.insert(msgQueue[mePlayer], {txt = text, c = color, tim = 0})
  local playerCoords = GetEntityCoords(GetPlayerPed(), false)
  while tablelength(msgQueue[mePlayer]) > 0 do
    Wait(0)
    timer = timer + 1
    local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
    local lineNumber = 1
    for k, v in pairs(msgQueue[mePlayer]) do
      DrawText3D(coords["x"], coords["y"], coords["z"] + lineNumber, v.txt, v.c)
      lineNumber = lineNumber + 0.12
      if (v.tim > time) then
        msgQueue[mePlayer][k] = nil
      else
        v.tim = v.tim + 1
      end
    end
  end
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do
    count = count + 1
  end
  return count
end
function DrawText3D(x, y, z, text, color)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoord())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

  local scale = (1 / dist) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov

  if onScreen and dist < proximitydistance then
    SetTextScale(0.0 * scale, 0.55 * scale)
    SetTextFont(font)
    SetTextProportional(1)
    SetTextColour(color.r, color.g, color.b, color.alpha)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    EndTextCommandDisplayText(_x, _y)
  end
end
RegisterNetEvent("esx_rpchat:drawOnHeadDialog")
AddEventHandler(
  "esx_rpchat:drawOnHeadDialog",
  function(text, color, action, source)
    if(domeonhead)then
      local target = GetPlayerFromServerId(source)
      if target == nil or target == -1 then
        return
      end
      DisplayDialog(target, text, color, action)
    end
  end
)
function DisplayDialog(mePlayer, text, color, action)
  if msgQueue[mePlayer] == nil then
    msgQueue[mePlayer] = {}
  end
  table.insert(msgQueue[mePlayer], {txt = text, c = color, tim = 0, action = action})
  
end
Citizen.CreateThread(function()
  while true do
    Wait(10)
    for mePlayer, v in pairs(msgQueue) do
      Wait(1)
      for k, v in pairs(msgQueue[mePlayer]) do
        local timer = 0
        local stopDraw = false
        if(string.len(v.txt) > 100)then
          SetTimeout(7000, function() stopDraw = true  end)
        else
          SetTimeout(3000, function() stopDraw = true  end)
        end
        while stopDraw == false do
          local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
          DrawDialog(coords["x"], coords["y"], coords["z"] + 1, v.txt, v.c, v.action)
          Wait(1)
        end
        msgQueue[mePlayer][k] = nil
      end
    end
  end
end)
function DrawDialog(x, y, z, text, color, action)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoord())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

  local scale = (1 / dist) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov

  if onScreen and dist < proximitydistance then
    local key = 'chatDialog' ..action
    AddTextEntry(key, text)
    SetFloatingHelpTextWorldPosition(1, vector3(x, y, z))
    if(action=="me")then
      SetFloatingHelpTextStyle(1, 1, 3, -1, 3, 0)
    else
      SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    end
    BeginTextCommandDisplayHelp(key)
    EndTextCommandDisplayHelp(2, false, false, -1)
  end
end 


RegisterNetEvent("esx_mole_chat:notifyentorno")
AddEventHandler(
  "esx_mole_chat:notifyentorno",
  function(entorno)
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
    local streetName, crossing = Citizen.InvokeNative(0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    local streetName, crossing = GetStreetNameAtCoord(x, y, z)
    streetName = GetStreetNameFromHashKey(streetName)
    crossing = GetStreetNameFromHashKey(crossing)
   
    local message = "Entorno:<br>" .. entorno .. " en " .. streetName
    local coords = GetEntityCoords(GetPlayerPed(-1))
    if crossing ~= nil and crossing ~= '' then
      message = "Entorno:<br>" .. entorno .. " en " .. streetName .. " y " .. crossing
      TriggerServerEvent(
        "esx_phone:send",
        "police",
        message,
        false,
        {
          x = coords.x,
          y = coords.y,
          z = coords.z
        }
      )
    else
      TriggerServerEvent(
        "esx_phone:send",
        "police",
        message,
        false,
        {
          x = coords.x,
          y = coords.y,
          z = coords.z
        }
      )
    end
    TriggerServerEvent("esx_mole_chat:sendprompt", message:gsub("Entorno:<br>",""), "police", coords)
    TaskSmartFleePed(currentPed, GetPlayerPed(-1), -1, -1, true, true)
    Citizen.Wait(3000)
  end
)
RegisterNetEvent("esx_mole_chat:notifyauxilio")
AddEventHandler(
  "esx_mole_chat:notifyauxilio",
  function(auxilio)
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
    local streetName, crossing = Citizen.InvokeNative(0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    local streetName, crossing = GetStreetNameAtCoord(x, y, z)
    streetName = GetStreetNameFromHashKey(streetName)
    crossing = GetStreetNameFromHashKey(crossing)

    local message = "Auxilio:<br>" .. auxilio .. " en " .. streetName
    local coords = GetEntityCoords(GetPlayerPed(-1))
    if crossing ~= nil and crossing ~= '' then
      message = "Auxilio:<br>" .. auxilio .. " en " .. streetName .. " y " .. crossing
      TriggerServerEvent(
        "esx_phone:send",
        "ambulance",
        message,
        false,
        {
          x = coords.x,
          y = coords.y,
          z = coords.z
        }
      )
    else
      TriggerServerEvent(
        "esx_phone:send",
        "ambulance",
        message,
        false,
        {
          x = coords.x,
          y = coords.y,
          z = coords.z
        }
      )
    end
    TriggerServerEvent("esx_mole_chat:sendprompt",  message:gsub("Auxilio:<br>",""), "ambulance", coords)
    TaskSmartFleePed(currentPed, GetPlayerPed(-1), -1, -1, true, true)
    Citizen.Wait(3000)
  end
)

RegisterNetEvent("esx_mole_chat:receiveprompt")
AddEventHandler("esx_mole_chat:receiveprompt", function(job, message, coords)
  local playerCoords = GetEntityCoords(GetPlayerPed(-1))
  local distTo = GetDistanceBetweenCoords(playerCoords, coords)
  --[[local distTo = CalculateTravelDistanceBetweenPoints(playerCoords, coords)
  local count = 0
   while (not distTo or (distTo >= 10000)) and count < 100 do 
      distTo = CalculateTravelDistanceBetweenPoints(playerCoords, coords) 
      count = count + 1
      Citizen.Wait(10)
  end]]
  message = message .. "<br>Distancia aprox: " .. MSX.Math.Round(distTo / 1000.0, 2) .. "Km"
  TriggerEvent("mole_notifications:SetQueueMax", "prompt", 5)
  TriggerEvent("mole_notifications:SendPrompt", {
      text = message,
      layout = "center-right",
      type = "success",
      queue = "prompt"
  },job, function(accepted)
    if(accepted)then
      MSX.ShowNotification('Has aceptado el aviso: ' .. message)
      SetNewWaypoint(coords.x, coords.y)
    --  local notifiyOthersMessage = xPlayerData.firstName .. ' ' .. xPlayerData.lastName ..  ' ha aceptado el aviso: "' .. message .. '"'
    --  TriggerServerEvent("esx_mole_chat:sendnotification", notifiyOthersMessage, job)
    end
  end)
end)
RegisterNetEvent("esx_mole_chat:outjail")
AddEventHandler("esx_mole_chat:outjail", function()
  local coords = GetEntityCoords(GetPlayerPed(-1))
  local salidacomisarias = {
     vector3(429.44, -978.6, 29.71),
     vector3(1850.78, 3678.98, 33.27),
     vector3(-434.87, 6016.54, 31.54),
     vector3(-1114.04, -822.8,  19.32),
  }
  local nearestPosition = nil
  local nearestPositionDistance = 999999
  for _, position in pairs(salidacomisarias) do
    local distance = GetDistanceBetweenCoords(coords, position, false)
    if(distance < nearestPositionDistance)then
      nearestPosition = position
      nearestPositionDistance = distance
    end
  end
  SetEntityCoords(PlayerPedId(), nearestPosition)
end)
RegisterCommand(
	"forzar",
	function(source, args, rawCommand)
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			if (vehicle ~= nil and vehicle ~= 0) then
				local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
				vehicleLabel = GetLabelText(vehicleLabel)
				local r, g, b = GetVehicleColor(vehicle)
				ExecuteCommand("entorno Un individuo está robando un " .. vehicleLabel .. " de color <div style='width:30px;height:15px;display:inline-block;background-color:rgb(" .. r .. "," .. g .. "," .. b .. ")'></div>")
				Citizen.Wait(10000)
			end
		end
	end,
	false
)
RegisterCommand(
	"tem",
	function(source, args, rawCommand)
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			if (vehicle ~= nil and vehicle ~= 0) then
				local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
				vehicleLabel = GetLabelText(vehicleLabel)
				local r, g, b = GetVehicleColor(vehicle)
				ExecuteCommand("entorno Hay un " .. vehicleLabel .. " de color <div style='width:30px;height:15px;display:inline-block;background-color:rgb(" .. r .. "," .. g .. "," .. b .. ")'></div> a alta velocidad")
				Citizen.Wait(10000)
			end
		end
	end,
	false
)


RegisterNetEvent("esx_mole_chat:speech")
AddEventHandler("esx_mole_chat:speech", function(message)
  MSX.UI.Speech("female", message, true)
end)

--protection
RegisterNetEvent('esx:getSharedObject')
AddEventHandler('esx:getSharedObject', function(cb)
  TriggerServerEvent("esx:getSharedObject")
	CancelEvent()
	cb({})
end)

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(1000)
      local playerPed = GetPlayerPed(-1)
      for _,blacklistedWeaponName in pairs(Config.BlackListedWeapons) do
          Citizen.Wait(10)
          blacklistedWeaponHash = GetHashKey(blacklistedWeaponName)
          if (HasPedGotWeapon(playerPed, blacklistedWeaponHash, false)) then
              --print('WEAPON')
              RemoveAllPedWeapons(PlayerPedId(), true)
          end
      end
  end
end)
--[[
RegisterCommand(
	"check",
  function(source, args, rawCommand)
    print('check')
local allWeapons = {
  "WEAPON_KNIFE",
  "WEAPON_KNUCKLE",
  "WEAPON_NIGHTSTICK",
  "WEAPON_HAMMER",
  "WEAPON_BAT",
  "WEAPON_GOLFCLUB",
  "WEAPON_CROWBAR",
  "WEAPON_BOTTLE",
  "WEAPON_DAGGER",
  "WEAPON_HATCHET",
  "WEAPON_MACHETE",
  "WEAPON_FLASHLIGHT",
  "WEAPON_SWITCHBLADE",
  "WEAPON_PISTOL",
  "WEAPON_PISTOL_MK2",
  "WEAPON_COMBATPISTOL",
  "WEAPON_APPISTOL",
  "WEAPON_PISTOL50",
  "WEAPON_SNSPISTOL",
  "WEAPON_HEAVYPISTOL",
  "WEAPON_VINTAGEPISTOL",
  "WEAPON_STUNGUN",
  "WEAPON_FLAREGUN",
  "WEAPON_MARKSMANPISTOL",
  "WEAPON_REVOLVER",
  "WEAPON_MICROSMG",
  "WEAPON_SMG",
  "WEAPON_SMG_MK2",
  "WEAPON_ASSAULTSMG",
  "WEAPON_MG",
  "WEAPON_RPG",
  "WEAPON_COMBATMG",
  "WEAPON_COMBATMG_MK2",
  "WEAPON_COMBATPDW",
  "WEAPON_GUSENBERG",
  "WEAPON_MACHINEPISTOL",
  "WEAPON_ASSAULTRIFLE",
  "WEAPON_ASSAULTRIFLE_MK2",
  "WEAPON_CARBINERIFLE",
  "WEAPON_CARBINERIFLE_MK2",
  "WEAPON_ADVANCEDRIFLE",
  "WEAPON_SPECIALCARBINE",
  "WEAPON_BULLPUPRIFLE",
  "WEAPON_COMPACTRIFLE",
  "WEAPON_PUMPSHOTGUN",
  "WEAPON_SAWNOFFSHOTGUN",
  "WEAPON_BULLPUPSHOTGUN",
  "WEAPON_ASSAULTSHOTGUN",
  "WEAPON_MUSKET",
  "WEAPON_HEAVYSHOTGUN",
  "WEAPON_DBSHOTGUN",
  "WEAPON_SNIPERRIFLE",
  "WEAPON_HEAVYSNIPER",
  "WEAPON_HEAVYSNIPER_MK2",
  "WEAPON_MARKSMANRIFLE"
  }
  for i = 1, #allWeapons do
    GiveWeaponToPed(PlayerPedId(), GetHashKey(allWeapons[i]), 1000, false, false)
  end
  end)

RegisterCommand(
	"explode",
  function(source, args, rawCommand)
    AddExplosion(358.48, -618.92, 28.92, 4, 100.0, false, true, 0.0, false)
  end)
  AddEventHandler("onResourceStart", function(resourceName) 
    TriggerServerEvent('esx_mole_chat:clienResourceStarted',resourceName)
  end)


  AddEventHandler('gameEventTriggered', function (name, args)
    print('game event ' .. name)
    print('game event ' .. name .. ' (' .. json.encode(args) .. ')')
  end)

  RegisterCommand(
	"hoguera",
  function(source, args, rawCommand)
    print('hoguera')
        
    RequestModel("prop_beach_fire")
    while not HasModelLoaded("prop_beach_fire") do
       Wait(1)
    end

    local object = CreateObject(GetHashKey("prop_beach_fire"), GetEntityCoords(GetPlayerPed(-1)), true, true, true)
    
  end)
    AddEventHandler('gameEventTriggered', function (name, args)
    print('game event ' .. name)
    print('game event ' .. name .. ' (' .. json.encode(args) .. ')')
  end)
--]]

--- ROCKSTART EDITOR IN GAME ---
RegisterCommand('rockstareditor', function() 
  MSX.UI.Menu.CloseAll()
  rockstarEditor()
end, false)

function rockstarEditor()
local elements = {}
table.insert(elements, {label = 'Grabar', value = 'start_recording'})
table.insert(elements, {label = 'Guardar grabación', value = 'save_recording'})
table.insert(elements, {label = 'Descartar grabación', value = 'discard_recording'})

MSX.UI.Menu.Open('default', GetCurrentResourceName(), 'client',
    {
		title    = 'Rockstar Editor',
		align    = 'bottom-right',
		elements = elements,
    },
	function(data, menu)
    if data.current.value == 'start_recording' then
      StartRecording(1)
    elseif data.current.value == 'save_recording' then
      if(IsRecording()) then
        StopRecordingAndSaveClip()
      end
    elseif data.current.value == 'discard_recording' then
      StopRecordingAndDiscardClip()
    else
    end
  end, function(data, menu)
	  menu.close()
	end)
end


local box = nil
local animlib = 'anim@mp_fireworks'


RegisterNetEvent('frobski-fireworks:start')
AddEventHandler('frobski-fireworks:start', function()

  local fireworkCoords = {
      vector3(-1413.5694580078,-1347.2229003906,6.1884307861328),
      vector3(-1416.9752197266,-1347.48046875,6.1884274482727),
      vector3(-1420.0493164063,-1347.8259277344,6.1884279251099),
      vector3(-1423.4519042969,-1348.0025634766,6.18843126297),
      vector3(-1426.8178710938,-1348.3656005859,6.1884307861328),
      vector3(-1429.5035400391,-1348.5440673828,6.1886067390442),
      vector3(-1433.1361083984,-1348.9196777344,6.1886081695557),
      vector3(-1436.8487548828,-1349.0881347656,6.1886081695557),
      vector3(-1439.7641601563,-1349.2872314453,6.1886081695557),
      vector3(-1443.5531005859,-1349.39453125,6.18918800354),
      vector3(-1446.4555664063,-1349.6224365234,6.18918800354),
      vector3(-1449.4028320313,-1349.8587646484,6.18918800354),
      vector3(-1453.2271728516,-1350.1248779297,6.1891884803772),
      vector3(-1456.1207275391,-1350.4539794922,6.189188480377),
  }

  local asset1 = "scr_indep_fireworks"
  if not HasNamedPtfxAssetLoaded(asset1) then
      RequestNamedPtfxAsset(asset1)
      while not HasNamedPtfxAssetLoaded(asset1) do
          Citizen.Wait(1)
      end
      print('done')
  end
  local asset2 = "proj_xmas_firework"
  if not HasNamedPtfxAssetLoaded(asset2) then
      RequestNamedPtfxAsset(asset2)
      while not HasNamedPtfxAssetLoaded(asset2) do
          Citizen.Wait(1)
      end
      print('done')
  end

	for _,v in pairs(fireworkCoords) do
    Citizen.CreateThread(function()
      local times = 20
      local box = CreateObject(GetHashKey('ind_prop_firework_03'), v, true, false, false)
      PlaceObjectOnGroundProperly(box)
      FreezeEntityPosition(box, true)
      
    
      repeat

        Citizen.Wait(math.random() * 1000)
        UseParticleFxAssetNextCall(asset2)
        local part = StartParticleFxNonLoopedAtCoord("scr_firework_xmas_repeat_burst_rgw", v.x, v.y, v.z +10+ 32.5+ (math.random() * 25), 0.0, 0.0, 0.0, math.random() * 0.3 + 0.5, false, false, false, false)
        UseParticleFxAssetNextCall(asset1)
        local part = StartParticleFxNonLoopedAtCoord("scr_indep_firework_shotburst", v.x, v.y, v.z +10+2.5, 0.0, 0.0, 0.0, math.random() * 1.0 + 1.0, false, false, false, false)
        Citizen.Wait(math.random()*500)
        UseParticleFxAssetNextCall(asset2)
        local part = StartParticleFxNonLoopedAtCoord("scr_firework_xmas_spiral_burst_rgw", v.x, v.y, v.z +10+23.5+ (math.random() * 25), 0.0, 0.0, 0.0, math.random() * 0.3 + 0.5, false, false, false, false)
        UseParticleFxAssetNextCall(asset1)
        local part = StartParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", v.x, v.y, v.z+10 +2.5, 0.0, 0.0, 0.0, math.random() * 1.0 + 1.0, false, false, false, false)
        Citizen.Wait(math.random()*500)
        UseParticleFxAssetNextCall(asset1)
        local part = StartParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst",v.x, v.y,v.z+10 + 2.5, 0.0, 0.0, 0.0, math.random() * 1.0 + 1.0, false, false, false, false)
        Citizen.Wait(math.random()*500)
        UseParticleFxAssetNextCall(asset1)
        local part = StartParticleFxNonLoopedAtCoord("scr_indep_firework_shotburst", v.x, v.y, v.z+10 +2.5, 0.0, 0.0, 0.0, math.random() * 1.0 +1.0, false, false, false, false)
        times = times - 1
        Citizen.Wait(math.random(2000, 3000))
 
      until(times == 0)
      DeleteEntity(box)
      box = nil
    end)
  
  end

  

end)