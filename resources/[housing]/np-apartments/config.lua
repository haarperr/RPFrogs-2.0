MenuData = {
    apartment_check = {
        {
            title = "Apartment",
            description = "Forclose Apartment",
            children = {
                { title = "Yes", action = "np-apartments:handler", params = { forclose = true} },
                { title = "No", action = "np-apartments:handler", params = { forclose = false } },
            }
        }
    }
}
