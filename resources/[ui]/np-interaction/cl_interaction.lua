function showInteraction(text, type)
	local color = "#2196f3"

	if type == "success" then
		color = "#4caf50"
	elseif type == "error" then
		color = "#f44336"
	end

	SendNUIMessage({
		display = true,
		text = text,
		color = color
	})
end

function hideInteraction()
	SendNUIMessage({
		display = false
	})
end

exports("showInteraction", showInteraction)
exports("hideInteraction", hideInteraction)