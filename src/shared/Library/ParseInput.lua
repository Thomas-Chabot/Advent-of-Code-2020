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
            local ret = parseLine(text)
            if ret then
                table.insert(result, ret)
            end
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

-- Parses a table of input strings
function parseTable(inputs : {string}, parserFunc : (string) -> any) : {any}
    local result = { }
    for _,input in ipairs(inputs) do
        table.insert(result, parserFunc(input))
    end
    return result
end

-- Parse out the number from a string
function toNumber(input : string) : number
    return tonumber(string.match(input, "%d+"))
end

return {
    Custom = parse,
    ParseTable = parseTable,
    Split = splitString,
    ToNumbers = parseNumbers,

    ToNumber = toNumber,
}