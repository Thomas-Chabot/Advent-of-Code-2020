--!strict
local Grid = { }
Grid.__index = Grid

type SeatType = number
export type GridType = { 
    _grid: { {SeatType} }
}

local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)

local SeatTypes = {
    Empty = 1,
    Occupied = 2,
    Floor = 3,
}
local SeatValues = {
    ["L"] = SeatTypes.Empty,
    ["."] = SeatTypes.Floor,
    ["#"] = SeatTypes.Occupied
}
local SeatToStringMap = {
    [SeatTypes.Empty] = "L",
    [SeatTypes.Floor] = ".",
    [SeatTypes.Occupied] = "#"
}

function Grid.new(fromString : string) : GridType
    local self = setmetatable({
        _grid = { },
        _columns = 0
    }, Grid)

    self:_build(fromString)
    return self
end
function Grid.From(otherGrid : GridType) : GridType
    local gridData = { }
    for rowIndex,row in pairs(otherGrid._grid) do
        local newRow = { }
        for i,val in pairs(row) do
            newRow[i] = val
        end
        gridData[rowIndex] = newRow
    end

    return setmetatable({
        _grid = gridData,
        _columns = otherGrid._columns
    }, Grid)
end

function Grid:GetNumRows()
    return #self._grid
end
function Grid:GetNumColumns()
    return self._columns
end

function Grid:IsFloor(row : number, column : number)
    return self:_getValue(row, column) == SeatTypes.Floor
end
function Grid:IsEmpty(row : number, column : number)
    return self:_getValue(row, column) == SeatTypes.Empty
end
function Grid:IsOccupied(row : number, column : number)
    return self:_getValue(row, column) == SeatTypes.Occupied
end

function Grid:SetOccupied(row : number, column : number)
    self:_setValue(row, column, SeatTypes.Occupied)
end
function Grid:SetEmpty(row : number, column : number)
    self:_setValue(row, column, SeatTypes.Empty)
end

function Grid:CountOccupiedAdjacent(row : number, column : number)
    local occupied = 0
    for r = row - 1, row + 1 do
        for c = column - 1, column + 1 do
            if c == column and r == row then
                continue
            end

            if self:_getValue(r, c) == SeatTypes.Occupied then
                occupied += 1
            end
        end
    end

    return occupied
end

function Grid:Clone()
    return Grid.From(self)
end

function Grid:Each(callback : (number, number) -> any)
    for row = 1,self:GetNumRows() do
        for column = 1,self:GetNumColumns() do
            callback(row, column)
        end
    end
end


function Grid:_build(fromString : string)
    self._grid = Parser.Custom(fromString, function(val) return self:_parseRow(val) end)
    self._columns = self._grid[1] and #self._grid[1] or 0
end
function Grid:_parseRow(rowString : string) : {SeatType}
    local result = { }
    local index = 1
    for val in string.gmatch(rowString, ".") do
        result[index] = SeatValues[val]
        index += 1
    end
    return result
end

function Grid:_getValue(row : number, column : number)
    return (self._grid[row] and self._grid[row][column]) or SeatTypes.Floor
end
function Grid:_setValue(row : number, column : number, value : SeatType)
    assert(self._grid[row] and self._grid[row][column], "Could not find grid row " .. tostring(row) .. " / column " .. tostring(column))
    self._grid[row][column] = value
end

function Grid:__tostring()
    local str = ""
    self:Each(function(row : number, column : number)
        if row ~= 1 and column == 1 then
            str = str .. "\n"
        end
        str = str .. SeatToStringMap[self:_getValue(row, column)]
    end)
    return str
end

return Grid