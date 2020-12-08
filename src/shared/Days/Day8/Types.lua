export type InstructionType = {
    Run : ()->number,
}

export type ProgramType = {
    Instructions : {any},
    CurrentLine : number,
}

return { }