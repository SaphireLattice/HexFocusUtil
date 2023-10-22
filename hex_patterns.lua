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
    },
    ["deaqq"] = {
        "eval",
        dir = "SE"
    },
    ["dadad"] = {
        "foreach",
        dir = "NE"
    },
    ["aqqqqq"] = {
        "read_offhand",
        dir = "E"
    },
    ["aqqqqqe"] = {
        "readable_offhand",
        dir = "E"
    },
    ["awdd"] = {
        "choose",
        name = "Augur's Exaltation",
        dir = "NE",
        arg = { "bool", "any", "any" },
        ret = { "any" }
    },
    ["dd"] = {
        "pos",
        dir = "NE"
    },
    ["aa"] = {
        "eye_pos",
        dir = "N"
    },
    ["wa"] = {
        "eye_dir",
        dir = "N"
    },
    ["wqaawdd"] = {
        "raycast",
        dir = "E"
    },
    ["weddwaa"] = {
        "raycast_face",
        dir = "E"
    },
    ["aadaa"] = {
        "copy",
        dir = "E"
    },
    ["aadadaaw"] = {
        "copy_2",
        dir = "E"
    },
    ["aawdd"] = {
        "swap",
        dir = "E"
    },
    ["ddqdd"] = {
        "swap_201",
        dir = "NE"
    },
    ["qqd"] = {
        "create_light",
        dir = "NE"
    },
    ["qwaeawq"] = {
        "unwrap",
        dir = "NW"
    },
    ["waaw"] = {
        "sum",
        dir = "NE"
    },
    ["eaqa"] = {
        "mediafy",
        dir = "W"
    }
}

local function encode(code)
    local found = aliases[code]
    if found and found:gsub("[aqwedsAQWEDS_]", "") == "" then
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
