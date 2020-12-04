local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)

return function (v)
    local val = Parser.ToNumber(v)
    if string.match(v, "cm$") then
        -- cm
        return val >= 150 and val <= 193
    elseif string.match(v, "in$") then
        -- in
        return val >= 59 and val <= 76
    else
        -- neither; invalid
        return false
    end
end