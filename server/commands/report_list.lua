RegisterCommand('reports', function(source, args)

    local tickets = MySQL.query.await('SELECT * FROM `tickets_ticket`', nil)
    if not tickets then return end

    local response = {}

    for i = 1, #tickets, 1 do
        local player = ESX.GetPlayerFromIdentifier(tickets[i].identifier)
        local reported = ESX.GetPlayerFromIdentifier(tickets[i].reported_identifier)

        table.insert(response, {
            id = tickets[i].id,
            name = player.getName(),
            reported_name = reported.getName(),
            description = tickets[i].description})
    end

    TriggerClientEvent('tickets:open_report_list', source, response)

end, false)
