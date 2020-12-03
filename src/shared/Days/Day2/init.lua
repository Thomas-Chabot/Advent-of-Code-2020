--!strict
--[[
    Solutions for Day 2 of the Advent of Code, 2020.

    Part 1: Find how many passwords are valid according to the password criteria, where the occurences of a given character in the string
     must be between Int1 and Int2, inclusive.

    Part 2: Find how many passwords are valid according to new password criteria, where only one of the two spots specified by Int1 and Int2 may have the given character.
     The password is invalid if neither have the character -or- if both have the character.
]]

type Password = {
    PasswordString: string,
    Criteria: {
        CharacterType: string,
        Int1: number,
        Int2: number
    }
}

local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)
local InputData = require(script.Input)

-- Parses every line of input data into a Password type.
local function parseInputData(data : string): Password
    local Int1, Int2, CharacterType, PasswordStr = string.match(data, "([%d]+)-([%d]+) (.): (.+)")
    return {
        PasswordString = PasswordStr,
        Criteria = {
            CharacterType = CharacterType,
            Int1 = tonumber(Int1),
            Int2 = tonumber(Int2)
        }
    }
end

-- Checks the password against the criteria used for Part 1 of the question.
-- Returns true if the number of occurrences of a given character in the string are between Int1 and Int2.
local function checkPasswordMeetsCriteriaP1(password : Password): boolean
    local checkCharacter = password.Criteria.CharacterType
    local _, count = string.gsub(password.PasswordString, checkCharacter, "")

    return count >= password.Criteria.Int1 and count <= password.Criteria.Int2
end

-- Checks the password against the criteria used for Part 2 of the question.
-- Returns true if the character at Int1 of the password is CharacterType xor the character at Int2 is CharacterType (but not both)
local function checkPasswordMeetsCriteriaP2(password : Password): boolean
    local checkCharacter = password.Criteria.CharacterType
    local int1, int2 = password.Criteria.Int1, password.Criteria.Int2

    -- For each of int1, int2 - if the characters match, associate a 1; otherwise, associate a 0
    local isChar1 : number = (password.PasswordString:sub(int1, int1) == checkCharacter) and 1 or 0
    local isChar2 : number = (password.PasswordString:sub(int2, int2) == checkCharacter) and 1 or 0

    -- Now can use these counts to total up how many matches we have & return true if it's strictly 1
    return (isChar1 + isChar2) == 1
end

-- Counts the number of valid passwords in the array according to a specified criteria.
local function countValidPasswords(passwordsArray: {Password}, criteria: (Password)->boolean)
    local count = 0
    for _,password in ipairs(passwordsArray) do
        if criteria(password) then
            count += 1
        end
    end
    return count
end

-- Counts the number of valid passwords in the array according to the criteria for Part 1.
local function countValidPasswordsP1(passwordsArray: {Password})
    return countValidPasswords(passwordsArray, checkPasswordMeetsCriteriaP1)
end


-- Counts the number of valid passwords in the array according to the criteria for Part 2.
local function countValidPasswordsP2(passwordsArray: {Password})
    return countValidPasswords(passwordsArray, checkPasswordMeetsCriteriaP2)
end

-- Create the input
local Input = Parser.Custom(InputData, parseInputData)

-- Check results
local Part1Answer = countValidPasswordsP1(Input)
local Part2Answer = countValidPasswordsP2(Input)

-- Run the process
return {
    Part1Result = Part1Answer,
    Part2Result = Part2Answer
}