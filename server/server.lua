ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent("forcng_jobcenter:server:setJob", function(jobName)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if not xPlayer then
        return
    end

    local availableToGrab = false

    -- Grade is Already Checked From The Config, But This Ensures That It Doesn't Get Exploited
    local jobGrade = 0
    for _, v in pairs(Config.Jobs) do
        if v.job == jobName then
            availableToGrab = true
            jobGrade = v.grade or 0
            break
        end
    end

    if availableToGrab then
        xPlayer.setJob(jobName, jobGrade)
        TriggerClientEvent("forcng_jobcenter:client:notify", src, "success", ("Your job has been set to %s."):format(jobName))
    else
        TriggerClientEvent("forcng_jobcenter:client:notify", src, "error", "This job is not available.")
    end
end)
