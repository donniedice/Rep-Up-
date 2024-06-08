local VersionNumber = "2.1.1"
local soundOptions = {
    "[Default]",
    "[Random]",
    "Altered Beast",
    "Assassin's Creed",
    "Castlevania",
    "Diablo 2",
    "Dragon Quest",
    "DotA 2",
    "EverQuest",
    "Fallout - New Vegas",
    "Fallout 3",
    "Final Fantasy",
    "Fire Emblem",
    "Fire Emblem - Awakening",
    "Fly For Fun",
    "Fortnite",
    "GTA - San Andreas",
    "Kingdom Hearts 3",
    "Kirby (1)",
    "Kirby (2)",
    "League of Legends",
    "Legend of Zelda",
    "Maplestory",
    "Metal Gear Solid",
    "Minecraft",
    "Modern Warfare 2",
    "Morrowind",
    "Old School Runescape",
    "Palworld",
    "Path of Exile",
    "Pokemon",
    "Ragnarok Online",
    "Shining Force II",
    "Shining Force III (1)",
    "Shining Force III (2)",
    "Shining Force III (3)",
    "Shining Force III (4)",
    "Shining Force III (5)",
    "Shining Force III (6)",
    "Shining Force III (7)",
    "Shining Force III (8)",
    "Shining Force III (9)",
    "Shining Force III (10)",
    "Shining Force III (11)",
    "Skyrim",
    "Sonic The Hedgehog",
    "Spryo The Dragon",
    "Super Mario Bros 3",
    "Warcraft 3",
    "Witcher 3 (1)",
    "Witcher 3 (2)",
}
RU.defaults = {
    profile = {
        RepSoundSelect = 27,
        RepVolume = 2.0,
    },
}
RU.options = {
    type = "group",
    name = "",
    handler = RU,
    args = {
        group1 = {
            type = "header",
            order = 1,
            name = "|cff3bbc00R|r|cffffffffep|r |cff05dffaU|r|cffffffffp!|r",
        },
		group2 = {
			type = "group",
			order = 2,
			name = "|cff3bbc00Reputation Rank-Up!|r",
			inline = true,
			get = "GetValue",
			set = "SetValue",
			args = {
                RepSoundSelect = {
                    type = "select",
                    order = 1,
                    name = "",
                    values = soundOptions,
                },
                TestRepSound = {
                    type = "execute",
                    order = 2,
                    image = "Interface\\Addons\\Rep Up!\\images\\play.blp",
                    imageWidth = 20,
                    imageHeight = 20,
                    name = "",
                    desc = "",
                    func = TestRepSound,
                },
                RepVolume = {
                    type = "range",
                    order = 3,
                    name = "|cff3bbc00Volume|r",
                    desc = "|cffffffffAdjust Reputation Rank-Up! Sound Volume|r",
                    min = 0,
                    max = 3, 
                    step = 1,
                },
            },
        },
		group3 = {
			type = "header",
			order = 3,
			name = "|cff8080ff" .. VersionNumber .. "|r",
		},
	},
}
function RU:GetValue(info)
	return self.db.profile[info[#info]]
end
function RU:SetValue(info, value)
	self.db.profile[info[#info]] = value
end