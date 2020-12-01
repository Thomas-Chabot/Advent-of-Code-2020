--!strict
--[[
    Problem 1: Find two entries that sum to 2020, then calculate their product.
    Problem 2: [ TODO ]

    To efficiently find the two values that sum up to 2020, we can first sort the array (O(n log n) with a comparison sort)
     then track left and right values as we get closer to the sum we're looking for.

    If the value that we currently have (the sum of left + right) is bigger than the sum we are looking for, we move the right value down by 1;
    If the value that we currently have (the sum of left + right) is smaller than the sum we are looking for, we increase the left value by 1;
    If the sum is what we are looking for, then we exit and return those two values (left and right).

    The code is written using Luau's typed lua implementation.
    December 1st, 2020
]]

type ArrayOfNumber = { number }
type SumResultType = {
    Left: {
        Index: number,
        Value: number?
    },
    Right: {
        Index: number,
        Value: number?
    }
}

local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)
local Input = Parser.ToNumbers(require(script.Input))

function findSum(values: ArrayOfNumber, target: number): SumResultType
    -- First step is to make sure that the array is sorted
    -- So that walking backwards/forwards will adjust our sum accordingly
    table.sort(values, function(a, b) return a < b end)

    -- Set up our array indexers; these are values that point to the left and right of what we're looking at
    -- These will be adjusted as we walk through the array to find our target
    local left : number = 1
    local right : number = #values

    -- Continue until we loop back on ourselves (left bypasses right)
    while left <= right do
        -- Calculate the sum by adding up the two values we're looking at
        local sum = values[left] + values[right]
 
        -- If the sum is greater than our target, push the right value back, decreasing our sum;
        -- If the sum is less, push the left forward, increasing our sum;
        -- Otherwise if they're equal, exit out with the two values
        if sum > target then
            right -= 1
        elseif sum < target then
            left += 1
        else
            break
        end
    end

    -- Can check if we found a value based on our loop condition, left <= right
    -- If we found a sum, return them; otherwise indicate that we had no value
    if left <= right then
        return {
            Left = {
                Index = left,
                Value = values[left]
            },
            Right = {
                Index = right,
                Value = values[right]
            }
        }
    else
        return {
            Left = {
                Index = -1
            },
            Right = {
                Index = -1
            }
        }
    end
end

local day1Result = findSum(Input, 2020)

return {
    Day1Result = day1Result.Left.Value * day1Result.Right.Value
}