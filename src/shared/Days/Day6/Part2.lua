--[[
    Runs the logic for Part 2 of Day 6.
    In Part 2, yes answers are only counted if every participant gave that answer;
     so the logic is to check every participant against the participants so far,
     where an answer is only counted if every participant so far has also given that answer.
]]

local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)

local function parseInput(input : string) : number
    local answersSoFar : {string} = { }
    local mergedAnswers : {string} = { }
    local currentPerson : number = 0

    for s in string.gmatch(input, ".") do
        if s == "\n" then
            currentPerson += 1

            answersSoFar = mergedAnswers
            mergedAnswers = { }

            continue
        end

        if answersSoFar[s] or currentPerson == 0 then
            mergedAnswers[s] = true
        end
    end

    local count = 0 
    for v,_ in pairs(answersSoFar) do
        count += 1
    end

    return count
end

return function(inputStrings : {string}) : number
    local count = 0
    for _,str in pairs(inputStrings) do
        count += parseInput(str)
    end
    return count
end