--[[
    Runs the logic for part 1 of the question.
    In part 1, yes answers are counted as long as a single person gave that answer;
     so the logic is to add every value into a set and count the size of that set.
]]

local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)

type YesCount = {
    Answers: {string},
    Count: number
}

local IgnoreCharacters = {
    ['\n'] = true,
    [' '] = true
}

-- Runs the logic for generating counts
local function parseInput(input : string) : YesCount
    local answers : {string} = { }
    local count : number = 0

    for s in string.gmatch(input, ".") do
        if IgnoreCharacters[s] then
            continue
        end

        if not answers[s] then
            answers[s] = true
            count += 1
        end
    end

    return {
        Answers = answers,
        Count = count
    }
end

return function(input : {string}) : number
    local count = 0
    local answers = Parser.ParseTable(input, parseInput)
    for _,data in ipairs(answers) do
        count += data.Count
    end

    return count
end