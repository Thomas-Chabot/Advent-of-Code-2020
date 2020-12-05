--!strict
--[[
    Provides a library of parsing functions for parsing input.
]]

local ParseType = {
    And = 0,
    Or = 1
}

-- Core parse function - parses out each line based on a provided function
local function parse(input : string, parseLine : (string) -> any, parseBy: {string}?): {any}
    if not parseBy then
        parseBy = "\n"
    end

    local result = { }
    for text in string.gmatch(input, "([^" .. parseBy .. "]+)") do
        if text ~= "" then
            table.insert(result, parseLine(text))
        end
    end

    return result
end

-- Parses every line of input into one element of an array
function splitString(input : string, parseBy: string?) : {string}
    return parse(input, function(s) return s end, parseBy)
end

-- Parses every line of input into a number in an array
function parseNumbers(input : string, parseBy: string?) : {number}
    return parse(input, function(s) return tonumber(s) end, parseBy)
end

-- Parse out the number from a string
function toNumber(input : string) : number
    return tonumber(string.match(input, "%d+"))
end

return {
    Custom = parse,
    Split = splitString,
    ToNumbers = parseNumbers,

    ToNumber = toNumber,
}