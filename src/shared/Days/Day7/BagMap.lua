local Bag = require(script.Parent.Bag)

type BagMapNode = {
    Containing: {Bag.ContainedBagCount},
    ContainedBy: {string}
}
type BagMapType = {
    Contents: {[string]: {BagMapNode}}
}

local BagMap = { }
BagMap.__index = BagMap

function BagMap.new(bags : {Bag.BagType}): BagMapType
    local self = setmetatable({
        Contents = { }
    }, BagMap)
    self:_init(bags)

    return self
end

function BagMap:FindBagsContaining(bagName : string) : {string}
    local foundBagsDict = { }
    local results = { }

    local nodes = {
        bagName
    }

    while #nodes >= 1 do
        local nodeName = table.remove(nodes, #nodes)

        -- Go through every containing bag and add it to the list
        local node = self.Contents[nodeName]
        for _,bag in pairs(node.ContainedBy) do
            -- Skip the node if we've already added it to our list
            if foundBagsDict[bag] then
                continue
            end

            -- Otherwise, add it to the list
            foundBagsDict[bag] = true
            table.insert(results, bag)
            table.insert(nodes, bag)
        end
    end

    return results
end

function BagMap:CalculateBagWeight(bagName : string, weights: {[string]: number}?) : {string}
    if not weights then
        weights = { }
    end

    if weights[bagName] then
        return weights[bagName]
    end

    local node = self.Contents[bagName]
    local weight = 0
    for _,child in pairs(node.Containing) do
        local childWeight = self:CalculateBagWeight(child.Name, weights)
        weight += child.Count + child.Count * childWeight
    end

    weights[bagName] = weight
    return weight
end

function BagMap:_init(bags : {Bag.BagType})
    -- Step 1) Initialize every bag in the map
    local map = { }
    for _,bag in pairs(bags) do
        map[bag.Name] = {
            Containing = bag.Contains,
            ContainedBy = { }
        }
    end

    -- Step 2) Go through every bag and set up their "Contained By" maps
    for _,bag in pairs(bags) do
        for _,containing in pairs(bag.Contains) do
            table.insert(map[containing.Name].ContainedBy, bag.Name)
        end
    end

    -- Step 3) Assign the map to ourselves
    self.Contents = map
end

return BagMap