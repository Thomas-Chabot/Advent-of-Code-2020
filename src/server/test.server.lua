local days = game.ReplicatedStorage.Common.Days
local dayResults = { }

for _,day in pairs(days:GetChildren()) do
    local dayNumber = tonumber(string.match(day.Name, "Day([%d]+)"))
    dayResults[dayNumber] = require(day)
end

for dayNumber,day in ipairs(dayResults) do
    print("DAY" .. dayNumber)
    print("\tPART 1: ", day.Part1Result)
    print("\tPART 2: ", day.Part2Result)
end