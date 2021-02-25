resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Mole Status'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/status.lua',
	'client/main.lua',
	'client/carhud.lua',
	'client/autopilot.lua',
	'client/voicegps.lua',
	'client/voice.lua'
}

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/css/app.css',
	'html/scripts/app.js',
	'html/logo.png',
	'html/logo_navidad.png',
	'html/img/vehicle-gear.png',
	'html/img/vehicle-lights.png',
	'html/img/vehicle-lights-high.png',
	'html/img/vehicle-seatbelt.png',
	'html/img/defcon1.png',
	'html/img/defcon2.png',
	'html/img/defcon3.png',
	'html/img/defcon4.png',
	'html/img/defcon5.png',
	'html/fonts/Adventure.otf',
	'html/fonts/bankgothic.ttf',
	
}

