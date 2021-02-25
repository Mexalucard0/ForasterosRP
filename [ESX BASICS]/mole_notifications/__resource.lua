resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
description "Centralized notification system for FiveM by Mole"

ui_page "html/index.html"

client_script "notifications.lua"

export "MoleShowNotification"
export "MoleShowAdvancedNotification"
export "MoleShowProgressBar"
esport "MoleDrawTxt"
export "SetQueueMax"
export "SendNotification"
export "SendSendPrompt"

files {
    "html/index.html",
    "html/mole_notifications.js",
    "html/noty.js",
    "html/noty.css",
    "html/animate.css",
    "html/themes/forasteros.css",    
    "html/themes/gta.css",    
    "html/sound-example.wav",
    "html/ChaletLondonNineteenSixty.ttf",
    "html/ChaletParisNineteenSixty.ttf"
    
}
dependencies {
    'mole_utils'
}
