RegisterNetEvent("tickets:open_report_detail", function (args)

    ESX.TriggerServerCallback("tickets:GetTicketFromId", function(ticket)

        lib.registerContext({
            id = 'menu_report_detail',
            title = "Ticket #"..ticket.id.."",
            menu = 'menu_report_list',
            options = {
                {
                    title = 'Plaignant',
                    icon = 'handshake-angle',
                    description = ticket.name,
                },
                {
                    title = 'Accusé',
                    icon = 'handcuffs',
                    description = ticket.reported_name,
                },
                {
                    title = 'Message',
                    icon = 'envelope',
                    description = ticket.description,
                },
                {
                    title = 'Supprimer',
                    icon = 'trash',
                    iconColor = '#fa5252',
                    description = "Attention, cette action est irreversible.",
                    onSelect = function ()
                        local input = lib.alertDialog({
                            header = 'Êtes-vous sûr ?',
                            content = 'Voulez-vous vraiment supprimer le ticket #'..ticket.id..' ?',
                            centered = true,
                            cancel = true,
                            labels = {
                                cancel = 'Annuler',
                                confirm = 'Confirmer'
                            }
                        })
                        if not input or input ~= "confirm" then
                            lib.showContext('menu_report_detail')
                        else
                            ESX.TriggerServerCallback("tickets:RemoveTicketFromId", function (removed)
                                if removed then
                                    lib.notify({
                                        title = 'Suppression effectuée',
                                        description = 'Le ticket #'..ticket.id..' a bien été supprimé.',
                                        type = 'success'
                                    })
                                    ExecuteCommand('reports')
                                else
                                    lib.notify({
                                        title = 'Suppression échouée',
                                        description = 'Le ticket #'..ticket.id..' n\'a pas pu être supprimé. #003',
                                        type = 'error'
                                    })
                                    lib.showContext('menu_report_detail')
                                end
                            end, ticket.id)
                        end
                    end
                },
            }
        })

        lib.showContext('menu_report_detail')

    end, {id = args.ticketId})

end)