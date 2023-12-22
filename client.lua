function lerp(x1, x2, t)
    return x1 + (x2 - x1) * t
end

local duration = 5000
local startTime = 0
local endTime = GetGameTimer()

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
    
        local x = lerp(-1700.0, -1420.0, scale * 3.0)
        local y = lerp(-1300.0, -978.0, scale * 3.0)

        if GetGameTimer() < endTime then
            DrawScaleformMovie_3dSolid(scaleform, x, y, 200.0, 0.0, 0.0, 35.0, 0, 1.0, 0, 180.0, 100.0, 100.0, 0)
        end
    end
end)

function DoIt()
    startTime = GetGameTimer()
    endTime = startTime + duration
end

CreateThread(function()
    local nearby = false
    while true do Wait(0)
        local dist = #(GetEntityCoords(PlayerPedId()).xy - vec(-1420.0, -978.0))
        if dist < 700.0 then
            if not nearby then
                DoIt()

                nearby = true
            end
        else
            if nearby then
                nearby = false
            end
        end
    end
end)

RegisterCommand("gta6", DoIt)