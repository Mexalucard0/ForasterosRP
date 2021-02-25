client_script {
	"client.lua"
}

server_script {
	'@mole_utils/servermemorydebug.lua',
	'@mysql-async/lib/MySQL.lua',
	"server.lua"
}


-- {
-- 	"display": "Police",
-- 	"subMenu": [
-- 		{
-- 			"title": "Envoyer un message",
-- 			"eventName": "esx_addons_gcphone:call",
-- 			"type": {
-- 				"number": "police"
-- 			}
-- 		}
-- 	]
-- }