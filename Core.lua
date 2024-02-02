-- v1.0.6

-- Mute default Reputation level up sound
-- This code block mutes the default Reputation level up sound by registering an event listener for ADDON_LOADED event and muting the sound file with ID 568016.

-- REPUTATION RANK UP
-- This code block registers an event listener for PLAYER_LOGIN, UPDATE_FACTION, and QUEST_LOG_UPDATE events to track reputation changes for all factions. It plays a sound file with ID 569593 when the reputation rank goes up.

-- Chat Message
-- This code block registers an event listener for PLAYER_LOGIN event and prints a chat message to inform the user that the addon will no longer receive updates and its functionality has been merged into BLU - Better Level Up! addon.


-- Mute default Reputation level up sound
local frame_a = CreateFrame("Frame")
frame_a:RegisterEvent("ADDON_LOADED")
frame_a:SetScript("OnEvent",
	function(self, event, ...)
		MuteSoundFile(568016)
	end)

-- REPUTATION RANK UP
local trackedFactions = {}
local frame_b = CreateFrame("Frame")
frame_b:RegisterEvent("PLAYER_LOGIN") -- Player login
frame_b:RegisterEvent("UPDATE_FACTION") -- Kill rep
frame_b:RegisterEvent("QUEST_LOG_UPDATE") -- Quest rep

frame_b:SetScript("OnEvent", function()
	for i = 1, GetNumFactions() do
		local _, _, newStanding, _, _, _, _, _, isHeader, _, hasRep, _, _, faction = GetFactionInfo(i)
		if faction and (not isHeader or hasRep) and (newStanding or 0) > 0 then
			-- Make sure we have the info we need and standing isn't UNKNOWN (0)
			local oldStanding = trackedFactions[faction]
			if oldStanding and oldStanding < newStanding then
				-- Check if standing went up (allow same code to initialize tracking)
				PlaySoundFile(569593) -- Play Level up Sound
			end

			trackedFactions[faction] = newStanding -- Update standing
		end
	end
end)

-- Chat Message
local frame_c = CreateFrame("Frame")
frame_c:RegisterEvent("PLAYER_LOGIN")
frame_c:SetScript("OnEvent", function(self, event, text, ...)
	if event == "PLAYER_LOGIN" then
		print("|cff3bbc00Rep Up!|r Will no longer be receiving updates. Functionality has been merged into |c2d4b92ffBLU - Better Level Up!|r. If you're a fan of my sound addons, |c2d4b92ffBLU - Better Level Up!|r is available from all addon provider websites. Thank you!")
	end
end)
