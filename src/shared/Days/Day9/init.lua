local Input = require(script.Input.Input)
local Part1 = require(script.Solutions.Part1)(Input, 25)
local Part2 = require(script.Solutions.Part2)(Input, Part1)

return {
    Part1Result = Part1,
    Part2Result = Part2
}