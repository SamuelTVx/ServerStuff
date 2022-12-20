fx_version 'adamant'

game 'gta5'

shared_script '@es_extended/imports.lua'

client_scripts {
	'client/*.lua',
	'config.lua',
	'damage/*.lua'
}

server_scripts {
	'server/*.lua'
}


server_exports {
    'GetConfigServer'
}
client_script "@villa/acloader.lua"