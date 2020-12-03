--!strict
--[[
    Day 3 is about developing a program that will walk down a hill using a given slope and checking for collisions at each step.
    Each step is taken as just one single spot: If you walk down 1 step and right 3 steps, then you only check that next spot, ignoring spots between.
    
    Part 1 asks for a specific slope, where you move right 3 steps and down 1 step.
    Part 2 adds more slopes: (1, 1); (3, 1); (5, 1); (7, 1); (1, 2), with (rightSteps, downSteps).
]]

-- Types
-- GridRow - defines a dictionary storing the locations of trees, and the size of the row
type GridRow = {
    Trees: {[number]: boolean},
    Length: number
}

-- Grid - stores all rows in the grid, along with how many columns are in the grid
type Grid = {
    Rows: {GridRow},
    NumColumns: number,
}

-- Dependencies
local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)
local wrapAround = require(game.ReplicatedStorage.Common.Library.NumberWrap)
local InputData = require(script.Input)

-- Data Parsing method - takes each line of the string and builds out one GridRow
local function parseData(data : string) : GridRow
    local trees = { }
    local searchIndex = 1

    -- Loops while we have trees in the row
    while true do
        -- Find the next tree, or nil if there are no more trees
        local hasMoreTrees = string.find(data, "#", searchIndex)
        if not hasMoreTrees then
            -- If we have no more trees: Exit
            break
        end
        
        -- Otherwise we have a tree, so take the index of the tree & store it in our dictionary
        local nextTreeIndex = tonumber(hasMoreTrees)
        searchIndex = nextTreeIndex + 1
        trees[nextTreeIndex] = true
    end

    return {
        Trees = trees,
        Length = #data
    }
end

-- Walks through the grid until we reach the bottom, returning how many trees we hit
local function walkThroughGrid(grid : Grid, xIncrease : number, yIncrease : number)
    local xIndex, yIndex = 1, 1
    local xMax, yMax = grid.NumColumns, #grid.Rows
    local numTrees = 0

    -- Continue until we're at the bottom
    while (yIndex <= yMax) do
        -- Check if we're currently at a tree
        local isTree = grid.Rows[yIndex].Trees[xIndex]
        if isTree then
            numTrees += 1
        end

        -- Move forward xIncrease, yIncrease steps, wrapping the X around if needed
        xIndex += xIncrease
        yIndex += yIncrease
        xIndex = wrapAround(xIndex, xMax)
    end

    return numTrees
end

local rows = Parser.Custom(InputData, parseData)
local grid = {
    Rows = rows,
    NumColumns = rows[1].Length -- Assuming the same across all rows.
}

-- Check each of: (1, 1), (3, 1), (5, 1), (7, 1), (1, 2)
local trees11 = walkThroughGrid(grid, 1, 1)
local trees31 = walkThroughGrid(grid, 3, 1)
local trees51 = walkThroughGrid(grid, 5, 1)
local trees71 = walkThroughGrid(grid, 7, 1)
local trees12 = walkThroughGrid(grid, 1, 2)

-- Part 1 returns (3, 1)
-- Part 2 returns the product of all above
return {
    Part1Result = trees31,
    Part2Result = trees11 * trees31 * trees51 * trees71 * trees12
}