ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('macaco_alerts:tac0_c')
AddEventHandler('macaco_alerts:tac0_c', function()
    displayLogo("tac0")
end)

RegisterNetEvent('macaco_alerts:tac1_c')
AddEventHandler('macaco_alerts:tac1_c', function()
    displayLogo("tac1")
end)

RegisterNetEvent('macaco_alerts:tac2_c')
AddEventHandler('macaco_alerts:tac2_c', function()
    displayLogo("tac2")
end)

RegisterNetEvent('macaco_alerts:tac3_c')
AddEventHandler('macaco_alerts:tac3_c', function()
    displayLogo("tac3")
end)

RegisterNetEvent('macaco_alerts:tac4_c')
AddEventHandler('macaco_alerts:tac4_c', function()
    displayLogo("tac4")
end)

RegisterNetEvent('macaco_alerts:tac5_c')
AddEventHandler('macaco_alerts:tac5_c', function()
    displayLogo("tac5")
end)

function displayLogo (value)
    SendNUIMessage({
        type = "logo",
        display = value
    })
end


RegisterNetEvent('PoliceAlerts')
AddEventHandler('PoliceAlerts', function()
    OpenMenu()
end)


function OpenMenu()
  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'alerts', {
    title    = _U('msg1'),
    align    = 'top-left',
    elements = {
      {label = _U('msg2'),     value = 'a1'},
      {label = _U('msg3'),     value = 'a2'},
      {label = _U('msg4'), value = 'a3'},
      {label = _U('msg5'), value = 'a4'},
      {label = _U('msg6'), value = 'a5'},
      {label = _U('msg7'), value = 'a6'}
  }}, function(data, menu)
    if data.current.value == 'a1' then
      TriggerServerEvent("macaco_alerts:tac0")


    elseif data.current.value == 'a2' then
      TriggerServerEvent("macaco_alerts:tac1")


    elseif data.current.value == 'a3' then
      TriggerServerEvent("macaco_alerts:tac2")

      
    elseif data.current.value == 'a4' then
      TriggerServerEvent("macaco_alerts:tac3")
    elseif data.current.value == 'a5' then
      TriggerServerEvent("macaco_alerts:tac4")
    elseif data.current.value == 'a6' then
      TriggerServerEvent("macaco_alerts:tac5")
    end

    menu.close()
  end, function(data, menu)
    menu.close()
  end)
end