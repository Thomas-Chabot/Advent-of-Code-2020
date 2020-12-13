local Grid = require(script.Parent.Parent.DataStructures.Grid)

type StepResult = {
    NewGrid: Grid.GridType,
    DidChange: boolean
}

local function runStep(grid : Grid.GridType) : StepResult
    local newGrid = grid:Clone()
    local didChange = false
    for row = 1,grid:GetNumRows() do
        for column = 1,grid:GetNumColumns() do
            if grid:IsEmpty(row, column) then
                local adjacent = grid:CountOccupiedAdjacent(row, column)
                if adjacent == 0 then
                    didChange = true
                    newGrid:SetOccupied(row, column)
                end
            elseif grid:IsOccupied(row, column) then
                local adjacent = grid:CountOccupiedAdjacent(row, column)
                if adjacent >= 4 then
                    didChange = true
                    newGrid:SetEmpty(row, column)
                end
            end
        end
    end

    return {
        Grid = newGrid,
        DidChange = didChange
    }
end

local function countOccupiedSeats(grid : Grid.GridType) : number
    local occupied = 0

    for row = 1,grid:GetNumRows() do
        for column = 1,grid:GetNumColumns() do
            if grid:IsOccupied(row, column) then
                occupied += 1
            end
        end
    end

    return occupied
end

local function runProcess(grid : Grid.GridType) : number
    while true do
        local result = runStep(grid)
        if not result.DidChange then
            break
        end

        grid = result.Grid
    end

    return countOccupiedSeats(grid)
end

return runProcess