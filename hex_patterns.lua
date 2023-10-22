local aliases = {
    ["{"] = "[",
    ["}"] = "]"
}

local patterns = {
    ["qaq"] = {
        -- personal mnemonic
        "self",
        -- TODO: get in-code names
        -- fancy book name
        dir = "NE",
        name = "Mind's Reflection",
        arg = {},
        ret = { "entity" }
    },
    ["qqq"] = {
        "[",
        dir = "W"
    },
    ["qqqaw"] = {
        "escape",
        dir = "W"
    },
    ["eee"] = {
        "]",
        dir = "E"
    }
}

local function encode(code)
    local found = aliases[code]
    if found and found:gsub("[aqwedAQWED_]", "") == "" then
        return found
    end

    code = found or code

    for k, v in pairs(patterns) do
        if type(v) == "table"
            and code == v[1]
            or code == v
        then
            return k
        end
    end
end

return {
    directions = {
        NW = "NORTH_WEST",
        NE = "NORTH_EAST",
        E = "EAST",
        SE = "SOUTH_EAST",
        SW = "SOUTH_WEST",
        W = "WEST"
    },
    patterns = patterns,
    aliases = aliases,
    encode = encode
}
