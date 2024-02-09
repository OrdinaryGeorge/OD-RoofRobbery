fx_version 'cerulean'
game 'gta5'

author 'Ordinary Developments!'
description 'A Script taking immersion to the next level'
version '1.0'
shared_scripts {'Config.lua'}

server_script {'server/*.lua','@oxmysql/lib/MySQL.lua',}
client_script {'client/*.lua', 'Config.lua', '@PolyZone/client.lua','@PolyZone/BoxZone.lua','@PolyZone/EntityZone.lua','@PolyZone/CircleZone.lua','@PolyZone/ComboZone.lua',}

escrow_ignore {'Config.lua'}

depedency {'PolyZone', 'interact-sound', 'qb-menu', 'qb-target'}

lua54 'yes'