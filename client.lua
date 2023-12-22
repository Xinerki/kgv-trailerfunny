function lerp(x1, x2, t)
    return x1 + (x2 - x1) * t
end

local duration = 3000
local startTime = GetGameTimer()
local endTime = startTime + duration

CreateThread(function()
    local scaleform = RequestScaleformMovie("ORGANISATION_NAME")
    repeat Wait(0) until HasScaleformMovieLoaded(scaleform)
    PushScaleformMovieFunction(scaleform, "SET_ORGANISATION_NAME")
    PushScaleformMovieFunctionParameterString("~w~ROCKSTAR GAMES\nPRESENTS")
    PushScaleformMovieFunctionParameterInt(-1) -- style
    PushScaleformMovieFunctionParameterInt(0) -- color (0-7)
    PushScaleformMovieFunctionParameterInt(6) -- font (0-12?)
    PopScaleformMovieFunction()

    while true do Wait(0)
        local elapsedTime = GetGameTimer() - startTime
        local scale = elapsedTime / duration
    
        local x = lerp(-1700.0, -1420.0, scale)
        local y = lerp(-1300.0, -978.0, scale)

        if GetGameTimer() < endTime then
            DrawScaleformMovie_3dSolid(scaleform, x, y, 150.0, 0.0, 0.0, 35.0, 0, 1.0, 0, 180.0, 100.0, 100.0, 0)
        end
    end
end)

function DoIt()
    startTime = GetGameTimer()
    endTime = startTime + duration
end

RegisterCommand("gta6", DoIt)