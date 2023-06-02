RegisterNetEvent("tickets:notification", function (args)
    ESX.ShowNotification(args[1], args[2])
end)

lib.callback.register('tickets:GetNearbyPlayers', function(radius)
    local nearbyPlayers = lib.GetNearbyPlayers(GetEntityCoords(cache.ped), radius, true)
    return nearbyPlayers
end)