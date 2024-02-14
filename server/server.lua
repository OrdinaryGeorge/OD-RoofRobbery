QBCore = exports['qb-core']:GetCoreObject()
local sqlresult
-- sql --

QBCore.Functions.CreateCallback("OD-Roof:GetRep", function(source, cb)
    local cid = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
    MySQL.query('SELECT rep FROM roof_robbery_rep WHERE citizenid = \''.. cid .. '\'', {}, function(result)
        if next(result) == nil then
            MySQL.query('INSERT INTO roof_robbery_rep (citizenid, rep, fails) VALUES (\''.. cid .. '\', 0, 0)', {}, function(result)
                cb(result)
            end)
        else
            cb(result)
        end
    end)
end)

QBCore.Functions.CreateCallback("OD-Roof:UpdateRep", function(source, cb)
    local cid = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
    local rep = math.random(0, 7)
    MySQL.query('SELECT rep FROM roof_robbery_rep WHERE citizenid = \''.. cid .. '\'', {}, function(result)
        if result[1] then
            rep = rep + result[1].rep
        end
        print('^2 [DEBUG] ^7 Rep Added To '.. cid..': '.. rep)
        MySQL.query('UPDATE roof_robbery_rep SET rep = '..rep..' WHERE citizenid = \''.. cid .. '\'', {}, function(result)
            cb(result)
        end)
    end)
end)
-- events --

RegisterNetEvent("OD-Roof:GiveRewards", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(Config.RewardItem, Config.RewardItemAmount)
end)