rightPosition = {x = 1450, y = 100}
leftPosition = {x = 0, y = 100}
menuPosition = rightPosition

local RuntimeTXD = CreateRuntimeTxd("Custom_Menu_Head")
local Object = CreateDui("https://i.imgur.com/Ki8YHxm.png", 512, 128)
_G.Object = Object
local TextureThing = GetDuiHandle(Object)
local Texture = CreateRuntimeTextureFromDuiHandle(RuntimeTXD, "Custom_Menu_Head", TextureThing)
Menuthing = "Custom_Menu_Head"

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("", "", menuPosition["x"], menuPosition["y"], Menuthing, Menuthing)
_menuPool:Add(mainMenu)

local EmoteTable = {}
local FavEmoteTable = {}
local KeyEmoteTable = {}
local DanceTable = {}
local PropETable = {}
local WalkTable = {}
local FaceTable = {}
local ShareTable = {}

function AddEmoteMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, "Emotes", "", "", Menuthing, Menuthing)
    local dancemenu = _menuPool:AddSubMenu(submenu, "🕺 Dance Emotes", "", "", Menuthing, Menuthing)
    local propmenu = _menuPool:AddSubMenu(submenu, "📦 Prop Emotes", "", "", Menuthing, Menuthing)

    table.insert(EmoteTable, "🕺 Dance Emotes")
    table.insert(EmoteTable, "🕺 Dance Emotes")

    sharemenu = _menuPool:AddSubMenu(submenu, "👫 Shared Emotes", "Invite a nearby person to emote", "", Menuthing, Menuthing)
    shareddancemenu = _menuPool:AddSubMenu(sharemenu, "🕺 Shared Dances", "", "", Menuthing, Menuthing)
    table.insert(ShareTable, "none")
    table.insert(EmoteTable, "👫 Shared Emotes")

    table.insert(EmoteTable, "keybinds")
    keyinfo =  NativeUI.CreateItem("🔢 Keybinds", "Use /emotebind [~y~num4-9~w~] [~g~emotename~w~]")
    submenu:AddItem(keyinfo)

    for a,b in pairsByKeys(DP.Emotes) do
        x,y,z = table.unpack(b)
        emoteitem = NativeUI.CreateItem(z, "/e ("..a..")")
        submenu:AddItem(emoteitem)
        table.insert(EmoteTable, a)
    end

    for a,b in pairsByKeys(DP.Dances) do
        x,y,z = table.unpack(b)
        danceitem = NativeUI.CreateItem(z, "/e ("..a..")")
        sharedanceitem = NativeUI.CreateItem(z, "")
        dancemenu:AddItem(danceitem)
        shareddancemenu:AddItem(sharedanceitem)
        table.insert(DanceTable, a)
    end

    for a,b in pairsByKeys(DP.Shared) do
        x,y,z,otheremotename = table.unpack(b)

        if otheremotename == nil then
            shareitem = NativeUI.CreateItem(z, "")
        else
            shareitem = NativeUI.CreateItem(z, "")
        end

        sharemenu:AddItem(shareitem)
        table.insert(ShareTable, a)
    end

    for a,b in pairsByKeys(DP.PropEmotes) do
        x,y,z = table.unpack(b)
        propitem = NativeUI.CreateItem(z, "/e ("..a..")")
        propmenu:AddItem(propitem)
        table.insert(PropETable, a)
    end

    dancemenu.OnItemSelect = function(sender, item, index)
        EmoteMenuStart(DanceTable[index], "dances")
    end

    sharemenu.OnItemSelect = function(sender, item, index)
        if ShareTable[index] ~= "none" then
            target, distance = GetClosestPlayer()

            if(distance ~= -1 and distance < 3) then
                _,_,rename = table.unpack(DP.Shared[ShareTable[index]])
                TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), ShareTable[index])
                TriggerEvent("DoLongHudText", "Verzoek verzonden.")
            else
                TriggerEvent("DoLongHudText", "Niemand dichtbij.", 2)
            end
        end
    end

    shareddancemenu.OnItemSelect = function(sender, item, index)
        target, distance = GetClosestPlayer()

        if(distance ~= -1 and distance < 3) then
            _,_,rename = table.unpack(DP.Dances[DanceTable[index]])
            TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), DanceTable[index], "Dances")
            TriggerEvent("DoLongHudText", "Verzoek verzonden.")
        else
            TriggerEvent("DoLongHudText", "Niemand dichtbij.", 2)
        end
    end

    propmenu.OnItemSelect = function(sender, item, index)
        EmoteMenuStart(PropETable[index], "props")
    end

    submenu.OnItemSelect = function(sender, item, index)
        EmoteMenuStart(EmoteTable[index], "emotes")
    end
end

function AddCancelEmote(menu)
    local newitem = NativeUI.CreateItem("Cancel Emote", "Annuleert de momenteel afspelende emote")

    menu:AddItem(newitem)
    menu.OnItemSelect = function(sender, item, checked_)
        if item == newitem then
          EmoteCancel()
          DestroyAllProps()
        end
    end
end

function AddWalkMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, "Walking Styles", "", "", Menuthing, Menuthing)

    walkreset = NativeUI.CreateItem("Normal (Reset)", "Reset to default")
    submenu:AddItem(walkreset)
    table.insert(WalkTable, "Reset to default")

    WalkInjured = NativeUI.CreateItem("Injured", "")
    submenu:AddItem(WalkInjured)
    table.insert(WalkTable, "move_m@injured")

    for a,b in pairsByKeys(DP.Walks) do
        x = table.unpack(b)
        walkitem = NativeUI.CreateItem(a, "")
        submenu:AddItem(walkitem)
        table.insert(WalkTable, x)
    end

    submenu.OnItemSelect = function(sender, item, index)
        if item ~= walkreset then
            TriggerEvent("Animation:Set:Gait", {WalkTable[index]})
        else
            TriggerEvent("AnimSet:default")
        end
    end
end

function AddFaceMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, "Expressions", "", "", Menuthing, Menuthing)

    facereset = NativeUI.CreateItem("Normal (Reset)", "Reset to default")
    submenu:AddItem(facereset)
    table.insert(FaceTable, "")

    for a,b in pairsByKeys(DP.Expressions) do
        x,y,z = table.unpack(b)
        faceitem = NativeUI.CreateItem(a, "")
        submenu:AddItem(faceitem)
        table.insert(FaceTable, a)
    end

    submenu.OnItemSelect = function(sender, item, index)
        if item ~= facereset then
            EmoteMenuStart(FaceTable[index], "expression")
        else
            ClearFacialIdleAnimOverride(PlayerPedId())
        end
    end
end

function OpenEmoteMenu()
    mainMenu:Visible(not mainMenu:Visible())
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

AddEmoteMenu(mainMenu)
AddCancelEmote(mainMenu)
AddWalkMenu(mainMenu)
AddFaceMenu(mainMenu)

_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
    end
end)