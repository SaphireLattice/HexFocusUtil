local focus = peripheral.find("focal_port")

if not focus.hasFocus() then
    print("No focus inserted, can't work with nothing")
    return
end

local iotaType = focus.getIotaType()

local iota = focus.readIota()

print(iotaType, iota)

function gotPatterns(iota)
    local isPatternList = true

    for i = 1, #iota do
        print(i, iota[i].angles)
        if
            type(iota[i]) ~= "table"
            or (
                iota[i].angles == nil
                and not gotPatterns(iota[i])
            )
        then
            print("Not a valid iota " .. i)
            isPatternList = false
            break
        end
    end

    if not isPatternList then
        return false
    end
    return true
end

local hexPatterns = require("hex_patterns")

local args = {...}

if args[1] == "print" then
    for i = 1, #iota do
        local angles = iota[i].angles
        if hexPatterns.patterns[angles] then
            print(hexPatterns.patterns[angles][1])
        else
            print(angles)
        end
    end
    return
end

function readIota(iotaRead)
    if iotaRead.startDir and iotaRead.angles then
        local knownPattern = hexPatterns.patterns[iotaRead.angles]
        if knownPattern then
            return iotaRead.startDir .. " " .. knownPattern[1]
        end
        return iotaRead.startDir .. " " ..iotaRead.angles
    end

    local out = {}
    for i = 1, #iotaRead do
        local iota = iotaRead[i]
        table.insert(out, readIota(iota))
    end

    return table.concat(out, "\n")
end

if args[1] == "read" and args[2] ~= nil then
    if not gotPatterns(iota) then
        print("Requires readable iotas!")
        return
    end
    local saveFile, err = io.open(args[2], "w")
    if not saveFile then error(err) end

    saveFile:write(readIota(iota))

    --for i = 1, #iota do
    --    saveFile:write(iota[i].startDir .. " ")
    --    saveFile:write(iota[i].angles .. "\n")
    --end
    print("Saved")
    return
end

if args[1] == "write" and args[2] ~= nil then
    local newIota = {}

    local readFile, err = io.open(args[2], "r")
    if notSaveFile then error(err) end
    for line in readFile:lines() do
        local chunks = {}
        line = line:gsub("//.*", "")
        for chunk in line:gmatch("%S+") do
            table.insert(chunks, chunk)
        end

        local dir = #chunks == 2 and chunks[1]
        local angles = #chunks >= 1 and chunks[#chunks]

        if not angles then
        elseif angles:gsub("[_aqwdeAQWDE]", "") ~= "" then
            -- not a pattern
            local encoded = hexPatterns.encode(angles)
            if encoded == nil then
                print("Err: unknown shorthand \"" .. angles .. "\"")
            end
            angles = encoded
        else
            angles = string.lower(angles:gsub("_", ""))
        end

        if angles then
            if not dir and hexPatterns.patterns[angles] then
                -- get canonical direction if known
                dir = hexPatterns.directions[
                    hexPatterns.patterns[angles].dir
                ]
            end

            if hexPatterns.directions[dir] then
                dir = hexPatterns.directions[dir]
            end

            table.insert(newIota, {
                startDir = dir or "EAST",
                angles = angles
            })
        end
    end
    focus.writeIota(newIota)
    print("Wrote iota: ".. #newIota .." patterns")
    return
end

print("Usage: focus [command] (...)")
print(" - print - Print focus contents out")
print(" - read [filename] - Save focus info into a file")
print(" - write [filename] - Read a spell into a focus")
