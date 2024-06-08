--=====================================================================================
--=====================================================================================
RU = LibStub("AceAddon-3.0"):NewAddon("RU", "AceEvent-3.0", "AceConsole-3.0")
--=====================================================================================
--=====================================================================================
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
--=====================================================================================
--=====================================================================================
local functionsHalted = false
--=====================================================================================
--=====================================================================================
function RU:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("RUDB", self.defaults, true)
    AC:RegisterOptionsTable("RU_Options", self.options)
    self.optionsFrame = ACD:AddToBlizOptions("RU_Options", "Rep Up!")
    profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    AC:RegisterOptionsTable("RU_Profiles", profiles)
    ACD:AddToBlizOptions("RU_Profiles", "Profiles", "Rep Up!")
    self:RegisterChatCommand("repup", "SlashCommand")
    self:RegisterChatCommand("rep", "SlashCommand")
    self:RegisterChatCommand("ru", "SlashCommand")
end
--=====================================================================================
--=====================================================================================
function RU:OnEnable()
    self:RegisterEvent("MAJOR_FACTION_RENOWN_LEVEL_CHANGED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("UPDATE_FACTION")
end
--=====================================================================================
--=====================================================================================
function RU:PLAYER_ENTERING_WORLD(...)
    C_Timer.After(1, function()
        functionsHalted = false
    end)
    functionsHalted = true
    self:MuteSounds()
end
--=====================================================================================
--=====================================================================================
local muteSoundIDs = {
    568016,
    2066672
}
--=====================================================================================
--=====================================================================================
function RU:MuteSounds()
    for _, soundID in ipairs(muteSoundIDs) do
        MuteSoundFile(soundID)
    end
end
--=====================================================================================
--=====================================================================================
local function RandomSoundID()
    local validSoundIDs = {}
    for soundID, soundList in pairs(sounds) do
        for _, _ in pairs(soundList) do
            table.insert(validSoundIDs, {table = sounds, id = soundID})
        end
    end
    for soundID, soundList in pairs(defaultSounds) do
        for _, _ in pairs(soundList) do
            table.insert(validSoundIDs, {table = defaultSounds, id = soundID})
        end
    end
    if #validSoundIDs == 0 then
        return nil
    end
    local randomIndex = math.random(1, #validSoundIDs)
    return validSoundIDs[randomIndex]
end
--=====================================================================================
--=====================================================================================
local function SelectSound(soundID)
    if not soundID or soundID == 2 then
        return RandomSoundID()
    end
    return {table = sounds, id = soundID}
end
--=====================================================================================
--=====================================================================================
function RU:MAJOR_FACTION_RENOWN_LEVEL_CHANGED(event, ...)
    if functionsHalted then return end
    local sound = SelectSound(RU.db.profile.RenownSoundSelect)
    local volumeLevel = RU.db.profile.RenownVolume
    local soundFile
    if volumeLevel == 0 then
        return
    end
    if sound.id == 1 then
        soundFile = defaultSounds[5][volumeLevel]
    else
        soundFile = sound.table[sound.id][volumeLevel]
    end
    if soundFile then
        PlaySoundFile(soundFile, "MASTER")
    end
end
--===============================================
function TestRenownSound()
    local sound = SelectSound(RU.db.profile.RenownSoundSelect)
    local volumeLevel = RU.db.profile.RenownVolume
    local soundFile
    if volumeLevel == 0 then
        return
    end
    if sound.id == 1 then
        soundFile = defaultSounds[5][volumeLevel]
    else
        soundFile = sound.table[sound.id][volumeLevel]
    end
    if soundFile then
        PlaySoundFile(soundFile, "MASTER")
    end
end
--=====================================================================================
--=====================================================================================
local TrackedFactions = {}
--===============================================
function RU:UPDATE_FACTION(event, ...)
    if functionsHalted then return end
    for i = 1, GetNumFactions() do
        local _, _, newstanding, _, _, _, _, _, isheader, _, hasrep, _, _, faction = GetFactionInfo(i)
        if not faction then return nil end
        if (not isheader or hasrep) and (newstanding or 0) > 0 then
            local oldstanding = TrackedFactions[faction]
            if oldstanding and oldstanding < newstanding and RU.db.profile.RepSoundSelect then
                local sound = SelectSound(RU.db.profile.RepSoundSelect)
                local volumeLevel = RU.db.profile.RepVolume
                local soundFile
                if volumeLevel == 0 then
                    return
                end
                if sound.id == 1 then
                    soundFile = defaultSounds[6][volumeLevel]
                else
                    soundFile = sound.table[sound.id][volumeLevel]
                end
                PlaySoundFile(soundFile, "MASTER")
            end
            TrackedFactions[faction] = newstanding
        end
    end
end
--===============================================
function TestRepSound()
    local sound = SelectSound(RU.db.profile.RepSoundSelect)
    local volumeLevel = RU.db.profile.RepVolume
    local soundFile
    if volumeLevel == 0 then
        return
    end
    if sound.id == 1 then
        soundFile = defaultSounds[6][volumeLevel]
    else
        soundFile = sound.table[sound.id][volumeLevel]
    end
    if soundFile then
        PlaySoundFile(soundFile, "MASTER")
    end
end
--=====================================================================================
--=====================================================================================
function RU:SlashCommand(input, editbox)
    if input == "enable" then
        self:Enable()
        self:Print("Enabled.")
    elseif input == "disable" then
        self:Disable()
        self:Print("Disabled.")
    else
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    end
end