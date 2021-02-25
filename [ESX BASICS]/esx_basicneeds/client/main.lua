ESX          = nil
local IsDead = false
local IsAnimated = false
local IsAlreadyDrunk = false
local DrunkLevel     = -1

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	TriggerEvent('esx_status:remove', 'stress', 250000)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	TriggerEvent('esx_status:set', 'stress', 1)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
	Citizen.Wait(100)
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('ESX:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', false, function(status)
		return true
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', false, function(status)
		return true
	end, function(status)
		status.remove(110)
	end)

	TriggerEvent('esx_status:registerStatus', 'drunk', 0, '#8F15A5', true, --roxo
    function(status)
      if status.val > 0 then
        return true
      else
        return false
      end
    end,
    function(status)
      status.remove(5000)
    end
   )

	TriggerEvent('esx_status:registerStatus', 'stress', 0, '#8f425a', true, -- roxo
                 function(status) return true end,
				 function(status) status.add(100) end)
				 
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status ~= nil then
					if status.val == 0 then
						if prevHealth <= 150 then
							health = health - 5
						else
							health = health - 1
						end
					end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status ~= nil then
					if status.val == 0 then
						if prevHealth <= 150 then
							health = health - 5
						else
							health = health - 1
						end
					end
				end
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed, health)
			end

			TriggerEvent('esx_status:getStatus', 'drunk', function(status)
				if status ~= nil then
					if status.val > 0 then
						
						local start = true
						if IsAlreadyDrunk then
							start = false
						end
						local level = 0
						if status.val <= 250000 then
							level = 0
						elseif status.val <= 500000 then
							level = 1
						else
							level = 2
						end
						if level ~= DrunkLevel then
							Drunk(level, start)
						end
						IsAlreadyDrunk = true
						DrunkLevel     = level
								end
								if status.val == 0 then
						
						if IsAlreadyDrunk then
							Reality()
						end
						IsAlreadyDrunk = false
						DrunkLevel     = -1
					end
				end
 			end)
		end
	end)
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name)
	print(prop_name)
	onEat(prop_name)
end)
function onEat(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.11, 0.045, 0.02, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)
	end
end

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(prop_name)
	print(prop_name)
	onDrink(prop_name)
end)
function onDrink(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)
	end
end

RegisterNetEvent('esx_basicneeds:onDrinkBottle')
AddEventHandler('esx_basicneeds:onDrinkBottle', function(prop_name)
	print(prop_name)
	onDrinkBottle(prop_name)
end)
function onDrinkBottle(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_amb_beer_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 57005)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.145, -0.15, -0.055,270.0, 0.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('amb@code_human_wander_drinking@beer@male@base', function()
				TaskPlayAnim(playerPed, 'amb@code_human_wander_drinking@beer@male@base', 'static', 1.0, -1.0, 5000, 0, 1, true, true, true)

				Citizen.Wait(6000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)
	end
end


-- Cigarett 
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx_cigarett:startSmoke')
AddEventHandler('esx_cigarett:startSmoke', function(source)
	SmokeAnimation()
end)
inSmokeAnim = false
canSmokeAgain = true
function SmokeAnimation()
	if canSmokeAgain == false then
		ESX.ShowNotification('Acabas de fumar... ¿quieres reventarte los pulmones?')
		return
	end
	if inSmokeAnim == false then
		local ped = GetPlayerPed(-1)
		local anim = "amb@world_human_aa_smoke@male@idle_a"
		local dict = "idle_a"
		if IsPedSittingInAnyVehicle(ped) then
			if IsPedMale(ped) then
				anim = "amb@world_human_aa_smoke@male@idle_a"
				dict = "idle_a"
			else
				anim = "amb@world_human_leaning@female@smoke@idle_a"
				dict = "idle_a"
			end
			RequestAnimDict(anim)
			local j = 0
        	while not HasAnimDictLoaded(anim) and j < 20 do
				 Citizen.Wait(10)
				 j = j+1
			   end
			TaskPlayAnim( ped, anim, dict, 8.0, -8.0, -1, 49, 0, false, false, false )
			inSmokeAnim = true
		else
			local escenario = "WORLD_HUMAN_SMOKING"
			TaskStartScenarioInPlace(ped, escenario, 0, true)
			inSmokeAnim = true
		end

		SetTimeout(30000, function()
			if IsPedUsingScenario(ped, "WORLD_HUMAN_SMOKING") or IsEntityPlayingAnim(ped, anim, dict, 3) then
				ESX.ShowNotification('Fumar te ha relajado, en breve sentiras el efecto de la nicotina')
				canSmokeAgain = false
				SetTimeout(60000, function()
					canSmokeAgain = true
				end)
				if IsEntityPlayingAnim(ped, anim, dict, 3) then
					ClearPedTasks(ped)
				elseif IsPedUsingScenario(ped, "WORLD_HUMAN_SMOKING") then
					ClearPedTasks(ped)
				end
				SetTimeout(1000, function()
					TriggerEvent("esx_status:remove","stress", 200000)
				end)
			else
				ESX.ShowNotification('Has tirado el cigarro antes de acabarlo, y no hay cosa que mas te estrese que desperdiciar un cigarro...')
				TriggerEvent("esx_status:add","stress", 20000)
			end
			if prop ~= nil then
				DeleteObject (prop)
				prop = nil
			end
			inSmokeAnim = false
		end)
	else
		ESX.ShowNotification('Ya estas fumando, ¿quieres reventarte los pulmones?')
	end

	local playerPed = GetPlayerPed(-1)
end

-- Optionalneeds
function Drunk(level, start)
  
  Citizen.CreateThread(function()
     local playerPed = GetPlayerPed(-1)
     if start then
      DoScreenFadeOut(800)
      Wait(1000)
    end
     if level == 0 then
       RequestAnimSet("move_m@drunk@slightlydrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
      end
       SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
     elseif level == 1 then
       RequestAnimSet("move_m@drunk@moderatedrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
        Citizen.Wait(0)
      end
       SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
     elseif level == 2 then
       RequestAnimSet("move_m@drunk@verydrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
        Citizen.Wait(0)
      end
       SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
     end
     SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedIsDrunk(playerPed, true)
     if start then
      DoScreenFadeIn(800)
    end
   end)
 end
 function Reality()
   Citizen.CreateThread(function()
     local playerPed = GetPlayerPed(-1)
     DoScreenFadeOut(800)
    Wait(1000)
     ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)
     DoScreenFadeIn(800)
   end)
 end

 
RegisterNetEvent('esx_optionalneeds:onDrink')
AddEventHandler('esx_optionalneeds:onDrink', function()
  
  local playerPed = GetPlayerPed(-1)
  
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, 1)
  Citizen.Wait(1000)
  ClearPedTasksImmediately(playerPed)
 end) 