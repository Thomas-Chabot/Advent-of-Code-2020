local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)
local Input = require(script.Input.TestInput)

local numbers = Parser.ToNumbers(Input)
table.insert(numbers, 0)
table.sort(numbers, function(a, b) return a < b end)
table.insert(numbers, numbers[#numbers] + 3)

--print(numbers)
local distances = {
    [1] = 0,
    [2] = 0,
    [3] = 1
}

local optionalNums = 0
for i = 2,#numbers-1 do
    local distance = numbers[i] - numbers[i - 1]
    local nextDistance = numbers[i + 1] - numbers[i]

    distances[distance] += 1
    if distance == 1 and nextDistance == 1 then
        --print(numbers[i])
        optionalNums += 1
    end
end

return {
    Part1Result = distances[1] * distances[3],
    Part2Result = math.pow(2, optionalNums)
}