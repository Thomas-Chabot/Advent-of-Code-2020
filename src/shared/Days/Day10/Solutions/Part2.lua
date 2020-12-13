--!strict
--[[
    Part 2 involves calculating all possible options that can be used.
    For every number, to find the number of options that it has, we sum up the totals from the last three numbers.
    NOTE: This doesn't work in Lua; I had to reprogram it in JavaScript to calculate the result. But the logic is the same.
]]
local function getResult(numbers : {number}) : number
    local options = {[0] = 1}
    
    for _,currentValue in pairs(numbers) do
        if currentValue == 0 then
            continue
        end

        local prevValue1 = options[currentValue - 3] or 0
        local prevValue2 = options[currentValue - 2] or 0
        local prevValue3 = options[currentValue - 1] or 0

        options[currentValue] = prevValue3 + prevValue2 + prevValue1
    end

    return options[#options]
end

return getResult