--=====================================================================================
-- RU | Better Level Up!
--=====================================================================================
RU = LibStub("AceAddon-3.0"):NewAddon("RU", "AceEvent-3.0", "AceConsole-3.0")

--=====================================================================================
-- Version Number
--=====================================================================================
VersionNumber = C_AddOns.GetAddOnMetadata("Rep Up!", "Version")

--=====================================================================================
-- Libraries
--=====================================================================================
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")

--=====================================================================================
-- Initialization
--=====================================================================================
function RU:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("RUDB", self.defaults, true)
    
    -- Register options
    AC:RegisterOptionsTable("RU_Options", self.options)
    self.optionsFrame = ACD:AddToBlizOptions("RU_Options", "Rep Up!")
    
    local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    AC:RegisterOptionsTable("RU_Profiles", profiles)
    ACD:AddToBlizOptions("RU_Profiles", "Profiles", "Rep Up!")
    
    -- Register chat commands
    self:RegisterChatCommand("repup", "SlashCommand")
    self:RegisterChatCommand("rep", "SlashCommand")
    self:RegisterChatCommand("ru", "SlashCommand")
end

--=====================================================================================
-- Utility Functions
--=====================================================================================

-- Function to print debug messages
function RU:DebugMessage(message)
    if debugMode then
        print(message)
    end
end

--=====================================================================================

-- Function to select a random sound ID from available sounds
function RandomSoundID()
    if debugMode then
        RU:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] Selecting a random sound ID...")
    end

    local validSoundIDs = {}

    -- Collect all custom sound IDs
    for soundID, soundList in pairs(sounds) do
        for _, _ in pairs(soundList) do
            table.insert(validSoundIDs, {table = sounds, id = soundID})
        end
    end

    -- Collect all default sound IDs
    for soundID, soundList in pairs(defaultSounds) do
        for _, _ in pairs(soundList) do
            table.insert(validSoundIDs, {table = defaultSounds, id = soundID})
        end
    end

    -- Return nil if no valid sound IDs are found
    if #validSoundIDs == 0 then
        if debugMode then
            RU:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] |cffff0000No valid sound IDs found.|r")
        end
        return nil
    end

    -- Select a random sound ID from the list
    local randomIndex = math.random(1, #validSoundIDs)
    local selectedSoundID = validSoundIDs[randomIndex]

    if debugMode then
        RU:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] Random sound ID selected: |cff8080ff" .. selectedSoundID.id .. "|r")
    end

    return selectedSoundID
end

--=====================================================================================

-- Function to select a sound based on the provided sound ID
function SelectSound(soundID)
    if debugMode then
        RU:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] Selecting sound with ID: |cff8080ff" .. tostring(soundID) .. "|r")
    end

    -- If the sound ID is not provided or is set to random (2), return a random sound ID
    if not soundID or soundID == 2 then
        local randomSoundID = RandomSoundID()
        if randomSoundID then
            if debugMode then
                RU:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] Using random sound ID: |cff8080ff" .. randomSoundID.id .. "|r")
            end
            return randomSoundID
        end
    end

    -- Otherwise, return the specified sound ID
    if debugMode then
        RU:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] Using specified sound ID: |cff8080ff" .. soundID .. "|r")
    end
    return {table = sounds, id = soundID}
end

--=====================================================================================

-- Function to play the selected sound with the specified volume level
function PlaySelectedSound(sound, volumeLevel, defaultTable)
    if debugMode then
        RU:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] Playing sound with ID: |cff8080ff" .. sound.id .. "|r and volume level: |cff8080ff" .. volumeLevel .. "|r")
    end

    -- Do not play the sound if the volume level is set to 0
    if volumeLevel == 0 then
        if debugMode then
            RU:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] |cffff0000Volume level is |cff8080ff0|r, sound not played.|r")
        end
        return
    end

    -- Determine the sound file to play based on the sound ID and volume level
    local soundFile = sound.id == 1 and defaultTable[volumeLevel] or sound.table[sound.id][volumeLevel]

    if debugMode then
        RU:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] Sound file to play: |cffce9178" .. tostring(soundFile) .. "|r")
    end

    -- Play the sound file using the "MASTER" sound channel
    if soundFile then
        PlaySoundFile(soundFile, "MASTER")
    end
end

--=====================================================================================
-- Slash Command
--=====================================================================================

-- Slash command handler to toggle debug mode and other commands
function RU:SlashCommand(input)
    if input == "debug" then
        debugMode = not debugMode
        if debugMode then
            print("[|cff3bbc00RU|r] [|cff808080DEBUG|r] Debug mode |cff00e012enabled|r.")
        else
            print("[|cff3bbc00RU|r] [|cff808080DEBUG|r] Debug mode |cffff0000disabled|r.")
        end
    elseif input == "enable" then
        self:Enable()
        self:Print("Enabled.")
        if debugMode then
            self:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] Addon |cff00e012enabled|r.")
        end
    elseif input == "disable" then
        self:Disable()
        self:Print("Disabled.")
        if debugMode then
            self:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] Addon |cffff0000disabled|r.")
        end
    else
        Settings.OpenToCategory(self.optionsFrame.name)
        if debugMode then
            self:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] Options panel opened.")
        end
    end
end

-- Register the Slash Command
SLASH_RUDEBUG1 = "/RU"
SlashCmdList["RUDEBUG"] = function(msg)
    RU:SlashCommand(msg)
end
