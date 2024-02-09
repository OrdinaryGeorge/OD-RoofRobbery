QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("OD-Roof:GetRep", function(source, cb)
    local cid = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
    MySQL.query('SELECT rep FROM roof_robbery_rep WHERE cid = '.. cid, {}, function(result)
        cb(result)
    end)
end)

RegisterNetEvent("OD-Roof:GiveRewards", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(Config.RewardItem, Config.RewardItemAmount)
end)