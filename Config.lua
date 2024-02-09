Config = {
    ---- Blip Config ----
    BlipSprite = 459, -- https://docs.fivem.net/docs/game-references/blips/#blips
    BlipColor = 46, -- https://docs.fivem.net/docs/game-references/blips/#blips-colours
    ---- Reward Item Config ----
    RewardItem = 'metalscrap',
    RewardItemAmount = math.random(1,10),
    ---- Fail Alarm Sound Config ----
    FailAlarmSound = "security-alarm",
    FailAlarmDistance = 5.0,
    FailAlarmVolume = 0.2,
}
Config.Locations = {
    ['Roofs'] = {
        [1] = {coords = vector3(-1230.98, -837.31, 29.41), done = false},
        [2] = {coords = vector3(-1239.69, -804.13, 26.24), done = false},
        [3] = {coords = vector3(-1258.09, -794.84, 24.49), done = false},
        [4] = {coords = vector3(-1256.82, -779.79, 29.25), done = false},
        [5] = {coords = vector3(-1270.25, -761.85, 28.77), done = false},
        [6] = {coords = vector3(-1556.23, -454.66, 47.37), done = false},
        [7] = {coords = vector3(-578.93, -132.66, 52.0), done = false},
        [8] = {coords = vector3(-635.11, -87.21, 51.97), done = false},
        [9] = {coords = vector3(-506.55, -31.04, 50.69), done = false},
        [10] = {coords = vector3(908.21, -1710.38, 42.97), done = false},
        [11] = {coords = vector3(883.28, -1707.98, 41.22), done = false},
        [12] = {coords = vector3(50.05, -1599.1, 36.43), done = false},
        [13] = {coords = vector3(375.65, -932.11, 39.81), done = false},
        [14] = {coords = vector3(357.2, -982.53, 35.87), done = false},
        [15] = {coords = vector3(319.4, -1016.73, 67.27), done = false},
    },
}