local pedModel = 's_m_m_highsec_01'
local PedCoords = Config.PedCoords
local PedHeading = Config.PedHeading

CreateThread(function()
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(100)
    end

    local ped = CreatePed(0, pedModel, PedCoords.x, PedCoords.y, PedCoords.z - 1.0, PedHeading, false, true)
    SetEntityInvincible(ped, true)
    SetEntityAsMissionEntity(ped, true, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)


    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'jobs',
            icon = 'fa-solid fa-briefcase',
            label = 'Open Job Center',
            onSelect = function()
                JobsAvailableToPlayersToday()
            end
        }
    })
end)

function JobsAvailableToPlayersToday()
    local options = {}

    for _, job in pairs(Config.Jobs) do
        table.insert(options, {
            title = ('%s'):format(job.label),
            icon = "fa-solid fa-user-doctor",
            onSelect = function()
                TriggerServerEvent('forcng_jobcenter:server:setJob', job.job)
            end
        })
    end

    lib.registerContext({
        id = 'jobs',
        title = 'Whitelisted Job Center',
        options = options
    })

    lib.showContext('jobs')
end

RegisterNetEvent('forcng_jobcenter:client:notify', function(type, message)
    lib.notify({
        title = 'Job Center',
        description = message,
        type = type,
        position = 'center-right',
        icon = "fa-solid fa-user-doctor",
    })
end)
