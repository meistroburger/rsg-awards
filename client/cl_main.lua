local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('rsg-awards:showAwardNotification')
AddEventHandler('rsg-awards:showAwardNotification', function(award)
    local formattedName = formatAwardName(award.name)
    local text = "You have received an award: " .. formattedName
    print(text)
    exports["uifeed"]:showAdvancedNotification('Award Received', text, "INVENTORY_ITEMS", "provision_diamond", 7500, "COLOR_WHITE")
end)

-- Function to format award names
function formatAwardName(name)
    -- Split the name into words based on capital letters
    local words = {}
    for word in string.gmatch(name, '[A-Z][^A-Z]*') do
        table.insert(words, word)
    end

    -- Rejoin the words with spaces and return
    return table.concat(words, " ")
end