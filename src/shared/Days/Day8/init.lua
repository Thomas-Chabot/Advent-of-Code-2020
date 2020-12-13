local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)
local Program = require(script.Program)

local function getResult(input : string) : number
    local program = Program.new()

    local function addInstruction(s : string)
        program:AddInstruction(s)
    end

    Parser.Custom(input, addInstruction)
    program:Run()

    return program:GetAccumulator()
end

return {
    Part1Result = getResult(require(script.Input.Input)),
  --  Part2Result = getResult(require(script.Input.FixedInput))
}