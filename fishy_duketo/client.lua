ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.getPercent()
        end)
        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.getPercent()
            Citizen.Wait(200)
        end)
    end
end)

seatbeltPressed = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 29) then
            seatbeltPressed = not seatbeltPressed
            print(seatbeltPressed)
            SendNUIMessage {
                seatbelt = false
            }
        end
        
        if seatbeltPressed then
            SendNUIMessage {
                seatbelt = true
            }
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local seatbelt = false
        if IsControlJustPressed(0, 137) then
            Citizen.Wait(200)
            SendNUIMessage({
				action = 'fishySlide',
            })
            Citizen.Wait(200)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        local zones = {['HIGHWAY'] = "All Highways", ['YANKTON'] = "North Yankton", ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
        local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z))
        local zoneNameFull = zones[GetNameOfZone(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z)]
        SendNUIMessage({
            action = 'tick',
            street1 = streetName .. " | " ..  zoneNameFull,
        })
        Citizen.Wait(200)
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerped = GetPlayerPed(-1)
        local inMenu = IsPauseMenuActive()
        -- Detect if ped is on vehicle
        Citizen.Wait(200)
        if IsPedInAnyVehicle(playerped, false) and not inMenu then
            local vehicleped = GetVehiclePedIsIn(playerped, false)
            local vehiclegas = math.ceil(GetVehicleFuelLevel(vehicleped))
            local vehiclespeed = math.ceil(GetEntitySpeed(vehicleped)* 3.6)
            local vueltas = GetVehicleCurrentRpm(vehicleped)
            local rpm = math.ceil(vueltas * 10000 - 2001, 2)
            SendNUIMessage({
                action = 'tick',
                displayhudcar = true,
                health = (GetEntityHealth(playerped) - 100),
                armor = GetPedArmour(playerped),
                hunger =  hunger,
                stress = stress,
                thirst = thirst,
                isonvehicle = true,
                gas = vehiclegas,
                velocidad = vehiclespeed,
                rpm = rpm,
            })
        else
            Citizen.Wait(20)
            SendNUIMessage({
                action = 'tick',
                health = (GetEntityHealth(playerped) - 100),
                armor =  GetPedArmour(playerped),
                hunger =   hunger,
                thirst =   thirst,
                stress = stress,
                stamina =  GetPlayerSprintStaminaRemaining(PlayerId()),
                isonvehicle = false,
                displayhudcar = false,
            })
            Citizen.Wait(20)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        TriggerServerEvent('fishy:duketo:getinfo')
    end
end)

RegisterNetEvent('fishy_duketo:setinfo')
AddEventHandler('fishy_duketo:setinfo', function(info)
    Citizen.Wait(200)
    SendNUIMessage({
        action = 'info',
        job = info['job'],
        wallet = info['money'],
        bank = info['bankMoney'],
        blackMoney = info['blackMoney'],
    })
	TriggerEvent('esx:getSharedObject', function(obj)
		ESX = obj
		ESX.PlayerData = ESX.GetPlayerData()
	end)
end)
