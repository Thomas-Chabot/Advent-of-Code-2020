local SortedArray = { }
SortedArray.__index = SortedArray

local binarySearch = require(script.Parent.Parent.lib.BinarySearch)

function SortedArray.new()
    return setmetatable({
        _contents = { }
    }, SortedArray)
end

function SortedArray:Add(element)
    table.insert(self._contents, self:FindIndex(element), element)
end

function SortedArray:GetContents()
    return self._contents
end

function SortedArray:Remove(element)
    table.remove(self._contents, table.find(self._contents, element))
end

function SortedArray:FindIndex(element)
    local i = 1
    while self._contents[i] and self._contents[i] < element do
        i += 1
    end
    return i
end
return SortedArray