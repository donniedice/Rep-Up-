--=====================================================================================
-- Event Registration
--=====================================================================================
function RU:OnEnable()
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:ReputationChatFrameHook() -- Hook the chat frame here instead of using UPDATE_FACTION
end

--=====================================================================================
-- Utility Functions
--=====================================================================================
local muteSoundID_v = {12345, 67890} -- Example sound IDs to mute

-- Function to mute specific sounds by their sound IDs
function RU:MuteSounds()
    for _, soundID in ipairs(muteSoundID_v) do -- Vanilla
        MuteSoundFile(soundID)
        if debugMode then
            self:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] Muting sound with ID: |cff8080ff" .. soundID .. "|r")
        end
    end
end

--=====================================================================================
-- Event Handlers
--=====================================================================================
function RU:PLAYER_ENTERING_WORLD(...)
    if debugMode then
        self:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] |cffc586c0PLAYER_ENTERING_WORLD|r event triggered.")
    end
    C_Timer.After(15, function()
        functionsHalted = false
    end)
    functionsHalted = true
    self:MuteSounds()
end

function RU:ReputationRankIncrease(factionName, newRank)
    if functionsHalted then return end
    if debugMode then
        self:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] |cffc586c0ReputationRankIncrease|r event triggered for |cff00e012" .. factionName .. "|r (Rank: " .. newRank .. ")")
    end
    local sound = SelectSound(RU.db.profile.RepSoundSelect)
    local volumeLevel = RU.db.profile.RepVolume
    PlaySelectedSound(sound, volumeLevel, defaultSounds[6])
end

--=====================================================================================
-- ChatFrame Hooks
--=====================================================================================
function RU:ReputationChatFrameHook()
    if not chatFrameHooked then
        ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", function(self, event, msg)
            for _, rank in ipairs(reputationRanks) do
                local reputationGainPattern = "You are now " .. rank .. " with (.+)%.?"
                local factionName = string.match(msg, reputationGainPattern)
                if factionName then
                    RU:ReputationRankIncrease(factionName, rank)
                end
            end
            return false -- Ensure the original message is not blocked
        end)
        chatFrameHooked = true
    end
end

--=====================================================================================
-- Test Functions
--=====================================================================================

function RU:TestRepSound()
    if debugMode then
        self:DebugMessage("[|cff3bbc00RU|r] [|cff808080DEBUG|r] |cffc586c0TestRepSound|r event triggered.")
    end
    local sound = SelectSound(self.db.profile.RepSoundSelect)
    local volumeLevel = self.db.profile.RepVolume
    PlaySelectedSound(sound, volumeLevel, defaultSounds[6])
end
