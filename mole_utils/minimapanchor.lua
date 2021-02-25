--[[
    MINIMAP ANCHOR BY GLITCHDETECTOR (Feb 16 2018 version)
    Modify and redistribute as you please, just keep the original credits in.
    You're free to distribute this in any project where it's used.
]]

--[[
    Returns a Minimap object with the following details:
    x, y: Top left origin of minimap
    width, height: Size of minimap (not pixels!)
    left_x, right_x: Left and right side of minimap on x axis
    top_y, bottom_y: Top and bottom side of minimap on y axis
    xunit, yunit: Base units that should be the same for every screen. Use these for pixel measurement.
]]
--[[
function drawRct(x, y, width, height, r, g, b, a)
    DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end
Citizen.CreateThread(function()
    local Minimap = GetMinimapAnchor()
    print("is_widescren: " .. Minimap.is_widescreen)
    print("is_window: " .. (Minimap.is_window and 1 or 0))
    print("aspect_ratio: " .. Minimap.aspect_ratio)
    print("width: " .. Minimap.width)
    print("height: " .. Minimap.height)
    print("left_x: " .. Minimap.left_x)
    print("right_x: " .. Minimap.right_x)
    print("top_y: " .. Minimap.top_y)
    print("bottom_y: " .. Minimap.bottom_y)
    print("x: " .. Minimap.x)
    print("y: " .. Minimap.y)
    print("xunit: " .. Minimap.xunit)
    print("yunit: " .. Minimap.yunit)
    print("res_x: " .. Minimap.res_x)
    print("res_y: " .. Minimap.res_y)
    
    while true do
        Wait(0)
        Minimap = GetMinimapAnchor()
        local thickness = 4 -- Defines how many pixels wide the border is
        drawRct(Minimap.x, Minimap.y, Minimap.width, thickness * Minimap.yunit, 0, 0, 0, 255)
        drawRct(Minimap.x, Minimap.y + Minimap.height, Minimap.width, -thickness * Minimap.yunit, 255, 0, 0, 255)
        drawRct(Minimap.x, Minimap.y, thickness * Minimap.xunit, Minimap.height, 0, 255, 0, 255)
        drawRct(Minimap.x + Minimap.width, Minimap.y, -thickness * Minimap.xunit, Minimap.height, 0, 0, 255, 255)
    end
end)
]]

function GetMinimapAnchor()
    -- Safezone goes from 1.0 (no gap) to 0.9 (5% gap (1/20))
    -- 0.05 * ((safezone - 0.9) * 10)
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
	local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.is_widescreen = GetIsWidescreen()
    Minimap.is_window = not isCommonAspectRation(res_x,res_y)
    Minimap.aspect_ratio = aspect_ratio
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    if (Minimap.is_widescreen and aspect_ratio > 2) then
        if(Minimap.is_window) then
            Minimap.left_x = Minimap.left_x + Minimap.width * 1.17
            Minimap.width = Minimap.width * 1.025
        else
            Minimap.left_x = Minimap.left_x + Minimap.width * 1.17
            Minimap.width = Minimap.width * 1.025
        end
	elseif aspect_ratio > 2 then
		Minimap.left_x = Minimap.left_x + Minimap.width * 0.845
		Minimap.width = Minimap.width * 0.76
    elseif aspect_ratio > 1.7 then
        if(Minimap.is_window) then
            if(Minimap.is_widescreen) then
		        Minimap.left_x = Minimap.left_x + Minimap.width * 0.11
                Minimap.width = Minimap.width * 1.025
            else
		        Minimap.left_x = Minimap.left_x + Minimap.width * 0.2225
                Minimap.width = Minimap.width * 0.995
            end
        end
    end
    
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    Minimap.res_x = res_x
    Minimap.res_y = res_y
    
    return Minimap
end
function isCommonAspectRation(w,h)
    if h == (w/16)*9 then 
        return true 
    elseif h == (w/4)*3 then 
        return true
    elseif h == (w/16)*10 then 
        return true
    elseif h == (w/21)*9 then 
        return true
    elseif h == (w/64)*27 then 
        return true
    elseif h == (w/5)*4 then 
        return true
    elseif h == (w/3)*2 then 
        return true
    elseif h == (w/32)*9 then 
        return true
    else
        return false 
    end
  end

  exports("GetMinimapAnchor", function()
    return GetMinimapAnchor()
  end)
--[[
Calculations I made while researching this:

Resolution: 2560x1440: (16:9 | 1,778)
Minimap: 360x256 = 7,111 x 5,625 (14,063% x 17,778%)
Safezone 0.90 = 128x73 = 20 x 19,726 (5% x 5,069%)
Safezone 0.95 = 64x37 = 40 x 38,919 (2,5% x 2,569%)
Safezone 1.00 = 0x0 = 0 x 0 (0% x 0%)
Minimap width / Aspect ratio = ~4

Resolution: 1280x960: (4:3 | 1,333)
Minimap: 240x170 = 5,333 x 5,647 (18,751% x 17,809%)
Safezone 0.90 = 64x48 = 20 x 20 = (5% x 5%)
Minimap width / Aspect ratio = ~4

Minimap width divided by aspect ratio is always ~4
Minimap height seems to be around ~17,8% of screen height
Safezone seems to be 5% of screen size per -0.10 safezone setting

THIS IS NOT TESTED ON ANYTHING WIDER THAN 16:10
I HAVE ABSOLUTELY NO IDEA WHAT THE NATIVES RETURN ON MULTI MONITOR SETUPS (3*1920 x 1080p etc.)
]]