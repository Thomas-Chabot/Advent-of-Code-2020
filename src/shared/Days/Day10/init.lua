local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)
local Input = require(script.Input.Input)

local Part1 = require(script.Solutions.Part1)
local Part2 = require(script.Solutions.Part2)

local numbers = Parser.ToNumbers(Input)
table.insert(numbers, 0)
table.sort(numbers, function(a, b) return a < b end)
table.insert(numbers, numbers[#numbers] + 3)


return {
    Part1Result = Part1(numbers),
    Part2Result = Part2(numbers)
}