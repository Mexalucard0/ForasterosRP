local lastNotification = ""
local lastNotificationTime = 0
local lastNotificationCount = 0
function LirolShowNotification(msg, job)
    LirolSendNotification({text = msg},job)
 --   ShowNativeNotification(msg)
end
function LirolShowAdvancedNotification(title, subject, msg, icon, iconType, job)
    local advanceMsg = "<div style='color:lime;font-size:16px'>" .. title .. " - " .. subject .. "</div><div>" .. msg .. "</div>"
    if(icon ~= nil)then
        advanceMsg = "<div ><table style='color:white;font-size:14px''><tr><td><img height=50 src='https://images.notificacionesrp.com/notifications/" .. icon .. ".jpg'></td><td style='vertical-align:top'><div style='color:lime;font-size:16px'>" .. title .. "</div>" .. subject .. "</td></tr><tr><td colspan=2>" .. msg .. "</td></tr></table></div>"
    end
    LirolSendNotification({text = advanceMsg},job)
end
function LirolConvertLuaTextIntoHtml(text, job)
    text = text:gsub("~r~", "<span class='red'>") 
    text = text:gsub("~b~", "<span class='blue'>")
    text = text:gsub("~g~", "<span class='green'>")
    text = text:gsub("~y~", "<span class='yellow'>")
    text = text:gsub("~p~", "<span class='purple'>")
    text = text:gsub("~c~", "<span class='grey'>")
    text = text:gsub("~m~", "<span class='darkgrey'>")
    text = text:gsub("~u~", "<span class='black'>")
    text = text:gsub("~o~", "<span class='gold'>")
    text = text:gsub("~s~", "</span>")
    text = text:gsub("~w~", "</span>")
    text = text:gsub("~b~", "<b>")
    text = text:gsub("~n~", "<br>")
    text = "<span>" .. text .. "</span>"
    --[[
    if(job ~= nil)then
        if(job =='police')then
            text = '👮🏻' .. text
        end
        if(job =='ambulance')then
            text = '👨‍⚕️' .. text
        end
        if(job =='mechanic')then
            text = '🔧' .. text
        end
        if(job =='taxi')then
            text = '🚕' .. text
        end
    end
]]--
    
    return text
end


function LirolSetQueueMax(queue, max)
    local tmp = {
        queue = tostring(queue),
        max = tonumber(max)
    }
    SendNUIMessage({maxNotifications = tmp})
end
function LirolShowProgressBar(time, text) 
	SendNUIMessage({
		type = "ui",
		display = true,
		time = time,
		text = text
	})
end

function LirolDrawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
      SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

Citizen.CreateThread(function()
    local radarShowing = IsMinimapRendering()
    SendNUIMessage({
        setMinimap = true,
        minimap  = exports.esx_comp:GetMinimapAnchor()
    })
    SendNUIMessage({
        radarChanged = true,
        isShowing    = radarShowing
    })
    while true do
		Citizen.Wait(1000)
        if(IsMinimapRendering())then
            if(not radarShowing)then
                SendNUIMessage({
                    setMinimap = true,
                    minimap  = exports.esx_comp:GetMinimapAnchor()
                })
                SendNUIMessage({
                    radarChanged = true,
                    isShowing    = true
                })
                radarShowing = true
            end
        else
            if(radarShowing)then
                SendNUIMessage({
                    radarChanged = true,
                    isShowing    = false
                })
                radarShowing = false
            end
        end
    end
end)
awaitResponse = {}
awaitInProgress = false
function IsMinValueInTable(tbl, value)
    local isMin = true
    for _,val in pairs(tbl) do
        if(val < value)then
            isMin = false
        end
    end
    return isMin
end
function RemoveValueInTable(tbl, value)
    for ix,val in ipairs(tbl) do
        if(val == value)then
            table.remove(tbl,ix)
        end
    end
end
function CurrentNotification()
    local minKey = math.huge
    for k,v in pairs(awaitResponse) do
        minKey = math.min(tonumber(k), minKey)
    end
    if(minKey == math.huge)then
        return nil
    end
    return minKey
end
RegisterNUICallback(
    "notification_afterClose",
    function(data, cb)
        if(data['id'] ~= nil) then
            if(awaitResponse[tostring(data['id'])] ~= nil)then
                awaitResponse[tostring(data['id'])] = nil
            end
        end
    end
)
Citizen.CreateThread(function()
    local answered = false
    while true do
        local currentNotificationId = CurrentNotification()
        if(currentNotificationId ~= nil and awaitResponse[tostring(currentNotificationId)] ~= nil)then
            local accepted = false
            if IsControlJustReleased (1, 10) then --N+
                accepted = true
                answered = true
            elseif IsControlJustReleased (1, 11) then --N-
                answered = true
            end
            if(answered)then
                answered = false
                if(accepted) then
                    awaitResponse[tostring(currentNotificationId)].cb(true)
                end
                awaitResponse[tostring(currentNotificationId)] = nil
                SendNUIMessage({
                    promptClose = true,
                    notificationId = currentNotificationId
                })
            end
        end
        Citizen.Wait(1)
    end
end)

