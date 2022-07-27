local GeneralEntries, SubMenu = MenuEntries["general"], {}

local Blips = {
    {
        id = "blips:clothing",
        title = "Clothing",
        icon = "#blips-clothing",
        event = "np-blips:update",
        parameters = "clothing",
    },
    {
        id = "blips:barber",
        title = "Barber",
        icon = "#blips-barber",
        event = "np-blips:update",
        parameters = "barber",
    },
    {
        id = "blips:tattoo",
        title = "Tattoo",
        icon = "#blips-tattoo",
        event = "np-blips:update",
        parameters = "tattoo",
    },
    {
        id = "blips:bank",
        title = "Bank",
        icon = "#blips-bank",
        event = "np-blips:update",
        parameters = "bank",
    },
    {
        id = "blips:gas",
        title = "Fuel",
        icon = "#blips-gas",
        event = "np-blips:update",
        parameters = "gas",
    },
    {
        id = "blips:pd",
        title = "Police Department",
        icon = "#blips-pd",
        event = "np-blips:update",
        parameters = "pd",
    },
    {
        id = "blips:hospital",
        title = "Hospital",
        icon = "#blips-hospital",
        event = "np-blips:update",
        parameters = "hospital",
    },
    {
        id = "blips:market",
        title = "Shop",
        icon = "#blips-market",
        event = "np-blips:update",
        parameters = "market",
    },
    {
        id = "blips:ammunation",
        title = "Ammunation",
        icon = "#blips-ammunation",
        event = "np-blips:update",
        parameters = "ammunation",
    },
    {
        id = "blips:garage",
        title = "Garage",
        icon = "#blips-garage",
        event = "np-blips:update",
        parameters = "garage",
    },
    {
        id = "blips:misc",
        title = "Misc",
        icon = "#blips-misc",
        event = "np-blips:update",
        parameters = "misc",
    },
}

Citizen.CreateThread(function()
    for index, data in ipairs(Blips) do
        SubMenu[index] = data.id
        MenuItems[data.id] = {data = data}
    end

    GeneralEntries[#GeneralEntries+1] = {
        data = {
            id = "blips",
            icon = "#blips",
            title = "Blips"
        },
        subMenus = SubMenu,
        isEnabled = function()
            return not exports["np-base"]:getVar("dead")
        end,
    }
end)

