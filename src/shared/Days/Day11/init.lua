local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)
local Input = require(script.Input.Input)
local Grid = require(script.DataStructures.Grid)
local Part1 = require(script.Solutions.Part1)

local grid = Grid.new(Input)

return {
    Part1Result = Part1(grid)
}