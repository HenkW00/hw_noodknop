fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

author 'Henk W'
description 'Advanced panic button script for ESX'
version '1.2.2'

shared_scripts { 
  'config.lua',
  'locale.lua',
  'locales/*.lua',
}

client_scripts {
  'client/main.lua',
}

server_scripts {
	'server/main.lua',
}

dependency '/assetpacks'