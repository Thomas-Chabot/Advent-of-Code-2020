--print(numbers)
local function getResult(numbers : {number}) : number
    local distances = {
        [1] = 0,
        [2] = 0,
        [3] = 1
    }

    local optionalNums = 0
    for i = 2,#numbers-1 do
        local distance = numbers[i] - numbers[i - 1]
        local nextDistance = numbers[i + 1] - numbers[i]

        distances[distance] += 1
        if distance == 1 and nextDistance == 1 then
            --print(numbers[i])
            optionalNums += 1
        end
    end

    return distances[1] * distances[3]
end

return getResult