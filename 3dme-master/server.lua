-- ## 3dme : server side

-- Command
RegisterCommand('me', function(source, args)
    local text = '~r~ME:~w~ ' .. table.concat(args, " ")
    TriggerClientEvent('3dme:shareDisplay', -1, text, source)
end)

RegisterCommand('do', function(source, args)
    local text = '~y~DO:~w~ ' .. table.concat(args, " ")
    TriggerClientEvent('3ddo:shareDisplay', -1, text, source)
end)