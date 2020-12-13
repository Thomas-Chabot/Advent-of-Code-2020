--!strict
--[[
    Part 2 is built around a dynamic programming scheme.
    For every number that we go through, add it into a list of numbers that we're building.
    If the total for any of these is the number we're looking for, then we exit, using that as the start & end indices.
    Otherwise, we move to the next number, which will build off the results from the previous number.

    For example, assume we have the list 3, 7, 13, 21, 33. Then:
        The first row will just be the first number - {{3}}.
        The second row will add 7: {{3, 7}, {7}}.
        The third row then adds 13: {{3, 7, 13}, {7, 13}, {13}}.
        This continues for each number as we walk through the array.
]]

type RowData = {
    Sum: number,
    StartIndex: number,
    EndIndex: number,
}

local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)
local rows = { }

local function addValue(index : number, value : number, targetValue : number) : RowData?
    local previousRow = rows[index - 1] or { }
    local newRow = { }

    local addRow = function(newValue : RowData) : RowData?
        -- If it matches the target, then return that value
        if newValue.Sum == targetValue then
            return newValue
        end

        -- Otherwise, insert it into our rows array and continue
        table.insert(newRow, newValue)
    end 

    for _,previousValue in pairs(previousRow) do
        local newValue = {
            Sum = previousValue.Sum + value,
            StartIndex = previousValue.StartIndex,
            EndIndex = index
        }

        if (addRow(newValue)) then
            return newValue
        end
    end
    
    -- Add another value to represent just this one number
    local defaultRow = {
        Sum = value,
        StartIndex = index,
        EndIndex = index
    }

    if addRow(defaultRow) then
        return defaultRow
    end
    
    rows[index] = newRow
end

local function getResult(Input : string, target : number) : number?
    local result : RowData? = nil
    local index : number = 1
    local parsedValues : {number} = Parser.ToNumbers(Input)

    while result == nil and index <= #parsedValues do
        result = addValue(index, parsedValues[index], target)
        index += 1
    end

    if not result then
        return nil
    end

    -- Go through and build out a new array of all the values between the two indices
    local values = { }
    for i = result.StartIndex, result.EndIndex, 1 do
        table.insert(values, parsedValues[i])
    end
    table.sort(values, function(a, b) return a < b end)
    
    -- Add smallest and largest values
    return values[1] + values[#values]
end

return getResult