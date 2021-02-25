Citizen.CreateThread(function()
    while true do

        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(597168751200174100)
        SetDiscordRichPresenceAsset('forasteros') --Big picture asset name
        SetDiscordRichPresenceAssetText('Forasteros Rp.') --Big picture hover text
        --SetDiscordRichPresenceAssetSmall('forasteros') --Small picture asset name
       -- SetDiscordRichPresenceAssetSmallText('Forasteros Rp.') --Small picture hover text
        --It updates every one minute just in case.
		Citizen.Wait(60000)
	end
end)
RegisterNetEvent("mole_utils:presencecount")
AddEventHandler("mole_utils:presencecount", function(count)
    SetDiscordAppId(597168751200174100)
    SetRichPresence(count.. " jugadores")
end)
