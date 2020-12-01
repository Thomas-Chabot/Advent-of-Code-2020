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
    Index: number,
    Value: number?
}

local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)
local Input = Parser.ToNumbers(require(script.Input))

-- Sorts an array of numbers
local function sortValues(values: ArrayOfNumber)
    table.sort(values, function(a, b) return a < b end)
end

-- Finds a pair totalling to a given target value.
function findSum(values: ArrayOfNumber, target: number, startingIndex: number?, isSorted: boolean?): {SumResultType}?
    -- First step is to make sure that the array is sorted
    -- So that walking backwards/forwards will adjust our sum accordingly
    if not isSorted then
        sortValues(values)
    end

    -- Set up our array indexers; these are values that point to the left and right of what we're looking at
    -- These will be adjusted as we walk through the array to find our target
    local left : number = startingIndex or 1
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
            {
                Index = left,
                Value = values[left]
            },
            {
                Index = right,
                Value = values[right]
            }
        }
    else
        return nil
    end
end

-- Finds a triplet totalling to a given target value.
local function findTriplet(values: ArrayOfNumber, target: number): {SumResultType}?
    -- Step 1) Sort the array
    sortValues(values)

    -- Step 2) Walk through the array 1-by-1 to see if we can find a sum with which we can add the current value
    --  If that's the case, then taking that sum + our value will give us our triplet
    local i = 1
    local result
    while i < #values do
        local targ = target - values[i]

        -- Check if there's a sum that totals to the target
        local foundResult = findSum(values, targ, i + 1, true)

        -- If we have a result, add our current value into it & return that
        if foundResult then
            table.insert(foundResult, {
                Index = i,
                Value = values[i]
            })

            return foundResult
        end

        -- Otherwise continue pushing through the array
        i += 1
    end

    -- At this point we found nothing, so return nil
    return nil
end

local part1Result = findSum(Input, 2020)
local part2Result = findTriplet(Input, 2020)

local part1Answer = part1Result and part1Result[1].Value * part1Result[2].Value
local part2Answer = part2Result and part2Result[1].Value * part2Result[2].Value * part2Result[3].Value

return {
    Part1Result = part1Answer,
    Part2Result = part2Answer
}