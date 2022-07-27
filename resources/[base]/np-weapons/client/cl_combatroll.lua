Citizen.CreateThread(function()
    local disabled = false
    local timer = 200

    while true do
        if IsControlPressed(0, 25) then
            DisableControlAction(0, 22, true)

            if not disabled then
                disabled = true
                timer = 200
            end
		elseif disabled then
            if timer > 0 then
                DisableControlAction(0, 22, true)

                timer = timer - 1

                if timer == 0 then
                    disabled = false
                end
            end
        end

        Citizen.Wait(0)
    end
end)