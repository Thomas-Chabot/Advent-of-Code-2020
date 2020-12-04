type PassportValue = {
    Value: string,
    IsValid: boolean
}
type Passport = {
    BirthYear: PassportValue?,
    IssueYear: PassportValue?,
    ExpirationYear: PassportValue?,
    Height: PassportValue?,
    HairColor: PassportValue?,
    EyeColor: PassportValue?,
    PassportId: PassportValue?,
    CountryId: PassportValue?
}
type PassportMapValue = {
    Key: string,
    Parse: (string)->any
}

local Parser = require(game.ReplicatedStorage.Common.Library.ParseInput)
local Input = require(script.Input)

local RequiredValues = {
    "BirthYear", "IssueYear", "ExpirationYear", "Height", "HairColor", "EyeColor", "PassportId"
}
local ValidationRules = script.ValidationRules
local PassportMap : {[string]: string} = {
    byr = {
        Key = "BirthYear",
        Parse = require(ValidationRules.BirthYear)
    },
    iyr = {
        Key = "IssueYear",
        Parse = require(ValidationRules.IssueYear)
    },
    eyr = {
        Key = "ExpirationYear",
        Parse = require(ValidationRules.ExpirationYear)
    },
    hgt = {
        Key = "Height",
        Parse = require(ValidationRules.Height)
    },
    hcl = {
        Key = "HairColor",
        Parse = require(ValidationRules.HairColor)
    },
    ecl = {
        Key = "EyeColor",
        Parse = require(ValidationRules.EyeColor)
    },
    pid = {
        Key = "PassportId",
        Parse = require(ValidationRules.PassportId)
    },
    cid = {
        Key = "CountryId",
        Parse = require(ValidationRules.CountryId)
    }
}

-- Parses a single string of input into a passport
local function createPassport(data : string): Passport
    -- Split by newline (\n) or space ( )
    local dataPieces = Parser.Split(data, "\n ")
    local passportData = { }
    for _,item in pairs(dataPieces) do
        local lbl,value = unpack(Parser.Split(item, ":"))
        local parserMap = PassportMap[lbl]
        if not parserMap.Key then
            print("Could not find key for ", lbl)
        end

        passportData[parserMap.Key] = {
            Value = value,
            IsValid = parserMap.Parse(value)
        }
    end

    return passportData
end

-- Checks validity for each passport
local function checkPassport(passport : Passport): boolean
    local result = {
        ValuesExist = true,
        IsValid = true
    }
    for _,key in pairs(RequiredValues) do
        if not passport[key] then
            result.ValuesExist = false
            result.IsValid = false
            break
        elseif not passport[key].IsValid then
            print(key, passport)
            result.IsValid = false
        end
    end
    return result
end

local passports = { }
local count, validCount = 0, 0
for i,data in pairs(Input) do
    local passport = createPassport(data)
    local result = checkPassport(passport)

    if result.ValuesExist then
        count += 1
    end
    if result.IsValid then
        validCount += 1
    end

    passports[i] = passport
end

return {
    Part1Result = count,
    Part2Result = validCount
}