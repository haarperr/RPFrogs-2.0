local GeneralEntries, SubMenu = MenuEntries["general"], {}

local Clothing = {
    {
        id = "clothing:hat",
        title = "Hat",
        icon = "#clothing-hat",
        event = "np-facewear:radial",
        parameters = "hat",
    },
    {
        id = "clothing:googles",
        title = "Glasses",
        icon = "#clothing-googles",
        event = "np-facewear:radial",
        parameters = "googles",
    },
    {
        id = "clothing:mask",
        title = "Mask",
        icon = "#clothing-mask",
        event = "np-facewear:radial",
        parameters = "mask",
    },
    {
        id = "clothing:chain",
        title = "Chain",
        icon = "#clothing-chain",
        event = "np-facewear:radial",
        parameters = "chain",
    },
    {
        id = "clothing:jacket",
        title = "Jacket",
        icon = "#clothing-jacket",
        event = "np-facewear:radial",
        parameters = "jacket",
    },
    {
        id = "clothing:vest",
        title = "Vest",
        icon = "#clothing-vest",
        event = "np-facewear:radial",
        parameters = "vest",
    },
    {
        id = "clothing:backpack",
        title = "Backpack",
        icon = "#clothing-backpack",
        event = "np-facewear:radial",
        parameters = "backpack",
    },
    {
        id = "clothing:pants",
        title = "Pants",
        icon = "#clothing-pants",
        event = "np-facewear:radial",
        parameters = "pants",
    },
    {
        id = "clothing:shoes",
        title = "Shoes",
        icon = "#clothing-shoes",
        event = "np-facewear:radial",
        parameters = "shoes",
    },
}

Citizen.CreateThread(function()
    for index, data in ipairs(Clothing) do
        SubMenu[index] = data.id
        MenuItems[data.id] = {data = data}
    end

    GeneralEntries[#GeneralEntries+1] = {
        data = {
            id = "clothing",
            icon = "#clothing",
            title = "Clothing",
            event = "np-facewear:clothesMenu",
        },
        -- subMenus = SubMenu,
        isEnabled = function()
            return not exports["np-base"]:getVar("dead")
        end,
    }
end)

