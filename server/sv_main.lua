local RSGCore = exports['rsg-core']:GetCoreObject()
local awards = {}

-- Function to load awards from database
local function loadAwards()
    MySQL.Async.fetchAll('SELECT * FROM awards', {}, function(result)
        for _, award in pairs(result) do
            -- Assuming 'name' is a unique identifier for awards
            awards[award.name] = award.id
        end
    end)
end

-- Initialize awards on server start
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        loadAwards()
    end
end)

-- Function to get a player's citizenid
local function getPlayerCitizenId(playerId)
    local Player = RSGCore.Functions.GetPlayer(playerId)
    return Player and Player.PlayerData.citizenid or nil
end

local function giveAward(playerId, awardName)
    local citizenid = getPlayerCitizenId(playerId)
    -- Check if the player already has the award
    MySQL.Async.fetchScalar('SELECT COUNT(*) FROM player_awards WHERE citizenid = @citizenid AND award_name = @awardName', {
        ['@citizenid'] = citizenid,
        ['@awardName'] = awardName
    }, function(count)
        if count < 1 then
            -- Player doesn't have the award, give it to them
            MySQL.Async.execute('INSERT INTO player_awards (citizenid, award_name) VALUES (@citizenid, @awardName)', {
                ['@citizenid'] = citizenid,
                ['@awardName'] = awardName
            }, function(rowsChanged)
                if rowsChanged > 0 then
                    -- Notify player of new award
                    TriggerClientEvent('rsg-awards:showAwardNotification', playerId, {name = awardName})
                end
            end)
        end
    end)
end

-- Function to increment activity count and check for award
local function incrementActivity(playerId, activityName)
    local citizenid = getPlayerCitizenId(playerId)

    MySQL.Async.execute('INSERT INTO player_activities (citizenid, activity_name, count) VALUES (@citizenid, @activityName, 1) ON DUPLICATE KEY UPDATE count = count + 1', {
        ['@citizenid'] = citizenid,
        ['@activityName'] = activityName
    }, function(affectedRows)
        if affectedRows > 0 then
            -- Check the count and award if threshold is reached
            MySQL.Async.fetchScalar('SELECT count FROM player_activities WHERE citizenid = @citizenid AND activity_name = @activityName', {
                ['@citizenid'] = citizenid,
                ['@activityName'] = activityName
            }, function(count)
                for level, threshold in pairs(Config.awardThreshold[activityName] or {}) do
                    if count == threshold then
                        local awardName = activityName .. level  -- Construct the award name, like 'GoldProspectingBronze'
                        giveAward(playerId, awardName)
                        break  -- Stop checking other levels
                    end
                end
            end)
        end
    end)
end

-- Exported function for other scripts
exports('incrementPlayerActivity', function(playerId, activityName)
    incrementActivity(playerId, activityName)
end)


-- Debug event to increment activity
RegisterNetEvent("rsg-awards:debugIncrementActivity")
AddEventHandler("rsg-awards:debugIncrementActivity", function(activityName)
    local playerId = source
    incrementActivity(playerId, activityName)
    print("Debug: Incremented activity " .. activityName .. " for player ID " .. playerId)
end)
