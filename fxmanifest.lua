fx_version 'cerulean'
game 'gta5'

author 'Nouma'
description 'Tickets ah ouais'
version '1.0.0'

lua54 'yes'

client_script {
    'client/main.lua',
    'client/command_helper.lua',
    'client/ui/report_detail.lua',
    'client/ui/report_list.lua',
    'client/ui/report.lua',
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/commands/report_list.lua',
    'server/commands/report.lua',
}

shared_script {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
}