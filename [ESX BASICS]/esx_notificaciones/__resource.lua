resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
description "Simple notifications using https://notifyjs.com/ | Re-made by Lirol"

ui_page "html/index.html"

client_script "notifications.lua"

export "LirolShowNotification"
export "LirolShowAdvancedNotification"
export "LirolShowProgressBar"
esport "LirolDrawTxt"
export "SetQueueMax"
export "SendNotification"
export "SendSendPrompt"

files {
    "html/index.html",
    "html/notificaciones.js",
    "html/noty.js",
    "html/noty.css",
    "html/animate.css",
    "html/themes/notificaciones.css",    
    "html/themes/gta.css",    
    "html/ChaletLondonNineteenSixty.ttf",
    "html/ChaletParisNineteenSixty.ttf"
    
}

dependency 'esx_comp'

client_script '@exm_debug/Shareds/ToLoad.lua'