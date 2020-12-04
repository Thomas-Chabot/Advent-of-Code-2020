return function(v)
    return (#v == 7) and string.match(v, "^#[0-9A-Fa-f]+$")
end