--!strict
--[[
    This class implements the boarding pass / seat logic of Advent of Code, Day 5.
    A seat is created by passing in the boarding pass data: a string of 10 characters,
     where the first 7 characters define the row and the final 3 characters define the seat.
]]

export type SeatType = {
    _seatId : number
}

local Seat = { 
    _seatId = -1
}
Seat.__index = Seat

-- Constructor
function Seat.new(passData : string) : SeatType
    local self = setmetatable({
        _passData = passData:lower(),

        _row = nil,
        _column = nil,
        _seatId = -1
    }, Seat)

    self:_init()
    return self
end

-- Returns the ID for the seat
function Seat:GetSeatId() : number
    return self._seatId
end

-- Initializes the seat - row number, column number, and seat ID
function Seat:_init()
    -- Init works like a binary search.
    -- First, to define the row; then, to define the seat.
    self._row = self:_runBinarySearch(self._passData:sub(1,7), "b")
    self._column = self:_runBinarySearch(self._passData:sub(8, 10), "r")
    self._seatId = self._row * 8 + self._column
end

-- Runs a binary search to determine a result, given an input string and a character that defines "back".
-- The process is: If the character matches against backChar, then you take the back half; otherwise, take the front half.
-- Repeat this process until you land at one single value, then return that value.
function Seat:_runBinarySearch(str : string, backChar : string) : number
    local n = math.pow(2, #str)
    local lowerBound = 0
    for i = 1,#str do
        local char = str:sub(i,i)
        if char == backChar then
            lowerBound += n/2
        end

        n /= 2
    end
    return lowerBound
end

-- Metamethods
function Seat:__tostring() : string
    return "A seat located at Row " .. tostring(self._row) .. " and Column " .. tostring(self._column) .. " with the ID of " .. tostring(self._seatId)
end

-- Comparison is based around the seat ID; run the normal operators on each seat's seat id
function Seat:__lt(otherSeat : SeatType): boolean
    return self._seatId < otherSeat._seatId
end
function Seat:__le(otherSeat : SeatType): boolean
    return self._seatId <= otherSeat._seatId
end

return Seat