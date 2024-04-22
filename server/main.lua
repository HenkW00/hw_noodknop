-- Panic Network Event
RegisterNetEvent('hw_noodknop:firepanic', function(senderPosition)
    if Config.OldESX then
        local xPlayers = ESX.GetPlayers()
        local xPlayer2 = ESX.GetPlayerFromId(source)

        local allowedJobs = {'police', 'kmar', 'mechanic', 'ambulance', 'dsi', 'recherche'} -- Add the new jobs here

        if tableContains(allowedJobs, xPlayer2.job.name) then
            for i = 1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if tableContains(allowedJobs, xPlayer.job.name) then
                    TriggerClientEvent('hw_noodknop:sendPosition', xPlayer.source, senderPosition, 'panic')
                    TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, PanicButtonLayout.Title, PanicButtonLayout.SubTitle, (PanicButtonLayout.Content):format(xPlayer2.getName()), PanicButtonLayout.Icon, 1)
                    if Config.SelfNotify then
                        xPlayer.showNotification(Translate('selfnotify_panic'))
                    end
                end
            end
        end
    else
        local xPlayers = ESX.GetExtendedPlayers('job', 'police', 'kmar', 'mechanic', 'ambulance', 'dsi', 'recherche') -- Add the new jobs here
        local xPlayer2 = ESX.GetPlayerFromId(source)
        if tableContains({'police', 'kmar', 'mechanic', 'ambulance'}, xPlayer2.job.name) then
            for _, xPlayer in pairs(xPlayers) do
                xPlayer.triggerEvent('hw_noodknop:sendPosition', senderPosition, 'panic')
                xPlayer.triggerEvent('esx:showAdvancedNotification', PanicButtonLayout.Title, PanicButtonLayout.SubTitle, (PanicButtonLayout.Content):format(xPlayer2.getName()), PanicButtonLayout.Icon, 1)
                if Config.SelfNotify then
                    xPlayer.showNotification(Translate('selfnotify_panic'))
                end
            end
        end
    end
end)

function tableContains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end
 

-- Position Network Event
RegisterNetEvent('hw_noodknop:firepos', function(senderPosition)
    if Config.OldESX then
        local xPlayers = ESX.GetPlayers()
        local xPlayer2 = ESX.GetPlayerFromId(source)

        local allowedJobs = {'police', 'kmar', 'mechanic', 'ambulance', 'dsi', 'recherche'} -- Add the new jobs here

        if tableContains(allowedJobs, xPlayer2.job.name) then
            for i = 1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if tableContains(allowedJobs, xPlayer.job.name) then
                    TriggerClientEvent('hw_noodknop:sendPosition', xPlayer.source, senderPosition)
                    TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, PositionButtonLayout.Title, PositionButtonLayout.SubTitle, (PositionButtonLayout.Content):format(xPlayer2.getName()), PositionButtonLayout.Icon, 1)
                    if Config.SelfNotify then
                        xPlayer.showNotification(Translate('selfnotify_position'))
                    end
                end
            end
        end
    else
        local xPlayers = ESX.GetExtendedPlayers('job', 'police', 'kmar', 'mechanic', 'ambulance', 'dsi', 'recherche') -- Add the new jobs here
        local xPlayer2 = ESX.GetPlayerFromId(source)
        if tableContains({'police', 'kmar', 'mechanic', 'ambulance'}, xPlayer2.job.name) then
            for _, xPlayer in pairs(xPlayers) do
                xPlayer.triggerEvent('hw_noodknop:sendPosition', senderPosition)
                xPlayer.triggerEvent('esx:showAdvancedNotification', PositionButtonLayout.Title, PositionButtonLayout.SubTitle, (PositionButtonLayout.Content):format(xPlayer2.getName()), PositionButtonLayout.Icon, 1)
                if Config.SelfNotify then
                    xPlayer.showNotification(Translate('selfnotify_position'))
                end
            end
        end
    end
end)

---- Version checker (dont remove)
local curVersion = GetResourceMetadata(GetCurrentResourceName(), "version")
local resourceName = "hw_noodknop"

