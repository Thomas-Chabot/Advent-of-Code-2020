--!strict
--[[
    Wraps a number around a given max value.
    Result is in the range 1 .. max
]]
function wrapAround(i : number, max : number)
    -- Note: With Lua, indices start at 1. To wrap around:
    --  1) Subtract 1 from i so that it becomes 0-based.
    --  2) Modulo max from i so that it wraps around.
    --  3) Add 1 back to i so that it goes back to 1-based.
    return ((i - 1) % max) + 1
end

return wrapAround