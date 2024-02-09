fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

author 'Henk W'
description 'Noodknop systeem voor AMRP'
version '1.2.1'

shared_scripts { 
  'config.lua',
  'locale.lua',
  'locales/*.lua',
}

client_script 'client/main.lua'

server_scripts {
	'server/main.lua',
}
 
escrow_ignore {
  'config.lua',
  'locales/en.lua', 
  'fxmanifest.lua', 
}

dependency '/assetpacks'