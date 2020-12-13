local Types = require(script.Parent.Types)

local instructionsFolder = script.Parent.Instructions
local instructions = {
    nop = require(instructionsFolder.NoOperation),
    acc = require(instructionsFolder.Accumulator),
    jmp = require(instructionsFolder.Jump),
}

local Program = { }
Program.__index = Program

function Program.new() : Types.ProgramType
    local self = setmetatable({
        _instructions = { },
        _currentLine = 1,
        _accumulator = 0,
    }, Program)

    return self
end

function Program:AddInstruction(instructionStr : string)
    local instructionType, argumentStr = instructionStr:match("([^ ]+) (.+)")
    local argument = tonumber(argumentStr)

    local Instruction = instructions[instructionType]
    local instruction = Instruction.new(self, argument)

    table.insert(self._instructions, instruction)
end

function Program:IncreaseAccumulator(increment : number)
    self._accumulator += increment
end
function Program:GetAccumulator() : number
    return self._accumulator
end

function Program:Run() : boolean
    self:Reset()

    local lineNumber = 1
    local instruction = self._instructions[lineNumber]
    while instruction ~= nil and instruction:GetEncounters() == 0 do
        if instruction._instructionType == "jmp" or instruction._instructionType == "nop" then
            --print(lineNumber)
        end
        
        local lineJump = instruction:Run()
        lineNumber += lineJump

        instruction = self._instructions[lineNumber]
    end

    -- Return true if the program ended; false if it encountered an infinite loop
    return instruction == nil
end

function Program:BruteforceFix() : number
    -- Step 1) Find all operations that are either a jump or a nop
    local alteredInstructions = { }
    for index,instruction in pairs(self._instructions) do
        if instruction._instructionType == "jmp" or instruction._instructionType == "nop" then
            table.insert(alteredInstructions, index)
        end
    end

    local i = 1
    while true do
        -- Swap the instruction
        local index = alteredInstructions[i]
        local actualInstruction = self._instructions[index]

        local SwappedInstruction = (actualInstruction._instructionType == "jmp") and instructions.nop or instructions.jmp
        self._instructions[index] = SwappedInstruction.new(self, actualInstruction._arg)

        -- Run the program, check if we passed
        if self:Run() then
            print("Swapping index ", index, " fixed the program. Argument ", actualInstruction._arg)
            break
        end

        -- Otherwise, reset and continue
        self._instructions[index] = actualInstruction
        i += 1
    end

    return self:GetAccumulator()
end
function Program:Reset()
    self._accumulator = 0
    for _,instruction in pairs(self._instructions) do
        instruction:Reset()
    end
end

return Program