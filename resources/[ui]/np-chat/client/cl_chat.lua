-- Variables

Controlkey = {["generalChat"] = {245,"T"}}
RegisterNetEvent("event:control:update")
AddEventHandler("event:control:update", function(table)
    Controlkey["generalChat"] = table["generalChat"]
end)

local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false

-- Functions

local function refreshThemes()
    local themes = {}

    for resIdx = 0, GetNumResources() - 1 do
        local resource = GetResourceByFindIndex(resIdx)

        if GetResourceState(resource) == "started" then
            local numThemes = GetNumResourceMetadata(resource, "chat_theme")

            if numThemes > 0 then
                local themeName = GetResourceMetadata(resource, "chat_theme")
                local themeData = json.decode(GetResourceMetadata(resource, "chat_theme_extra") or "null")

                if themeName and themeData then
                    themeData.baseUrl = "nui://" .. resource .. "/"
                    themes[themeName] = themeData
                end
            end
        end
    end

    SendNUIMessage({
        type = "ON_UPDATE_THEMES",
        themes = themes
    })
end

-- Internal events

RegisterNetEvent("__cfx_internal:serverPrint")
AddEventHandler("__cfx_internal:serverPrint", function(msg)
    print(msg)

    SendNUIMessage({
        type = "ON_MESSAGE",
        message = {
            color = { 0, 0, 0 },
            multiline = true,
            args = { msg }
        }
    })
end)

RegisterNetEvent("_chat:messageEntered")

-- NUI Callbacks

RegisterNUICallback("loaded", function(data, cb)
    TriggerServerEvent("chat:init")

    chatLoaded = true

    refreshThemes()

    cb("ok")
end)

RegisterNUICallback("chatResult", function(data, cb)
    chatInputActive = false
    SetNuiFocus(false)

    TriggerServerEvent("np-chat:texting", false)

    if not data.canceled then
        TriggerServerEvent("_chat:messageEntered", data.message)
    end

    cb("ok")
end)

-- Events

RegisterNetEvent("chatMessage")
AddEventHandler("chatMessage", function(author, color, text)
    if color == 8 then
        TriggerEvent("phone:addnotification",author,text)
        return
    end

    local args = { text }

    if author ~= "" then
        table.insert(args, 1, author)
    end

    SendNUIMessage({
        type = "ON_MESSAGE",
        message = {
            color = color,
            multiline = true,
            args = args
        }
    })
end)

RegisterNetEvent("chat:addMessage")
AddEventHandler("chat:addMessage", function(message)
    SendNUIMessage({
        type = "ON_MESSAGE",
        message = message
    })
end)

RegisterNetEvent("chat:addSuggestion")
AddEventHandler("chat:addSuggestion", function(name, help, params)
    SendNUIMessage({
        type = "ON_SUGGESTION_ADD",
        suggestion = {
            name = name,
            help = help,
            params = params or nil
        }
    })
end)

RegisterNetEvent("chat:addSuggestions")
AddEventHandler("chat:addSuggestions", function(suggestions)
    for _, suggestion in ipairs(suggestions) do
        SendNUIMessage({
            type = "ON_SUGGESTION_ADD",
            suggestion = suggestion
        })
    end
end)

RegisterNetEvent("chat:removeSuggestion")
AddEventHandler("chat:removeSuggestion", function(name)
     SendNUIMessage({
        type = "ON_SUGGESTION_REMOVE",
        name = name
    })
end)

RegisterNetEvent("chat:removeSuggestions")
AddEventHandler("chat:removeSuggestions", function()
     SendNUIMessage({
        type = "ON_SUGGESTION_REMOVE_ALL"
    })
end)

RegisterNetEvent("chat:addTemplate")
AddEventHandler("chat:addTemplate", function(id, html)
    SendNUIMessage({
        type = "ON_TEMPLATE_ADD",
        template = {
            id = id,
            html = html
        }
    })
end)

RegisterNetEvent("chat:close")
AddEventHandler("chat:close", function()
    SendNUIMessage({
        type = "ON_CLOSE_CHAT"
    })
end)

RegisterNetEvent("chat:clear")
AddEventHandler("chat:clear", function()
    SendNUIMessage({
        type = "ON_CLEAR"
    })
end)

-- Threads

Citizen.CreateThread(function()
    SetTextChatEnabled(false)
    SetNuiFocus(false)
    chatInputActive = false
    chatInputActivating = false

    while true do
        Wait(0)

        if not chatInputActive then
            if IsControlPressed(0,245) then
                chatInputActive = true
                chatInputActivating = true

                TriggerServerEvent("np-chat:texting", true)

                SendNUIMessage({
                    type = "ON_OPEN"
                })
            end
        end

        if chatInputActivating then
            if not IsControlPressed(0,245) then
                SetNuiFocus(true)

                chatInputActivating = false
            end
        end

        if chatLoaded then
            local shouldBeHidden = false

            if IsScreenFadedOut() or IsPauseMenuActive() then
                shouldBeHidden = true
            end

            if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
                chatHidden = shouldBeHidden

                SendNUIMessage({
                    type = "ON_SCREEN_STATE_CHANGE",
                    shouldHide = shouldBeHidden
                })
            end
        end
    end
end)