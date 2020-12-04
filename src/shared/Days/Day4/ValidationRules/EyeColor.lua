local validColors = {
    amb = true,
    blu = true,
    brn = true,
    gry = true,
    grn = true,
    hzl = true,
    oth = true
}

return function(v)
    return validColors[v] or false
end