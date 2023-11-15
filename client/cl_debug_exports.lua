local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterCommand("debug-goldxp", function(source, args, raw)
    TriggerServerEvent("rsg-awards:debugIncrementActivity", "GoldProspecting")
end, false)
