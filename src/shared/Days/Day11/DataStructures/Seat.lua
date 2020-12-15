local Seat = { }
Seat.__index = Seat

export type SeatType = number
export type SeatClassType = {
    _seatType : SeatTypes,
    _surroundingSeats : {[string]: SeatClassType}
}

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

function Seat.new(seatType : string)
    return setmetatable({
        _seatType = SeatValues[seatType],
        _surroundingSeats = { }
    }, Seat)
end
function Seat.Copy(otherSeat : SeatClassType)
    return setmetatable({
        _seatType = otherSeat._seatType,
        _surroundingSeats = otherSeat._surroundingSeats
    }, Seat)
end

function Seat:IsFloor()
    return self._seatType == SeatTypes.Floor
end
function Seat:IsEmpty()
    return self._seatType == SeatTypes.Empty
end
function Seat:IsOccupied()
    return self._seatType == SeatTypes.Occupied
end

function Seat:SetEmpty()
    self._seatType = SeatTypes.Empty
end
function Seat:SetOccupied()
    self._seatType = SeatTypes.Occupied
end

function Seat:__tostring()
    return SeatToStringMap[self._seatType]
end

Seat.DefaultType = SeatTypes.Floor

return Seat