local RealEstateEntries, SubMenu = MenuEntries["realestate"], {}

local RealEstate = {
    {
        id = "real-estate-sell",
        title = "sell property",
        icon = "#real-estate-sell",
        event = "np-housing:sell",
    },
    {
        id = "real-estate-blips",
        title = "Activate Blips",
        icon = "#real-estate-blips",
        event = "np-housing:blips",
    },
}

Citizen.CreateThread(function()
    for index, data in ipairs(RealEstate) do
        SubMenu[index] = data.id
        MenuItems[data.id] = {data = data}
    end

    RealEstateEntries[#RealEstateEntries+1] = {
        data = {
          id = "real_estate",
          icon = "#real-estate",
          title = "Real Estate",
        },
        subMenus = SubMenu,
        isEnabled = function ()
            return not exports["np-base"]:getVar("dead") and CurrentJob == "real_estate"
        end,
    }
end)

