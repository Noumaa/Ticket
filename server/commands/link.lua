---Split a string into an array at every `separator` character
---@param string string
---@param separator string
---@return table
local function split(string, separator)
    if separator == nil then
        separator = "%s"
    end
    local t={}
    for str in string.gmatch(string, "([^"..separator.."]+)") do
        table.insert(t, str)
    end
    return t
end

---Return the SHA-1 hash based on the player's Steam ID.
---@param playerId number
---@return string
local function getSteamHashFromId(playerId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    local steamHash = split(identifier, ':')[2]
    return steamHash
end

---@param source number
---@param args table
RegisterCommand('link', function(source, args)

    local callback = function (errorCode, resultData, resultHeaders)
        if errorCode == 409 then
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Compte déjà activé',
                description = 'Le compte associé à la clé est déjà activé.',
                type = 'error'
            })
        elseif errorCode == 404 then
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Clé introuvable',
                description = 'La clé que vous avez fournie n\'existe pas.',
                type = 'error'
            })
        elseif errorCode == 200 then
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Compte site activé',
                description = 'Votre compte est maintenant lié au serveur.',
                type = 'success'
            })
        end
    end

    local method = "POST"
    local data   = json.encode({
        args[1],
        getSteamHashFromId(source)
    })

    PerformHttpRequest("http://test.radiantrp.fr/link", callback, method, data)

end, false)
