RegisterCommand("debugAward", function(source, args, rawCommand)
    -- Ensure that the activity name is provided
    if #args < 1 then
        print("Usage: /debugAward [activityName]")
        return
    end

    local activityName = args[1]
    local validActivities = {
        "GoldProspecting",
        "WildHorses",
        "Hunting",
        "Herbalist",
        "Thief",
        "Criminal"
    }

    -- Check if the provided activity is valid
    if not table.contains(validActivities, activityName) then
        print("Invalid activity name. Valid names are: " .. table.concat(validActivities, ", "))
        return
    end

    -- Trigger the server to increment the activity
    TriggerServerEvent("rsg-awards:debugIncrementActivity", activityName)
end, false)

-- Utility function to check if a table contains a specific value
function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end