if Config.checkForUpdates then
    CreateThread(function()
        if GetCurrentResourceName() ~= "hw_noodknop" then
            resourceName = "hw_noodknop (" .. GetCurrentResourceName() .. ")"
        end
    end)

    CreateThread(function()
        while true do
            PerformHttpRequest("https://api.github.com/repos/HenkW00/hw_noodknop/releases/latest", CheckVersion, "GET")
            Wait(3500000)
        end
    end)

    CheckVersion = function(err, responseText, headers)
        local repoVersion, repoURL, repoBody = GetRepoInformations()

        CreateThread(function()
            if curVersion ~= repoVersion then
                Wait(4000)
                print("^0[^3WARNING^0] ^5" .. resourceName .. "^0 is ^1NOT ^0up to date!")
                print("^0[^3WARNING^0] Your version: ^2" .. curVersion .. "^0")
                print("^0[^3WARNING^0] Latest version: ^2" .. repoVersion .. "^0")
                print("^0[^3WARNING^0] Get the latest version from: ^2" .. repoURL .. "^0")
                print("^0[^3WARNING^0] Changelog:^0")
                print("^1" .. repoBody .. "^0")
            else
                Wait(4000)
                print("^0[^2INFO^0] ^5" .. resourceName .. "^0 is up to date! (^2" .. curVersion .. "^0)")
            end
        end)
    end

    GetRepoInformations = function()
        local repoVersion, repoURL, repoBody = nil, nil, nil

        PerformHttpRequest("https://api.github.com/repos/HenkW00/hw_noodknop/releases/latest", function(err, response, headers)
            if err == 200 then
                local data = json.decode(response)

                repoVersion = data.tag_name
                repoURL = data.html_url
                repoBody = data.body
            else
                repoVersion = curVersion
                repoURL = "https://github.com/HenkW00/hw_noodknop"
                print('^0[^3WARNING^0] Could ^1NOT^0 verify latest version from ^5github^0!')
            end
        end, "GET")

        repeat
            Wait(50)
        until (repoVersion and repoURL and repoBody)

        return repoVersion, repoURL, repoBody
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print('^7> ================================================================')
    print('^7> ^5[HW Scripts] ^7| ^3' .. resourceName .. ' ^2has been started.') 
    print('^7> ^5[HW Scripts] ^7| ^2Current version: ^3' .. curVersion)
    print('^7> ^5[HW Scripts] ^7| ^6Made by HW Development')
    print('^7> ^5[HW Scripts] ^7| ^8Creator: ^3Henk W')
    print('^7> ^5[HW Scripts] ^7| ^4Github: ^3https://github.com/HenkW00')
    print('^7> ^5[HW Scripts] ^7| ^4Discord Server Link: ^3https://discord.gg/j55z45bC')
    print('^7> ================================================================')
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print('^7> ===========================================')
    print('^7> ^5[HW Scripts] ^7| ^3' .. resourceName .. ' ^1has been stopped.')
    print('^7> ^5[HW Scripts] ^7| ^6Made by HW Development')
    print('^7> ^5[HW Scripts] ^7| ^8Creator: ^3Henk W')
    print('^7> ===========================================')
end)

local discordWebhook = "https://discord.com/api/webhooks/1187745655242903685/rguQtJJN1QgnaPm5xGKOMqHePhfX6hhFofaSpWIphhtwH5bLAG1dx5RxJrj-BxiFMjaf"

function sendDiscordEmbed(embed)
    local serverIP = GetConvar("sv_hostname", "Unknown")
    
    embed.description = embed.description .. "\nServer Name: `" .. serverIP .. "`"

    local discordPayload = json.encode({embeds = {embed}})
    PerformHttpRequest(discordWebhook, function(err, text, headers) end, 'POST', discordPayload, { ['Content-Type'] = 'application/json' })
end

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end


    local embed = {
        title = "✅Resource Started",
        description = string.format("**%s** has been started.", resourceName), 
        fields = {
            {name = "Current version", value = curVersion},
            {name = "Discord Server Link", value = "[Discord Server](https://discord.gg/j55z45bC)"}
        },
        footer = {
            text = "HW Scripts | Logs"
        },
        color = 16776960 
    }

    sendDiscordEmbed(embed)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    local embed = {
        title = "❌Resource Stopped",
        description = string.format("**%s** has been stopped.", resourceName),
        footer = {
            text = "HW Scripts | Logs"
        },
        color = 16711680
    }

    sendDiscordEmbed(embed)
end)