function hasPermissions(xPlayer)
    local playerGroup = xPlayer.getGroup()
    if playerGroup == "admin" then
        return true
    end
	return false
end