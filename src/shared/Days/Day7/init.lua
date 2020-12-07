local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)
local Bag = require(script.Bag)
local BagMap = require(script.BagMap)

local Input = require(script.Input.Input)

local bags = Parser.Custom(Input, Bag.new)
local map = BagMap.new(bags)

local bagsContainingShinyGold = map:FindBagsContaining("shiny gold")
local shinyGoldWeight = map:CalculateBagWeight("shiny gold")

return {
    Part1Result = #bagsContainingShinyGold,
    Part2Result = shinyGoldWeight
}