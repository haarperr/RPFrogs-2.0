--[[

    Variables

]]

local Scoreboard = {}
Scoreboard.Players = {}
Scoreboard.Recent = {}
Scoreboard.SelectedPlayer = nil
Scoreboard.MenuOpen = false
Scoreboard.Menus = {}

--[[

    Functions

]]

local function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

local function GetPlayerCount()
    local count = 0

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then count = count + 1 end
    end

    return count
end

local function Open()
    Scoreboard.SelectedPlayer = nil
    WarMenu.OpenMenu("scoreboard")
end

local function Close()
    for k, v in pairs(Scoreboard.Menus) do
        WarMenu.CloseMenu(K)
    end
end

local function IsAnyMenuOpen()
    for k,v in pairs(Scoreboard.Menus) do
        if WarMenu.IsMenuOpened(k) then return true end
    end

    return false
end

local function displayPlayerList()
    if not IsAnyMenuOpen() then
        Open()
    end
end

local function hidePlayerList()
    if IsAnyMenuOpen() then
        Close()
    end
end

--[[

    Events

]]

RegisterNetEvent("np-binds:keyEvent")
AddEventHandler("np-binds:keyEvent", function(name,onDown)
    if name ~= "PlayerList" then return end

    if onDown then
        displayPlayerList()
    else
        hidePlayerList()
    end
end)

RegisterNetEvent("np-scoreboard:AddPlayer")
AddEventHandler("np-scoreboard:AddPlayer", function(data)
    Scoreboard.Players[data.src] = data
end)

RegisterNetEvent("np-scoreboard:RemovePlayer")
AddEventHandler("np-scoreboard:RemovePlayer", function(data)
    Scoreboard.Players[data.src] = nil
    Scoreboard.Recent[data.src] = data
end)

RegisterNetEvent("np-scoreboard:RemoveRecent")
AddEventHandler("np-scoreboard:RemoveRecent", function(src)
    Scoreboard.Recent[src] = nil
end)

RegisterNetEvent("np-scoreboard:AddAllPlayers")
AddEventHandler("np-scoreboard:AddAllPlayers", function(data, recentData)
    Scoreboard.Players = data
    Scoreboard.Recent = recentData
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    local function DrawMain()
        if WarMenu.Button("Total:", tostring(GetPlayerCount()), {r = 135, g = 206, b = 250, a = 150}) then end

        for k,v in spairs(Scoreboard.Players, function(t, a, b) return t[a].src < t[b].src end) do
            local playerId = GetPlayerFromServerId(v.src)

            if NetworkIsPlayerActive(playerId) or GetPlayerPed(playerId) == PlayerPedId() then
                if WarMenu.MenuButton("[" .. v.src .. "] " .. v.steamid .. " ", "options") then Scoreboard.SelectedPlayer = v end
            else
                if WarMenu.MenuButton("[" .. v.src .. "] - instanced?", "options", {r = 255, g = 0, b = 0, a = 255}) then Scoreboard.SelectedPlayer = v end
            end
        end



        if WarMenu.MenuButton("Recent D/C's", "recent") then
        end
    end

    local function DrawRecent()
        for k,v in spairs(Scoreboard.Recent, function(t, a, b) return t[a].src < t[b].src end) do
            if WarMenu.MenuButton("[" .. v.src .. "] " .. v.name, "options") then Scoreboard.SelectedPlayer = v end
        end
    end

    local function DrawOptions()
        if WarMenu.Button("Community ID:", Scoreboard.SelectedPlayer.comid) then end
        if WarMenu.Button("Steam ID:", Scoreboard.SelectedPlayer.steamid) then end
        if WarMenu.Button("Hex ID:", Scoreboard.SelectedPlayer.hexid) then end
        if WarMenu.Button("Server ID:", Scoreboard.SelectedPlayer.src) then end
    end

    Scoreboard.Menus = {
        ["scoreboard"] = DrawMain,
        ["recent"] = DrawRecent,
        ["options"] = DrawOptions
    }

    local function Init()
        WarMenu.CreateMenu("scoreboard", "Player List")
        WarMenu.SetSubTitle("scoreboard", "Players")

        WarMenu.SetMenuWidth("scoreboard", 0.5)
        WarMenu.SetMenuX("scoreboard", 0.71)
        WarMenu.SetMenuY("scoreboard", 0.017)
        WarMenu.SetMenuMaxOptionCountOnScreen("scoreboard", 30)
        WarMenu.SetTitleColor("scoreboard", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("scoreboard", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("scoreboard", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("scoreboard", 255, 255, 255, 255)

        WarMenu.CreateSubMenu("recent", "scoreboard", "Recent D/C's")
        WarMenu.SetMenuWidth("recent", 0.5)
        WarMenu.SetTitleColor("recent", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("recent", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("recent", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("recent", 255, 255, 255, 255)

        WarMenu.CreateSubMenu("options", "scoreboard", "User Info")
        WarMenu.SetMenuWidth("options", 0.5)
        WarMenu.SetTitleColor("options", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("options", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("options", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("options", 255, 255, 255, 255)
    end

    Init()
    timed = 0

    while true do
        for k,v in pairs(Scoreboard.Menus) do
            if WarMenu.IsMenuOpened(k) then
                v()
                WarMenu.Display()
            else
                if timed > 0 then
                    timed = timed - 1
                end
            end
        end

        Citizen.Wait(1)
    end
end)