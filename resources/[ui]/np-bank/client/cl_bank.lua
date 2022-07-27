--[[

	Functions

]]

function openUI(pATM)
	SetNuiFocus(true, true)

    SendNUIMessage({
        type = "load",
        atm = pATM,
    })

    local accounts = RPC.execute("np-financials:getAccounts")
    local cash = RPC.execute("np-financials:getCash")

    SendNUIMessage({
        type = "accounts",
        cash = cash,
        accounts = accounts,
    })

    if #accounts > 0 then
        local accountId = accounts[1].account_id

        local transactions = RPC.execute("np-financials:bankTransactions", accountId)
        SendNUIMessage({
            type = "transactions",
            transactions = transactions,
            id = accountId,
        })
    end

    Citizen.Wait(1000)

    SendNUIMessage({
        type = "bank",
        toggle = true,
    })
end

function closeUI()
	SetNuiFocus(false, false)

    SendNUIMessage({
        type = "bank",
        toggle = false,
    })

	TriggerEvent("np-bank:closed")
end

function updateBalance(accountId)
	local accounts = RPC.execute("np-financials:getAccounts")
    local cash = RPC.execute("np-financials:getCash")

    SendNUIMessage({
        type = "accounts",
        cash = cash,
        accounts = accounts,
    })

    local transactions = RPC.execute("np-financials:bankTransactions", accountId)
    SendNUIMessage({
        type = "transactions",
        transactions = transactions,
        id = accountId,
    })

    Citizen.Wait(500)

    SendNUIMessage({
        type = "loadend"
    })
end

--[[

	Exports

]]

exports("openUI", openUI)
exports("closeUI", closeUI)

--[[

	NUI

]]

RegisterNUICallback("withdraw", function(data)
    if not exports["np-financials"]:isNearBankOrATM() then
		closeUI()
		return
	end

    SendNUIMessage({
        type = "loadstart"
    })

	local success, error = RPC.execute("np-financials:bankWithdraw", tonumber(data.id), tonumber(data.value), data.comment)
	if success then
        updateBalance(tonumber(data.id))
    else
        TriggerEvent("DoLongHudText", error, 2)

        Citizen.Wait(500)

        SendNUIMessage({
            type = "loadend"
        })
    end
end)

RegisterNUICallback("deposit", function(data)
	if not exports["np-financials"]:isNearBankOrATM() then
		closeUI()
		return
	end

    SendNUIMessage({
        type = "loadstart"
    })

	local success, error = RPC.execute("np-financials:bankDeposit", tonumber(data.id), tonumber(data.value), data.comment)
	if success then
        updateBalance(tonumber(data.id))
    else
        TriggerEvent("DoLongHudText", error, 2)

        Citizen.Wait(500)

        SendNUIMessage({
            type = "loadend"
        })
    end
end)

RegisterNUICallback("transfer", function(data)
	if not exports["np-financials"]:isNearBankOrATM() then
		closeUI()
		return
	end

    SendNUIMessage({
        type = "loadstart"
    })

	local success, error = RPC.execute("np-financials:bankTransfer", tonumber(data.id), tonumber(data.to), tonumber(data.value), data.comment)
	if success then
        updateBalance(tonumber(data.id))
    else
        TriggerEvent("DoLongHudText", error, 2)

        Citizen.Wait(500)

        SendNUIMessage({
            type = "loadend"
        })
    end
end)

RegisterNUICallback("close", function()
	closeUI()
end)

RegisterNUICallback("transactions", function(data)
	local accountId = tonumber(data.id)

    local transactions = RPC.execute("np-financials:bankTransactions", accountId)

	SendNUIMessage({
        type = "transactions",
        transactions = transactions,
        id = accountId,
    })
end)