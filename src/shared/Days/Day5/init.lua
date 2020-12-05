--[[
    Solution for Day 5 of Advent of Code.

    Day 5 involves parsing out a boarding pass number into a Seat ID.
    Boarding pass numbers are given in the format "RRRRRRRCCC", where R is either "F" or "B", identifying the Row number;
     And C is "L" or "R", identifying the Column number. Logic is defined under Seat.lua.
    
    Part 1: Find the highest seat number.
    Part 2: Find my seat, given by whichever seat that does not have a boarding pass between two other seats.
]]

local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)
local Input = require(script.Input)
local Seat = require(script.Seat)

-- Build out every seat
local seats = Parser.Custom(Input, Seat.new)

-- Sort the seats so that they appear in order
table.sort(seats)

-- Can find my seat based on the next seat being empty.
-- Go through every seat and compare against its next seat to see if its empty
local mySeat = nil
for i,seat in ipairs(seats) do
    -- Note: This would break if i is the last index of the table.
    -- However: A constraint of the puzzle is that my seat is not the first or last seat, so this is fine.
    -- TODO: May need to improve later if it's used for another puzzle.
    if seat:GetSeatId() + 1 ~= seats[i + 1]:GetSeatId() then
        mySeat = seat:GetSeatId() + 1
        break
    end
end

-- Part 1 Result: The last seat;
-- Part 2 Result: My seat
return {
    Part1Result = seats[#seats]:GetSeatId(),
    Part2Result = mySeat
}