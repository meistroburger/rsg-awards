fx_version 'cerulean'
lua54 'yes'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

name 'RSGCore Award System'
description 'Award System'
version '1.0.0'
author 'MeistroBurger'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/sh_*.lua'
}

client_scripts {
    'client/cl_*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_*.lua'
}

dependencies {
    'rsg-core',
    'ox_lib',
    'oxmysql'
}

exports {
    'incrementPlayerActivity'
}