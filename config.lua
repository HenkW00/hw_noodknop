-- Framework & Debug Function (ignore)
ESX = exports["es_extended"]:getSharedObject()
debugPrint = function(message) if Config.Debug then print(message) end end

-- Configuration
Config = { 
    Locale = 'en', -- your language, this script comes with: en, de 
    Debug = true, -- gives more information
    OldESX = true, -- put this to true if you are using ESX 1.2 or 1.1

    ChatSuggestions = true, -- show chat suggestions
    PanicButton = 'F11', -- standard key for keymapping
    PositionButton = 'F9', -- standard key for keymapping
    Cooldown = 3, -- (in seconds)
    SelfNotify = true, -- send notify to player that pushes panic/gps button
}

Blip = {
    Enabled = true,
    Time = 30,
    FlashInterval = 200,
}

Sounds = { -- requires: xsound
    Enabled = true,
    URL = 'https://www.youtube.com/watch?v=4-A3b9ztnDQ',
    Volume = 2.0
}

PanicButtonLayout = {
    Title = 'Meldkamer Amsterdam', -- title of the notification
    SubTitle = '~r~Noodknop', -- subtitle of the notification (not used for qb-core)

    Content = 'Speler %s heeft met spoed assistentie nodig!', -- "%s" is the officer name
    Icon = 'CHAR_CALL911' -- icons can be found here: https://wiki.rage.mp/index.php?title=Notification_Pictures
}

PositionButtonLayout = {
    Title = 'Meldkamer Amsterdam',
    SubTitle = '~b~Locatie verstuurd',

    Content = 'Speler %s heeft zijn locatie verstuurd!',
    Icon = 'CHAR_CALL911'
}
