local Types = require(script.Parent.Parent.Types)

local NoOperation = { }
NoOperation.__index = NoOperation

function NoOperation.new(program : Types.ProgramType, argument : number) : Types.InstructionType
    return setmetatable({
        _instructionType = "nop",
        _program = program,
        _arg = argument,

        _encounters = 0
    }, NoOperation)
end

function NoOperation:Reset()
    self._encounters = 0
end
function NoOperation:GetEncounters() : number
    return self._encounters
end


function NoOperation:Run() : number
    self._encounters += 1
    return 1
end

return NoOperation