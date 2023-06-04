RegisterCommand('report', function(source, args)

    local players = lib.callback.await('tickets:GetNearbyPlayers', source, 200)

    local options = {}

    for i = 1, #players do
        table.insert(options, {
            value = i,
            label = ESX.GetPlayerFromId(players[i].id).getName()
        })
    end

    TriggerClientEvent("tickets:open_report", source, options)

end, false)
