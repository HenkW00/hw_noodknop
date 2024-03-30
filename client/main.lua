-- Cooldown
local Cooldown = 0
CreateThread(function()
	while true do
		if Cooldown ~= 0 then
			Wait(Config.Cooldown * 100)
			Cooldown = Cooldown - 1
			debugPrint(tostring(Cooldown))
		else 
			Wait(1000)
		end
	end
end)

-- Create Commands
RegisterCommand('panic', function(source, args, rawCommand)
	local senderPosition = GetEntityCoords(PlayerPedId())

	if Cooldown == 0 then 
		TriggerServerEvent('hw_noodknop:firepanic', senderPosition)
		debugPrint('^0[^1DEBUG^0] ^5Triggering Network Panic Event')
		Cooldown = Config.Cooldown
	else 
		ESX.ShowNotification(Translate('cooldown_active'))
		debugPrint('^0[^1DEBUG^0] ^5Cooldown is active..')
	end
end, false)

RegisterCommand('position', function(source, args, rawCommand) 
	local senderPosition = GetEntityCoords(PlayerPedId())
	
	if Cooldown == 0 then 
		TriggerServerEvent('hw_noodknop:firepos', senderPosition)
		debugPrint('^0[^1DEBUG^0] ^5Triggering Network Position Event')
		Cooldown = Config.Cooldown
	else 
		ESX.ShowNotification(Translate('cooldown_active'))
		debugPrint('^0[^1DEBUG^0] ^5Cooldown is active..')
	end

end, false)

-- Register Keys
RegisterKeyMapping('panic', Translate('keymmaping_panic'), 'keyboard', Config.PanicButton)
RegisterKeyMapping('position', Translate('keymmaping_position'), 'keyboard', Config.PositionButton) 

if Config.ChatSuggestions then
	TriggerEvent('chat:addSuggestion', '/panic', Translate('suggestion_panic'))
	TriggerEvent('chat:addSuggestion', '/position', Translate('suggestion_position'))
end

-- Main Network Events
panicBlip = function(pos)
	CreateThread(function()
		local CreatedBlip = AddBlipForRadius(pos.x, pos.y, pos.z, 100.0)

		SetBlipAlpha(CreatedBlip, 60)
		SetBlipColour(CreatedBlip, 1)
		SetBlipFlashes(CreatedBlip, true)
		SetBlipFlashInterval(CreatedBlip, Blip.FlashInterval)

		Wait(Blip.Time * 1000)
		RemoveBlip(CreatedBlip)
		CreatedBlip = nil
	end)
end 

RegisterNetEvent('hw_noodknop:sendPosition', function(pos, type) 
	if Sounds.Enabled then 
		if type == 'panic' then
			exports['xsound']:PlayUrl('panic', Sounds.URL, Sounds.Volume)
			debugPrint('^0[^1DEBUG^0] ^5Started playing sound from url.')
		end 
	end  

	if Blip.Enabled then 
		if type == 'panic' then 
			panicBlip(pos)
			debugPrint('^0[^1DEBUG^0] ^5Started blip function.')
		end
	end
	
	CreateThread(function()
		while true do
			local Sleep = 1000
			local pedCoords = GetEntityCoords(PlayerPedId())
			Sleep = 0

			ESX.ShowHelpNotification(Translate('waypoint'), false, true)

			if IsControlJustReleased(2, 38) then
				SetNewWaypoint(pos.x, pos.y)
				debugPrint('^0[^1DEBUG^0] ^5Set new waypoint to: x'..tostring(pos.x)..' | y'..tostring(pos.y))
				break
				
			elseif IsControlJustReleased(2, 47) then
				debugPrint('^0[^1DEBUG^0] ^5Rejected position requests.')
				break
			end

			Wait(Sleep)
		end
	end) 
end)