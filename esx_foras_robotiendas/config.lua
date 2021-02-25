Config = {}
Translation = {}

Config.Shopkeeper = 416176080
Config.Locale = 'es'
Config.MaxSimultaneusRobs = 3
Config.MinCoolDownMinutes = 30
Config.MaxCoolDownMinutes = 60
Config.CivilianLimitMinutes = 5 * 60

Config.Shops = {
    -- {coords = vector3(x, y, z), heading = peds heading, money = {min, max}, cops = amount of cops required to rob, blip = true: add blip on map false: don't add blip, name = name of the store (when cops get alarm, blip name etc)}
    {coords = vector3(372.9643, 328.3384, 103.5664-0.98), heading = 253.99, money = {8000, 10000}, cops = 4, blip = false, name = '24/7', cooldown = {60,120}, robbed = false}, --Galaxy
    {coords = vector3(1164.871, -323.149, 69.2051-0.98), heading = 101.76, money = {8000, 10000}, cops = 4, blip = false, name = '24/7', cooldown = {60,120}, robbed = false}, --Mirror Park
    {coords = vector3(-2966.27, 391.67, 15.04-0.98), heading = 88.24, money = {8000, 10000}, cops = 4, blip = false, name = '24/7', cooldown = {60,120}, robbed = false}, -- Flecca Izquierda
    {coords = vector3(1728.613, 6416.802, 35.037-0.98), heading = 245.175, money = {8000, 10000}, cops = 4, blip = false, name = '24/7', cooldown = {60,120}, robbed = false}, --Autopista Paleto
    {coords = vector3(549.4454, 2669.446, 42.156-0.98), heading = 98.446, money = {8000, 10000}, cops = 4, blip = false, name = '24/7', cooldown = {60,120}, robbed = false}, --Shandy Animales
    {coords = vector3(1698.279, 4922.418, 42.063-0.98), heading = 323.333, money = {8000, 10000}, cops = 4, blip = false, name = '24/7', cooldown = {60,120}, robbed = false}, --Trevor
    {coords = vector3(2676.328, 3280.194, 55.2411-0.98), heading = 331.951, money = {6000, 10000}, cops = 4, blip = false, name = '24/7', cooldown = {60,120}, robbed = false}, --Ikea
    --{coords = vector3(-1221.571,-908.299,12.326-0.98), heading = 34.694, money = {8000, 10000}, cops = 4, blip = false, name = 'Licorería', cooldown = {60,120}, robbed = false}, --Vespucci
    {coords = vector3(24.302,-1345.452,29.497-0.98), heading = 274.895, money = {8000, 10000}, cops = 4, blip = false, name = '24/7', cooldown = {60,120}, robbed = false}, --Vanilla
    --{coords = vector3(-1486.381,-377.476,40.163-0.98), heading = 137.767, money = {8000, 10000}, cops = 4, blip = false, name = 'Licorería', cooldown = {60,120}, robbed = false}, --Bahamas
    {coords = vector3(2555.368,380.706,108.623-0.98), heading = 4.213, money = {8000, 10000}, cops = 4, blip = false, name = '24/7', cooldown = {60,120}, robbed = false}, --Autopista Derecha
    --{coords = vector3(1958.976,3741.547,32.344-0.98), heading = 302.344, money = {6000, 10000}, cops = 4, blip = false, name = '24/7', cooldown = {60,120}, robbed = false}, --Shandy Policia
    {coords = vector3(-1486.03,-377.78,40.16-0.98), heading = 140.7, money = {8000, 10000}, cops = 4, blip = false, name = 'Licorería', cooldown = {60,120}, robbed = false}, --North Rockford Drive
    {coords = vector3(1134.12,-982.26,46.42-0.98), heading = 278.99, money = {8000, 10000}, cops = 4, blip = false, name = 'Licorería', cooldown = {60,120}, robbed = false}, --Mirror Park Sur
    {coords = vector3(-1819.83,794.22,138.08-0.98), heading = 129.5, money = {8000, 10000}, cops = 4, blip = false, name = 'Licorería', cooldown = {60,120}, robbed = false}, --Banham Canyon Drive

}

Translation = {
    ['es'] = {
        ['shopkeeper'] = 'tendero',
        ['robbed'] = "ya me han robado, ~r~no ~w~tengo más dinero!",
        ['cashrecieved'] = 'Robaste:',
        ['currency'] = '$',
        ['scared'] = 'Asustado:',
        ['no_cops'] = 'No hay ~r~policias~w~ suficientes!',
        ['cop_msg'] = 'Estoy viendo un atraco en esta tienda, les envío una foto del ladrón!',
        ['set_waypoint'] = 'Activa GPS hacia la tienda',
        ['hide_box'] = 'Cierra esta caja',
        ['robbery'] = 'Robo en curso',
        ['walked_too_far'] = 'Te has alejado demasiado!'
    }
}