function LirolSendPrompt(options, jobs, cb) 
    options.text = options.text .. ' <div style="margin-top:5px;text-align:end"><font color="lime">[RePag]</font> <font color="red">[AvPag]</font></div>'
    options.timeout = 13000
    print (options.text)
    local notificationId = LirolSendNotification(options, jobs)
    awaitResponse[tostring(notificationId)] = {cb = cb}
end 

function LirolSendNotification(options, job)
    options.animation = options.animation or {}
    options.sounds = options.sounds or {}
    options.docTitle = options.docTitle or {}
    timeout = options.timeout or 10000
    if(options.timeout ~= nil and options.timeout == -1)then
        timeout = false
    end
    local options = {
        type = options.type or "alert",
        layout = options.layout or "notificaciones",
        theme = options.theme or "notificaciones",
        text = LirolConvertLuaTextIntoHtml(options.text, job) or "Empty Notification",
        timeout = timeout,
        progressBar = true,
        closeWith = options.closeWith or {},
        animation = {
            open = options.animation.open or "animated fadeInUp",
            close = options.animation.close or "animated fadeOut"
        },
        sounds = {
            volume = options.sounds.volume or 1,
            conditions = options.sounds.conditions or {},
            sources = options.sounds.sources or {}
        },
        docTitle = {
            conditions = options.docTitle.conditions or {}
        },
        modal = options.modal or false,
        id = options.id or false,
        force = options.force or false,
        queue = options.queue or "global",
        killer = options.killer or false,
        container = options.container or false,
        buttons = options.button or false
    }
    if(job ~= nil) then
        options.type = job .. "_" .. options.type
        options.layout = "centerRight"
    end
    if(lastNotification ~=nil and lastNotification.text == options.text and lastNotificationTime > GetGameTimer() - 1000)then
        lastNotificationCount = lastNotificationCount + 1
    end
    if(lastNotification == nil or lastNotification.text ~= options.text or lastNotificationTime <= GetGameTimer() - 1000)then --avoid duplicate notifications
        if(lastNotificationCount > 0) then
            if(lastNotification.text == options.text)then
                options.text = options.text .. " (x" ..lastNotificationCount.. ")"
            end
            lastNotificationCount = 0
        end
        lastNotification = options
        lastNotificationTime = GetGameTimer()
        options.id = lastNotificationTime
        SendNUIMessage({options = options})
        if(job ~= nil and job ~= '') then
            PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
        end
    end
    Citizen.Wait(500)
    return lastNotificationTime
end

RegisterNetEvent("esx_notificaciones:SendNotification")
AddEventHandler("esx_notificaciones:SendNotification", function(options, job)
    LirolSendNotification(options, job)
end)
RegisterNetEvent("esx_notificaciones:SendPrompt")
AddEventHandler("esx_notificaciones:SendPrompt", function(options, job, cb)
    LirolSendPrompt(options, job, cb)
end)

RegisterNetEvent("esx_notificaciones:SetQueueMax")
AddEventHandler("esx_notificaciones:SetQueueMax", function(queue, max)
    LirolSetQueueMax(queue, max)
end)

RegisterNetEvent("esx_notificaciones:LirolDrawTxt")
AddEventHandler("esx_notificaciones:LirolDrawTxt", function(x, y, width, height, scale, text, r, g, b, a, outline)
    LirolDrawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
end)
RegisterNetEvent("esx_notificaciones:LirolShowNotification")
AddEventHandler("esx_notificaciones:LirolShowNotification", function(msg, job)
    LirolShowNotification(msg, job)
end)
RegisterNetEvent("esx_notificaciones:LirolShowProgressBar")
AddEventHandler("esx_notificaciones:LirolShowProgressBar", function(time, text)
    LirolShowProgressBar(time, text)
end)
RegisterNetEvent("esx_notificaciones:LirolShowAdvancedNotification")
AddEventHandler("esx_notificaciones:LirolShowAdvancedNotification", function(title, subject, msg, icon, iconType, job)
    LirolShowAdvancedNotification(title, subject, msg, icon, iconType, job)
end)



-- --------------------------------------------
-- Settings
-- --------------------------------------------

