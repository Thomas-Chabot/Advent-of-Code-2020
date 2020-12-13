local Array = { }
Array.__index = Array

function Array.new()
    return setmetatable({
        _contents = { }
    }, Array)
end

function Array:Add(element)
    table.insert(self._contents, element)
end

function Array:GetNext()
    return self._contents[1]
end

function Array:Pop()
    return table.remove(self._contents, 1)
end

function Array:Count()
    return #self._contents
end

return Array