--[[

    Functions

]]

function GetClosestPlayers(coords, distance)
    local players = {}
    local currentID = PlayerId()
    for _, playerID in ipairs(GetActivePlayers()) do
        local playerCoords = GetEntityCoords(GetPlayerPed(playerID))
        if #(coords - playerCoords) <= distance and playerID ~= currentID then
            table.insert(players, GetPlayerServerId(playerID))
        end
    end
    return players
end

function CreateNewForm(aDocument)
    aDocument.headerFirstName = exports["np-base"]:getChar("first_name")
    aDocument.headerLastName = exports["np-base"]:getChar("last_name")
    aDocument.headerDateOfBirth = exports["np-base"]:getChar("dob")
    aDocument.headerJobLabel = aDocument.job or exports["np-jobs"]:jobName(exports["np-base"]:getChar("job"))

    if aDocument.job then
        aDocument.job = nil
    end

    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "createNewForm",
        data = aDocument
    })
end

function ViewDocument(aDocument)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "ShowDocument",
        data = aDocument,
    })
end

function ShowDocument(aDocument)
    local players = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 2.0)

    for i, v in ipairs(players) do
        TriggerServerEvent("np-documents:showDocument", v, aDocument)
    end

    TriggerEvent("DoLongHudText", "Document shown to " .. #players .. " player(s)")
end

function CopyDocument(aDocument)
    local players = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 2.0)

    for i, v in ipairs(players) do
        TriggerServerEvent("np-documents:copyDocument", v, aDocument)
    end

    TriggerEvent("DoLongHudText", "Document sent to " .. #players .. " player(s)")
end

function DeleteDocument(id)
    if not id then return end

    local deleted = RPC.execute("np-documents:deleteDocument", id)
    if deleted then
        TriggerEvent("np-documents:openDocuments")
    end
end

--[[

    Events

]]

RegisterNetEvent("np-documents:openDocuments")
AddEventHandler("np-documents:openDocuments", function()
    local data = {}

    local publicdocuments = {}
    for i, v in ipairs(Config["Documents"]["public"]) do
        table.insert(publicdocuments, {
            title = v.headerTitle,
            description = "",
            action = "np-documents:CreateNewForm",
            params = v,
        })
    end

    table.insert(data, {
        title = "Public Documents",
        description = "",
        children = publicdocuments,
    })

    local job = exports["np-base"]:getChar("job")
    if Config["Documents"]["Jobs"][job] then
        local jobdocuments = {}
        for i, v in ipairs(Config["Documents"]["Jobs"][job]) do
            table.insert(jobdocuments, {
                title = v.headerTitle,
                description = "",
                action = "np-documents:CreateNewForm",
                params = v,
            })
        end

        table.insert(data, {
            title = "Job Documents",
            description = "",
            children = jobdocuments,
        })
    end

    local mydocuments = {}
    local _mydocuments = RPC.execute("np-documents:getDocuments", "cid", exports["np-base"]:getChar("id"))
    for i, v in ipairs(_mydocuments) do
        local actions = {
            { title = "View", action = "np-documents:ViewDocument", params = v.data },
            { title = "Show", action = "np-documents:ShowDocument", params = v.data },
            { title = "Copy", action = "np-documents:CopyDocument", params = v.data },
            { title = "Delete", children = {
                { title = "Confirm Delete", action = "np-documents:DeleteDocument", params = v.id },
            } },
        }

        table.insert(mydocuments, {
            title = v.data.headerTitle,
            description = "Date: " .. v.data.headerDateCreated,
            children = actions,
        })
    end

    table.insert(data, {
        title = "Personal Documents",
        description = "",
        children = mydocuments,
    })

    local groups = exports["np-base"]:getChar("groups")
    if #groups > 0 then
        local _groups = {}
        for i, v in ipairs(groups) do
            local groupdocuments = {}
            local _groupdocuments = RPC.execute("np-documents:getDocuments", "group", v.group)
            for i2, v2 in ipairs(_groupdocuments) do
                local actions = {
                    { title = "View", action = "np-documents:ViewDocument", params = v2.data },
            { title = "Show", action = "np-documents:ShowDocument", params = v2.data },
            { title = "Copy", action = "np-documents:CopyDocument", params = v2.data },
                }

                if exports["np-groups"]:GroupRankInfo(v.group, "documents") then
                    table.insert(actions, {
                        title = "Delete", children = {
                            { title = "Confirm Delete", action = "np-documents:DeleteDocument", params = v2.id },
                        }
                    })
                end

                table.insert(groupdocuments, {
                    title = v2.data.headerTitle,
                    description = "Date: " .. v2.data.headerDateCreated,
                    children = actions,
                })
            end

            table.insert(_groups, {
                title = v.name,
                description = "",
                children = groupdocuments,
            })
        end

        table.insert(data, {
            title = "Group Documents",
            description = "",
            children = _groups,
        })
    end

    exports["np-context"]:showContext(data)
end)

RegisterNetEvent("np-documents:CreateNewForm")
AddEventHandler("np-documents:CreateNewForm", CreateNewForm)

RegisterNetEvent("np-documents:ViewDocument")
AddEventHandler("np-documents:ViewDocument", ViewDocument)

RegisterNetEvent("np-documents:ShowDocument")
AddEventHandler("np-documents:ShowDocument", ShowDocument)

RegisterNetEvent("np-documents:CopyDocument")
AddEventHandler("np-documents:CopyDocument", CopyDocument)

RegisterNetEvent("np-documents:DeleteDocument")
AddEventHandler("np-documents:DeleteDocument", DeleteDocument)

--[[

    NUI

]]

RegisterNUICallback("form_close", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("form_submit", function(data, cb)
    SetNuiFocus(false, false)

    local callback = nil
    if data.callback then
        callback = data.callback
        data.callback = nil
    end

    local cid = exports["np-base"]:getChar("id")
    local group = nil

    if data.group then
        group = data.group
        data.group = nil
    end

    for i, v in ipairs(data.elements) do
        v.can_be_edited = false
    end

    RPC.execute("np-documents:submitDocument", data, cid, group)

    if callback then
        TriggerEvent(callback.event, callback.params)
    end
end)