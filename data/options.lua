--=====================================================================================
-- Default Profile Settings
--=====================================================================================
RU.defaults = {
    profile = {
        RenownSoundSelect = 21,
        RenownVolume = 2.0,
        RepSoundSelect = 15,
        RepVolume = 2.0,
    },
}

--=====================================================================================
-- Options Definition
--=====================================================================================
RU.options = {
    type = "group",
    name = "",
    handler = RU,
    args = {
        group1 = {
            type = "header",
            order = 1,
            name = "|cff3bbc00R|r|cffffffffep|r |cff3bbc00U|r|cffffffffp!|r",
        },
        group2 = {
            type = "group",
            order = 2,
            name = "|cffffffffRenown Rank-Up!|r",
            inline = true,
            get = "GetValue",
            set = "SetValue",
            args = {
                RenownSoundSelect = {
                    type = "select",
                    order = 1,
                    name = "",
                    values = soundOptions,
                },
                TestRenownSound = {
                    type = "execute",
                    order = 2,
                    image = "Interface\\Addons\\Rep Up!\\images\\play.blp",
                    imageWidth = 20,
                    imageHeight = 20,
                    name = "",
                    desc = "",
                    func = "TestRenownSound",
                },
                RenownVolume = {
                    type = "range",
                    order = 3,
                    name = "|cffffffffVolume|r",
                    desc = "|cff3bbc00Adjust Renown Rank-Up! Sound Volume|r",
                    min = 0,
                    max = 3, 
                    step = 1,
                },
            },
        },
        group3 = {
            type = "group",
            order = 3,
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
                    func = "TestRepSound",
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
        group4 = {
            type = "header",
            order = 4,
            name = "|cff8080ff" .. VersionNumber .. "|r",
        },
    },
}

--=====================================================================================
-- Get and Set Functions
--=====================================================================================
function RU:GetValue(info)
    return self.db.profile[info[#info]]
end

function RU:SetValue(info, value)
    self.db.profile[info[#info]] = value
end
