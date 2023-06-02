RegisterNetEvent("tickets:open_report_list", function (rows)
    local options = { }

    if #rows == 0 then
        options = {
            {
                title = "Aucun ticket",
                description = "Il n'y a rien à voir par ici.",
                icon = 'check',
            }
        }
    else
        for i = 1, #rows, 1 do
            table.insert(options, {
                title = rows[i].name,
                description = rows[i].description,
                event = 'tickets:open_report_detail',
                args = {
                    ticketId = rows[i].id
                },
                arrow = true,
                -- icon = 'hand',
                -- metadata = {
                --     {label = 'Value 1', value = 'Some value'},
                --     {label = 'Value 2', value = 300}
                -- },
            })
        end
    end

    lib.registerContext({
        id = 'menu_report_list',
        title = 'Tickets',
        options = options
      })
    
    lib.showContext('menu_report_list')

end)