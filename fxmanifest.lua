fx_version 'cerulean'
games { 'gta5' }

author 'Forcng'
description 'Forcng - Job Center Script'

lua54 'yes'

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

dependency 'ox_lib'
