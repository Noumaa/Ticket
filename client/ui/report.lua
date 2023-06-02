RegisterNetEvent("tickets:open_report", function (playersOptions)

    local input = lib.inputDialog('Signaler', {
        {
            type = 'select',
            label = 'Objet',
            options = {
                {
                    value = "1",
                    label = "Joueur / plainte"
                },
                {
                    value = "2",
                    label = "Serveur / problème technique"
                },
                {
                    value = "3",
                    label = "Use-bug / glitch / duplication"
                }
            },
            default = "1",
            required = true,
        },
        {
            type = 'select',
            label = 'Joueur',
            options = playersOptions,
        },
        'Raison'
    },
    {
        'Annuler',
        'Confirmer'
    })

    if not input then return end

    ESX.TriggerServerCallback('tickets:report', function(exception)

        if exception == "not player" then
            lib.notify({
                title = 'Joueur introuvable',
                description = 'Veuillez contacter le développeur. #001',
                type = 'error'
            })
        elseif exception == "not reported" then
            lib.notify({
                title = 'Joueur introuvable',
                description = 'Le joueur spécifié n\'existe pas.',
                type = 'error'
            })
        elseif exception == "not description" then
            lib.notify({
                title = 'Raison invalide',
                description = 'Veuillez contacter le développeur. #002',
                type = 'error'
            })
        elseif exception == "not description filled" then
            lib.notify({
                title = 'Raison invalide',
                description = 'Vous devez remplir la raison de votre demande.',
                type = 'error'
            })
        else
            lib.notify({
                title = 'Signalement envoyé',
                description = 'Votre demande a bien été prise en compte.',
                type = 'success'
            })
        end

    end, {
        source = GetPlayerServerId(PlayerId()),
        reported_identifier = input[1],
        description = input[2]
    })
end)