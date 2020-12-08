local Types = require(script.Parent.Parent.Types)

local Jump = { }
Jump.__index = Jump

function Jump.new(program : Types.ProgramType, argument : number) : Types.InstructionType
    return setmetatable({
        _instructionType = "jmp",
        _program = program,
        _arg = argument,

        _encounters = 0
    }, Jump)
end

function Jump:Reset()
    self._encounters = 0
end
function Jump:GetEncounters() : number
    return self._encounters
end


function Jump:Run() : number
    self._encounters += 1
    return self._arg
end

return Jump