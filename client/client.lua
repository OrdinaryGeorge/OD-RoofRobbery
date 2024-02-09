QBCore = exports['qb-core']:GetCoreObject()
local ped = PlayerPedId()
local job = false
local searching = false
local JobLoc = {} 
local randomloc = nil
local CompnentsNeeded = nil
local fails = 0
AirconModels = {'prop_aircon_m_04', 'prop_aircon_m_06', 'prop_aircon_m_01', 'prop_aircon_m_02'}

RegisterNetEvent("OD-Roof:MainMenu", function(data)
    Wait(5)
    local QuitButton = false
    local JobButton = false
    if job == false then
        QuitButton = true
    end
    if job == true or searching == true then
        JobButton = true
    end
    exports['qb-menu']:openMenu({
        {
            header = 'Roof Top Crobbas...',
            -- txt = 'Rep: '.. rep,
            icon = 'fas fa-code',
            isMenuHeader = true,
        },
        {
            header = 'Looking for a job?',
            txt = 'Sign Up!',
            icon = 'fas fa-code-merge',
            disabled = JobButton,
            params = {
                event = 'OD-Roof:SearchForJob',
            }
        },
        {
            header = 'Quit',
            icon = 'fas fa-terminal',
            disabled = QuitButton,
            params = {
                event = 'OD-Roof:QuitJob',
            }
        },
    })
end)

RegisterNetEvent('OD-Roof:SearchForJob', function()
    searching = true
    print('^2 [DEBUG] ^7 Triggered Searching For Job event')
    while job == false and searching == true do
        QBCore.Functions.Notify('Searching for job!', 'success', 1000)
        Wait(6000)
        RandomNum = math.random(1, 5)
        RandomNum2 = math.random(1, 5)
        print('^2 [DEBUG] ^7 Searching for job... '.. RandomNum..' '.. RandomNum2)
        if RandomNum == RandomNum2 then
            job = true
            StartJob()
        end
    end
end)

function StartJob()
    randomloc = math.random(1, #Config.Locations['Roofs'])
    print('^2 [DEBUG] ^7 Job Location: '..randomloc)
    JobLoc.x = Config.Locations["Roofs"][randomloc].coords.x
    JobLoc.y = Config.Locations["Roofs"][randomloc].coords.y
    JobLoc.z = Config.Locations["Roofs"][randomloc].coords.z
    JobLoc.id = randomloc
    CurrentBlip = AddBlipForCoord(JobLoc.x, JobLoc.y, JobLoc.z)
    SetBlipSprite(CurrentBlip, Config.BlipSprite)
    SetBlipColour(CurrentBlip, Config.BlipColour)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Rooftop Crobbas Location')
    EndTextCommandSetBlipName(CurrentBlip)
    if randomloc == 1 then
        CompnentsNeeded = math.random(1, 4)
    else
        CompnentsNeeded = math.random(1, 2)
    end
    print('^2 [DEBUG] ^7 Components Needed: '..CompnentsNeeded)
    QBCore.Functions.Notify('Job Found... Check your GPS!', 'primary', 1000)
    targset()
end

function targset()
    local JobZone = BoxZone:Create(vector3(JobLoc.x, JobLoc.y, JobLoc.z), 10.0, 10.0, {
        name = 'OD-Robbery:Rooftop'.. randomloc,
        heading = JobLoc.h,
        minZ = JobLoc.z - 10.0,
        maxZ = JobLoc.z + 10.0,
        debugPoly = false
    })
    print('^2 [DEBUG] ^7 Created JobZone...'.. JobZone.name)
    JobZone:onPlayerInOut(function(inside)
        if inside and CompnentsNeeded > 0 and job == true then
            local notifytxt = 'Steal '..CompnentsNeeded..' Compnent(s)'
            QBCore.Functions.Notify(notifytxt, 'primary', 1000)
            exports['qb-target']:AddTargetModel(AirconModels, {
                    options = {
                        {
                            event = "OD-Roof:Aircon",
                            icon = "fas fa-wrench",
                            label = "Steal Compnents",
                        },
                    },
                distance = 1.0
            })
            print('^2 [DEBUG] ^7 Creating Points...')
        else
            print('^2 [DEBUG] ^7 Destroying Points/Dropped...')
            exports['qb-target']:RemoveTargetModel(AirconModels)
        end
    end)
end

RegisterNetEvent("OD-Roof:Aircon", function(data)
    local model = GetEntityModel(data.entity)
    exports['np-minigame']:character(function(success)
        if success then
            print('^2 [DEBUG] ^7 Model Dropped: '.. model)
            QBCore.Functions.Progressbar("steal_components", "Stealing Components..", 1000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "mini@repair",
                anim = "fixing_a_player",
                flags = 16,
            }, {}, {}, function() -- Done
                StopAnimTask(ped, "mini@repair", "fixing_a_player", 1.0)
                ClearPedTasksImmediately(ped)
                SetEntityCoords(data.entity, 0,0,0 + 2,false,false,false,false)
                CompnentsNeeded = CompnentsNeeded - 1
                local notifytxt = 'Steal '..CompnentsNeeded..' Compnent(s)'
                QBCore.Functions.Notify(notifytxt, 'primary', 1000)
                TriggerServerEvent('OD-Roof:GiveRewards')
                if CompnentsNeeded == 0 then
                    print('^2 [DEBUG] ^7 Job Complete!')
                    QBCore.Functions.Notify('Job Complete!', 'primary', 1000)
                    exports['qb-target']:RemoveTargetModel(AirconModels)
                    JobFinish()
                end
            end, function() -- Cancel
                StopAnimTask(ped, "mini@repair", "fixing_a_player", 1.0)
                ClearPedTasksImmediately(ped)
            end)
        else
            fails = fails + 1
            if fails == 3 then
                TriggerServerEvent("InteractSound_SV:PlayWithinDistance", Config.FailAlarmDistance, Config.FailAlarmSound, Config.FailAlarmVolume)
                fails = 0
            end
            print("^2 [DEBUG] ^7 Failed")
        end
    end)
end)

function JobFinish()
    QBCore.Functions.Notify('Return to Larry for another job!', 'primary', 1000)
    RemoveBlip(CurrentBlip)
    job = false
    searching = false
    print('^2 [DEBUG] ^7 Jobs Done: ')
    print('^2 [DEBUG] ^7 Reset All Job!')
end

RegisterNetEvent('OD-Roof:QuitJob', function()
    QBCore.Functions.Notify('Canceld Job Succesfully!', 'primary', 1000)
    job = false
    searching = false
    exports['qb-target']:RemoveTargetModel(AirconModels)
    RemoveBlip(CurrentBlip)
    print('^2 [DEBUG] ^7 Jobs Done: ')
    print('^2 [DEBUG] ^7 Reset All Job!')
end)

-- TODO FOR LATER DATE

-- REP

-- IF JOB COMPLETE MAKE IT SO PLAYER CANT DO THAT JOB AGAIN