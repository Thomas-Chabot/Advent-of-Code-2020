--!strict
--[[
    Provides a library of parsing functions for parsing input.
]]

-- Core parse function - parses out each line based on a provided function
local function parse(input : string, parseLine : (string) -> any): {any}
    local result = { }
    for text in string.gmatch(input, "([^\n]+)") do
        if text ~= "" then
            table.insert(result, parseLine(text))
        end
    end

    return result
end

-- Parses every line of input into one element of an array
function parseIntoLines(input : string) : {string}
    return parse(input, function(s) return s end)
end

-- Parses every line of input into a number in an array
function parseNumbers(input : string) : {number}
    return parse(input, function(s) return tonumber(s) end)
end

return {
    ToLines = parseIntoLines,
    ToNumbers = parseNumbers,

    Custom = parse
}