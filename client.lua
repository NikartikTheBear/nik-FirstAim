Citizen.CreateThread(function()
	while true do
		Wait(1)
		local ped = PlayerPedId()
		if not IsAimCamActive() and GetFollowPedCamViewMode() ~= 4 then
			DisableControlAction(2, 24, true) 
			DisableControlAction(2, 142, true)
			DisableControlAction(2, 257, true)
			DisableControlAction(2, 140, true)
		end
	end
end)

local shot = false
local aim = false
local aimNot = false
local num = 0

Citizen.CreateThread(function()
	while true do
		SetBlackout(false)
		Wait( 1 )

		if IsControlPressed(1, 25) then
			for k, weapons in pairs(Config.Armi) do
				if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(Config.Armi) then
					if GetFollowPedCamViewMode() ~= 4 then
						while IsControlPressed(0, 25) do
							Wait(0)
							SetFollowPedCamViewMode(4)
						end
						SetFollowPedCamViewMode(1)
					end
				end
			end
		end
		
		if IsPlayerFreeAiming(PlayerId()) then
		    if GetFollowPedCamViewMode() == 4 and aim == false then
			    aim = false
			else
			    SetFollowPedCamViewMode(4)
			    aim = true
			end
		else
		    if aim == true then
		        SetFollowPedCamViewMode(1)
				aim = false
			end
		end
	end
end )



Citizen.CreateThread(function()
	while true do
		SetBlackout(false)
		Wait( 1 )
		
		if IsPedShooting(GetPlayerPed(-1)) and shot == false and GetFollowPedCamViewMode() ~= 4 then
			aimNot = true
			shot = true
			SetFollowPedCamViewMode(4)
		end
		
		if IsPedShooting(GetPlayerPed(-1)) and shot == true and GetFollowPedCamViewMode() == 4 then
			num = 0
		end
		
		if not IsPedShooting(GetPlayerPed(-1)) and shot == true then
		    num = num + 1
		end

        if not IsPedShooting(GetPlayerPed(-1)) and shot == true then
			if not IsPedShooting(GetPlayerPed(-1)) and shot == true and num > 20 then
		        if aimNot == true then
				    aimNot = false
					shot = false
					SetFollowPedCamViewMode(1)
				end
			end
		end
	end
end )