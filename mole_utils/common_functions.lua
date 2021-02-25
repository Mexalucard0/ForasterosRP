function _SecondsToClock(seconds)
    local seconds = tonumber(seconds)
    if seconds <= 0 then
      return "00h 00m 00s";
    else
      hours = string.format("%02.f", math.floor(seconds/3600));
      mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
      secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
      return hours.."h "..mins.."m "..secs .."s"
    end
end  
