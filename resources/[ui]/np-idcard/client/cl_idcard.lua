--[[

    Variables

]]

local idCardActive = false

--[[

    Events

]]

RegisterNetEvent("np-idcard:open")
AddEventHandler("np-idcard:open", function(pName, pDob, pGender, pCid, pImage)
    if idCardActive then return end
    idCardActive = true

    SendNUIMessage({
        action = "open",
        name = pName,
		dob = pDob,
		gender = pGender,
		id = pCid,
		image = pImage,
    })

    Citizen.Wait(10000)

    SendNUIMessage({
		action = "close",
    })

    idCardActive = false
end)