local body = {
	-- Text
	scale = 0.3,
	offsetLine = 0.02,
	-- Warp
	offsetX = 0.005,
	offsetY = 0.004,
	-- Sprite
	dict = 'commonmenu',
	sprite = 'gradient_bgd',
	width = 0.14,
	height = 0.012,
	heading = -90.0,
	-- Betwenn != notifications
	gap = 0.002,
}

local defaultText = '~r~~h~PROBLEMA: ~h~~s~El texto de la notificación es nulo, por favor avísalo a Administración'
local defaultType = 'topRight'
local defaultTimeout = 6000

-- --------------------------------------------
-- Calculus functions
-- --------------------------------------------

local function goDown(v, id) -- Notifications will go under the previous notifications
	for i = 1, #v do
		if v[i].draw and i ~= id then
			v[i].y = v[i].y + (body.height + (v[id].lines*2 + 1)*body.offsetLine)/2 + body.gap
		end
	end
end

local function goUp(v, id) -- Notifications will go above the previous notifications
	for i = 1, #v do
		if v[i].draw and i ~= id then
			v[i].y = v[i].y - (body.height + (v[id].lines*2 + 1)*body.offsetLine)/2 - body.gap
		end
	end
end

local function centeredDown(v, id) -- Notification will stay centered from the default position and new notification will go at the bottom
	for i = 1, #v do
		if v[i].draw and i ~= id then
			v[i].y = v[i].y - (body.height + (v[id].lines*2 + 1)*body.offsetLine)/4 - body.gap/2
			v[id].y = v[i].y + (body.height + (v[id].lines*2 + 1)*body.offsetLine)/2 + body.gap
		end
	end
end

local function centeredUp(v, id) -- Notification will stay centered from the default position and new notification will go at the top
	for i = 1, #v do
		if v[i].draw and i ~= id then
			v[i].y = v[i].y + (body.height + (v[id].lines*2 + 1)*body.offsetLine)/4 + body.gap/2
			v[id].y = v[i].y - (body.height + (v[id].lines*2 + 1)*body.offsetLine)/2 - body.gap
		end
	end
end

local function CountLines(v, text)
	BeginTextCommandLineCount("STRING")
    SetTextScale(body.scale, body.scale)
    SetTextWrap(v.x, v.x + body.width - body.offsetX)
	AddTextComponentSubstringPlayerName(text)
	local nbrLines = GetTextScreenLineCount(v.x + body.offsetX, v.y + body.offsetY)
	return nbrLines
end

local function DrawText(v, text)
	SetTextScale(body.scale, body.scale)
    SetTextWrap(v.x, v.x + body.width - body.offsetX)

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(v.x + body.offsetX, v.y + body.offsetY)
end

local function DrawBackground(v)
    DrawSprite(body.dict, body.sprite, v.x + body.width/2, v.y + (body.height + v.lines*body.offsetLine)/2, body.width, body.height + v.lines*body.offsetLine, body.heading, 255, 255, 255, 255)
end

-- --------------------------------------------
-- Different options
-- --------------------------------------------

local positions = {
	['centerRight'] = { x = 0.85, y = 0.5, notif = {}, offset = centeredUp },
	['centerLeft'] = { x = 0.01, y = 0.5, notif = {}, offset = centeredUp },
	['topRight'] = { x = 0.85, y = 0.015, notif = {}, offset = goDown },
	['topLeft'] = { x = 0.01, y = 0.015, notif = {}, offset = goDown },
	['bottomRight'] = { x = 0.85, y = 0.955, notif = {}, offset = goUp },
	['bottomLeft'] = { x = 0.015, y = 0.75, notif = {}, offset = goUp },
	-- ['position name'] = { starting x, starting y, notif = {} (nothing toput here it's juste the handle), offset = the way multiple notifications will stack up}
}

-- --------------------------------------------
-- Main
-- --------------------------------------------

function SendNotification(options)
  
	local text = options.text or defaultText
	local type = options.type or defaultType
	local timeout = options.timeout or defaultTimeout

	local p = positions[type]
	local id = #p.notif + 1
	local nbrLines = CountLines(p, text)

	p.notif[id] = {
		x = p.x,
		y = p.y,
		lines = nbrLines, 
		draw = true,
	}

	if id > 1 then
		p.offset(p.notif, id)
	end

	Citizen.CreateThread(function()
		Wait(timeout)
		p.notif[id].draw = false
	end)

	Citizen.CreateThread(function()
		while p.notif[id].draw do
			Wait(0)
			DrawBackground(p.notif[id])
			DrawText(p.notif[id], text)
		end
	end)
end

function ShowNativeNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end