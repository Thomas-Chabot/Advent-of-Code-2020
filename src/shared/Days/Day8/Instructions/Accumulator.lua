local Types = require(script.Parent.Parent.Types)

local Accumulator = { }
Accumulator.__index = Accumulator

function Accumulator.new(program : Types.ProgramType, argument : number) : Types.InstructionType
    local self = setmetatable({
        _instructionType = "acc",
        _program = program,
        _arg = argument,

        _encounters = 0
    }, Accumulator)

    return self
end

function Accumulator:Reset()
    self._encounters = 0
end
function Accumulator:GetEncounters() : number
    return self._encounters
end

function Accumulator:Run() : number
    self._encounters += 1
    self._program:IncreaseAccumulator(self._arg)
    return 1
end

return Accumulator