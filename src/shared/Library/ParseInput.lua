local function parse(input : string, parseLine : (string) -> any): {any}
    local result = { }
    for text in string.gmatch(input, "([^\n]+)") do
        if text ~= "" then
            table.insert(result, parseLine(text))
        end
    end

    return result
end

function parseIntoLines(input : string) : {string}
    return parse(input, function(s) return s end)
end
function parseNumbers(input : string) : {number}
    return parse(input, function(s) return tonumber(s) end)
end

return {
    ToLines = parseIntoLines,
    ToNumbers = parseNumbers
}