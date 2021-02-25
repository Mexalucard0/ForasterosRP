resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

description 'ESX Boombox'

version '1.0.0'

server_scripts {
    '@es_extended/locale.lua',
    'locales/fr.lua',
    'locales/en.lua',
    'locales/es.lua',
    'server/main.lua',
    'server/utils.lua',
    'config.lua'
}

client_script {
    '@es_extended/locale.lua',
    'client/main.lua',
    'client/utils.lua',
    'locales/fr.lua',
    'locales/es.lua',
    'locales/en.lua',
    'config.lua'
}

dependencies {
    'es_extended',
    'xsound'
}