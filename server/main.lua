ESX.RegisterServerCallback("tickets:GetTicketFromId", function(src, cb, args)
    local result = MySQL.query.await('SELECT * FROM `tickets_ticket` WHERE id = ?', {args.id})
    if not result then return end

    local ticket = result[1]

    local player = ESX.GetPlayerFromIdentifier(ticket.identifier)
    local reported = ESX.GetPlayerFromIdentifier(ticket.reported_identifier)

    local response = ticket
    response['name'] = player.getName()
    response['reported_name'] = reported.getName()

    cb(response)
end)

ESX.RegisterServerCallback('tickets:RemoveTicketFromId', function (source, cb, id)
    local result = MySQL.query.await('DELETE FROM `tickets_ticket` WHERE id = ?', { id })
    if not result then cb(false) return end
    cb(true)
end)

ESX.RegisterServerCallback("tickets:report", function(src, cb, args)
    local player = ESX.GetPlayerFromId(args.source)
    local reported = ESX.GetPlayerFromId(args.reported_identifier)

    if not player then
        cb("not player")
        return
    end

    if not reported then
        cb("not reported")
        return
    end

    if not args.description then
        cb("not description")
        return
    end

    local description_real_length = string.len(string.gsub(args.description, "%s+", ""))

    if description_real_length == 0 then
        cb("not description filled")
        return
    end

    MySQL.insert('INSERT INTO `tickets_ticket` (identifier, type_id, reported_identifier, description) VALUES (?, ?, ?, ?)', {
        player.getIdentifier(),
        1,
        reported.getIdentifier(),
        args.description
    }, function (id)
        cb("done")
    end)
end)
