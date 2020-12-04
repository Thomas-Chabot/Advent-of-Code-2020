/*
    This is a JavaScript file that pre-parses the input from Advent of Code,
     so that it can more easily be used with the Lua script. This is specifically designed to help parse out \n\n.

    To run: Load the input for Day 4 in Chrome. Paste this code into the console window.
    You can then copy the body of the page into Input.lua.
*/


var data = document.body.innerText;
var matches = data.split("\n\n")
let resultStr = "return {\n";
for (let match of matches){
    resultStr += `[[
${match}
    ]],
    `;
}

document.body.innerText = resultStr + "}";

// can then copy from the document body into Input.lua