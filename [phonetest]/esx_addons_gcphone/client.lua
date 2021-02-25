MSX          = nil

Citizen.CreateThread(function()
	while MSX == nil do
		TriggerEvent('msx:getSharedObject', function(obj) MSX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_addons_gcphone:call')
AddEventHandler('esx_addons_gcphone:call', function(data)
  local playerPed   = GetPlayerPed(-1)
  local coords      = GetEntityCoords(playerPed)
  local message     = data.message
  local number      = data.number
  if message == nil then
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 200)
    while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
      message =  GetOnscreenKeyboardResult()
    end
  end
  if message ~= nil and message ~= "" then
    TriggerServerEvent('esx_addons_gcphone:startCall', number, message, {
      x = coords.x,
      y = coords.y,
      z = coords.z
    })
  end
end)

RegisterNetEvent('gcPhone:onSendMessage')
AddEventHandler('gcPhone:onSendMessage', function(num, message)
  if(num =='mechanic')then
    MSX.TriggerServerCallback('esx_jobCounter:getcb', function(counted)
      if(counted['mechanic'] == 0)then
        ExecuteCommand('iamechanic sms')
      end
    end)
  end
  if(num =='taxi')then
    MSX.TriggerServerCallback('esx_jobCounter:getcb', function(counted)
      if(counted['taxi'] == 0)then
        ExecuteCommand('iataxi sms')
      end
    end)
  end
  if(num =='ambulance')then
    MSX.TriggerServerCallback('esx_jobCounter:getcb', function(counted)
      if(counted['ambulance'] == 0)then
        ExecuteCommand('iaambulance sms')
      end
    end)
  end
end)