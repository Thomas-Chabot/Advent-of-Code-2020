export type ContainedBagCount = {
    Count: number,
    Name: string
}
export type BagType = {
    Name: string,
    Contains: { ContainedBagCount }
}

local Bag = { }
Bag.__index = Bag

function Bag.new(inputStr : string) : BagType
    local self = setmetatable({
        Name = "",
        Contains = { }
    }, Bag)
    self:_parse(inputStr)

    return self
end

function Bag:_parse(inputStr : string)
    local containedBags = { }

    local bagName, containingBags = inputStr:match("(.+) bags contain (.+)")
    print(containingBags)
    if containingBags ~= "no other bags." then
        for containedBagStr in string.gmatch(containingBags, "[^,.]+") do
            local count, name = containedBagStr:match("(%d+) (.+) bag")
            table.insert(containedBags, {
                Count = count,
                Name = name
            })
        end

        self.Contains = containedBags
    end

    self.Name = bagName
end

return Bag