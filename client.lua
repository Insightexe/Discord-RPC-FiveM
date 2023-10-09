local discordAppId = 'YOUR_DISCORD_APP_ID'
local logoImageKey = 'logo'                 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        
        local player = PlayerId()
        local playerName = GetPlayerName(player)
        local serverName = GetConvar('sv_hostname', 'FiveM Server')  -- Default server name if not found
        local streetName = GetStreetName()
        local activity = 'Idle'
        
        if IsPedInAnyVehicle(player, false) then
            local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            local speed = GetEntitySpeed(vehicle) * 3.6  
            if speed > 5 then
                activity = 'Driving'
            else
                activity = 'Parked'
            end
        elseif IsPedSwimming(GetPlayerPed(-1)) then
            activity = 'Swimming'
        elseif IsPedInParachuteFreeFall(GetPlayerPed(-1)) then
            activity = 'Skydiving'
        elseif IsPedInAnyHeli(GetPlayerPed(-1)) or IsPedInAnyPlane(GetPlayerPed(-1)) then
            activity = 'Flying'
        elseif IsPedOnFoot(GetPlayerPed(-1)) then
            activity = 'Walking'
        end
        
        SetDiscordAppId(discordAppId)
        SetDiscordRichPresenceAsset(logoImageKey)
        SetRichPresence(string.format('%s - %s', serverName, playerName))
        SetRichPresence('Details', string.format('Activity: %s', activity))
        SetRichPresence('State', string.format('Location: %s', streetName))
    end
end)
