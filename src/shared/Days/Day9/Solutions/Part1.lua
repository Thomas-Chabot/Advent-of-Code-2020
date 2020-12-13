local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)
local Input = require(script.Parent.Parent.Input.Input)
local numElements = 25

local SortedArray = require(script.Parent.Parent.DataStructures.SortedArray)
local Array = require(script.Parent.Parent.DataStructures.Array)

local array = Array.new()
local sortedArray = SortedArray.new()


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

local index = 1
local target = 167829540
function goToNextElement(element) : number?
    element = tonumber(element)

    local sorted = sortedArray:GetContents()
    local hasSum = array:Count() < numElements or findSum(sorted, element)

    local targetSum = findSum(sorted, target)
    if array:Count() >= numElements then
        local element = array:Pop()
        sortedArray:Remove(element)
    end
    
    array:Add(element)
    sortedArray:Add(element)

    index += 1
    return not hasSum and element
end

local function findResult(Input : string, numElements : number) : number
    local values = Parser.ToNumbers(Input)
    local result = nil
    local index = 1

    while not result do 
        result = goToNextElement(values[index])
        index += 1
    end

    return result
end

return findResult