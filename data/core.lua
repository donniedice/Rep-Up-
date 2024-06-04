--v2.0.0
RU = LibStub("AceAddon-3.0"):NewAddon("RU", "AceEvent-3.0", "AceConsole-3.0")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
local functionsHalted = false
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
function RU:OnEnable()
    self:RegisterEvent("MAJOR_FACTION_RENOWN_LEVEL_CHANGED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("UPDATE_FACTION")
end
function RU:PLAYER_ENTERING_WORLD(...)
    DEFAULT_CHAT_FRAME:AddMessage("Rep Up!: |cff3bbc00Thank you for Downloading Rep Up!|r Enter '|cff3bbc00/rep|r' to Select |cff3bbc00R|reputation |cff3bbc00R|ank|r-|cff3bbc00U|rp Sounds!")
    DEFAULT_CHAT_FRAME:AddMessage("Rep Up!: |cffdc143cNOTE|r: You may have to re-select a previously selected sound after |cffdc143cA|rddon |cffdc143cU|rpdates.")
    C_Timer.After(15, function()
        functionsHalted = false
    end)
    functionsHalted = true
    self:MuteSounds()
end
local muteSoundIDs = {
    568016,
    2066672
}
function RU:MuteSounds()
    for _, soundID in ipairs(muteSoundIDs) do
        MuteSoundFile(soundID)
    end
end
local defaultAchievementSounds = {
    [1] = "Interface\\Addons\\Rep Up!\\sounds\\achievement_default_low.ogg",
    [2] = "Interface\\Addons\\Rep Up!\\sounds\\achievement_default_med.ogg",
    [3] = "Interface\\Addons\\Rep Up!\\sounds\\achievement_default_high.ogg"
}
local defaultHonorSounds = {
    [1] = "Interface\\Addons\\Rep Up!\\sounds\\honor_default_low.ogg",
    [2] = "Interface\\Addons\\Rep Up!\\sounds\\honor_default_med.ogg",
    [3] = "Interface\\Addons\\Rep Up!\\sounds\\honor_default_high.ogg"
}
local defaultLevelSounds = {
    [1] = "Interface\\Addons\\Rep Up!\\sounds\\level_default_low.ogg",
    [2] = "Interface\\Addons\\Rep Up!\\sounds\\level_default_med.ogg",
    [3] = "Interface\\Addons\\Rep Up!\\sounds\\level_default_high.ogg"
}
local defaultBattlePetLevelSounds = {
    [1] = "Interface\\Addons\\Rep Up!\\sounds\\battle_pet_level_default_low.ogg",
    [2] = "Interface\\Addons\\Rep Up!\\sounds\\battle_pet_level_default_med.ogg",
    [3] = "Interface\\Addons\\Rep Up!\\sounds\\battle_pet_level_default_high.ogg"
}
local defaultRenownSounds = {
    [1] = "Interface\\Addons\\Rep Up!\\sounds\\renown_default_low.ogg",
    [2] = "Interface\\Addons\\Rep Up!\\sounds\\renown_default_med.ogg",
    [3] = "Interface\\Addons\\Rep Up!\\sounds\\renown_default_high.ogg"
}
local defaultRepSounds = {
    [1] = "Interface\\Addons\\Rep Up!\\sounds\\rep_default_low.ogg",
    [2] = "Interface\\Addons\\Rep Up!\\sounds\\rep_default_med.ogg",
    [3] = "Interface\\Addons\\Rep Up!\\sounds\\rep_default_high.ogg"
}
local defaultQuestAcceptSounds = {
    [1] = "Interface\\Addons\\Rep Up!\\sounds\\quest_accept_default_low.ogg",
    [2] = "Interface\\Addons\\Rep Up!\\sounds\\quest_accept_default_med.ogg",
    [3] = "Interface\\Addons\\Rep Up!\\sounds\\quest_accept_default_high.ogg"
}
local defaultQuestSounds = {
    [1] = "Interface\\Addons\\Rep Up!\\sounds\\quest_default_low.ogg",
    [2] = "Interface\\Addons\\Rep Up!\\sounds\\quest_default_med.ogg",
    [3] = "Interface\\Addons\\Rep Up!\\sounds\\quest_default_high.ogg"
}
local defaultPostSounds = {
    [1] = "Interface\\Addons\\Rep Up!\\sounds\\post_default_low.ogg",
    [2] = "Interface\\Addons\\Rep Up!\\sounds\\post_default_med.ogg",
    [3] = "Interface\\Addons\\Rep Up!\\sounds\\post_default_high.ogg"
}
local sounds = {
    [3] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\altered_beast_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\altered_beast_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\altered_beast_high.ogg"
    },
    [4] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\assassins_creed_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\assassins_creed_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\assassins_creed_high.ogg"
    },
    [5] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\castlevania_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\castlevania_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\castlevania_high.ogg"
    },
    [6] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\diablo_2_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\diablo_2_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\diablo_2_high.ogg"
    },
    [7] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\dragon_quest_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\dragon_quest_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\dragon_quest_high.ogg"
    },
    [8] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\dota_2_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\dota_2_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\dota_2_high.ogg"
    },
    [9] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\everquest_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\everquest_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\everquest_high.ogg"
    },
    [10] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\fallout_new_vegas_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\fallout_new_vegas_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\fallout_new_vegas_high.ogg"
    },
    [11] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\fallout_3_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\fallout_3_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\fallout_3_high.ogg"
    },
    [12] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\final_fantasy_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\final_fantasy_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\final_fantasy_high.ogg"
    },
    [13] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\fire_emblem_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\fire_emblem_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\fire_emblem_high.ogg"
    },
    [14] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\fire_emblem_awakening_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\fire_emblem_awakening_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\fire_emblem_awakening_high.ogg"
    },
    [15] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\fly_for_fun_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\fly_for_fun_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\fly_for_fun_high.ogg"
    },
    [16] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\fortnite_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\fortnite_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\fortnite_high.ogg"
    },
    [17] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\gta_san_andreas_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\gta_san_andreas_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\gta_san_andreas_high.ogg"
    },
    [18] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\kingdom_hearts_3_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\kingdom_hearts_3_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\kingdom_hearts_3_high.ogg"
    },
    [19] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\kirby-1_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\kirby-1_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\kirby-1_high.ogg"
    },
    [20] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\kirby-2_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\kirby-2_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\kirby-2_high.ogg"
    },
    [21] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\league_of_legends_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\league_of_legends_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\league_of_legends_high.ogg"
    },
    [22] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\legend_of_zelda_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\legend_of_zelda_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\legend_of_zelda_high.ogg"
    },
    [23] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\maplestory_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\maplestory_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\maplestory_high.ogg"
    },
    [24] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\metalgear_solid_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\metalgear_solid_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\metalgear_solid_high.ogg"
    },
    [25] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\minecraft_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\minecraft_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\minecraft_high.ogg"
    },
    [26] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\modern_warfare_2_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\modern_warfare_2_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\modern_warfare_2_high.ogg"
    },
    [27] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\morrowind_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\morrowind_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\morrowind_high.ogg"
    },
    [28] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\old_school_runescape_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\old_school_runescape_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\old_school_runescape_high.ogg"
    },
    [29] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\palworld_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\palworld_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\palworld_high.ogg"
    },
    [30] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\path_of_exile_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\path_of_exile_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\path_of_exile_high.ogg"
    },
    [31] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\pokemon_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\pokemon_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\pokemon_high.ogg"
    },
    [32] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\ragnarok_online_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\ragnarok_online_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\ragnarok_online_high.ogg"
    },
    [33] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_2_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_2_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_2_high.ogg"
    },
    [34] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-1_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-1_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-1_high.ogg"
    },
    [35] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-2_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-2_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-2_haigh.ogg"
    },
    [36] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-3_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-3_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-3_high.ogg"
    },
    [37] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-4_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-4_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-4_high.ogg"
    },
    [38] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-5_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-5_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-5_high.ogg"
    },
    [39] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-6_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-6_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-6_high.ogg"
    },
    [40] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-7_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-7_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-7_high.ogg"
    },
    [41] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-8_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-8_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-8_high.ogg"
    },
    [42] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-9_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-9_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-9_high.ogg"
    },
    [43] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-10_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-10_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-10_high.ogg"
    },
    [44] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-11_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-11_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\shining_force_3-11_high.ogg"
    },
    [45] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\skyrim_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\skyrim_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\skyrim_high.ogg"
    },
    [46] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\sonic_the_hedgehog_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\sonic_the_hedgehog_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\sonic_the_hedgehog_high.ogg"
    },
    [47] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\spyro_the_dragon_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\spyro_the_dragon_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\spyro_the_dragon_high.ogg"
    },
    [48] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\super_mario_bros_3_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\super_mario_bros_3_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\super_mario_bros_3_high.ogg"
    },
    [49] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\warcraft_3_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\warcraft_3_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\warcraft_3_high.ogg"
    },
    [50] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\witcher_3-1_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\witcher_3-1_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\witcher_3-1_high.ogg"
    },
    [51] = {
        [1] = "Interface\\Addons\\Rep Up!\\sounds\\witcher_3-2_low.ogg",
        [2] = "Interface\\Addons\\Rep Up!\\sounds\\witcher_3-2_med.ogg",
        [3] = "Interface\\Addons\\Rep Up!\\sounds\\witcher_3-2_high.ogg"
    },
}
local allSounds = {
    sounds,
    defaultAchievementSounds,
    defaultHonorSounds,
    defaultLevelSounds,
    defaultBattlePetLevelSounds,
    defaultRenownSounds,
    defaultRepSounds,
    defaultQuestAcceptSounds,
    defaultQuestSounds,
    defaultPostSounds
}
local function RandomSoundID()
    local validSoundIDs = {}
    for i, _ in pairs(sounds) do
        if i ~= 2 then
            table.insert(validSoundIDs, i)
        end
    end
    local randomIndex = math.random(1, #validSoundIDs)
    return validSoundIDs[randomIndex]
end
local function SelectSound(soundID)
    if soundID == 2 then
        soundID = RandomSoundID()
    end
    return soundID
end
function RU:MAJOR_FACTION_RENOWN_LEVEL_CHANGED(self, event, ...)
    if functionsHalted then return end
    local soundID = SelectSound(RU.db.profile.RenownSoundSelect)
    local volumeLevel = RU.db.profile.RenownVolume
    local soundFile
    if volumeLevel == 0 then
        return
    end
    if soundID == 1 then
        soundFile = defaultRenownSounds[volumeLevel]
    else
        soundFile = sounds[soundID][volumeLevel]
    end
    if soundFile then
        PlaySoundFile(soundFile, "MASTER")
    end
end
function TestRenownSound()
    local soundID = SelectSound(RU.db.profile.RenownSoundSelect)
    local volumeLevel = RU.db.profile.RenownVolume
    local soundFile
    if volumeLevel == 0 then
        return
    end
    if soundID == 1 then
        soundFile = defaultRenownSounds[volumeLevel]
    else
        soundFile = sounds[soundID][volumeLevel]
    end
    if soundFile then
        PlaySoundFile(soundFile, "MASTER")
    end
end
local TrackedFactions = {}
function RU:UPDATE_FACTION(event, ...)
    if functionsHalted then return end
    for i = 1, GetNumFactions() do
        local _, _, newstanding, _, _, _, _, _, isheader, _, hasrep, _, _, faction = GetFactionInfo(i)
        if faction and (not isheader or hasrep) and (newstanding or 0) > 0 then
            local oldstanding = TrackedFactions[faction]
            if oldstanding and oldstanding < newstanding and RU.db.profile.RepSoundSelect then
                local soundID = SelectSound(RU.db.profile.RepSoundSelect)
                local volumeLevel = RU.db.profile.RepVolume
                local soundFile
                if volumeLevel == 0 then
                    return
                end
                if soundID == 1 then
                    soundFile = defaultRepSounds[volumeLevel]
                else
                    soundFile = sounds[soundID][volumeLevel]
                end
                PlaySoundFile(soundFile, "MASTER")
            end
            TrackedFactions[faction] = newstanding
        end
    end
end
function TestRepSound()
    local soundID = SelectSound(RU.db.profile.RepSoundSelect)
    local volumeLevel = RU.db.profile.RepVolume
    local soundFile
    if volumeLevel == 0 then
        return
    end
    if soundID == 1 then
        soundFile = defaultRepSounds[volumeLevel]
    else
        soundFile = sounds[soundID][volumeLevel]
    end
    if soundFile then
        PlaySoundFile(soundFile, "MASTER")
    end
end
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