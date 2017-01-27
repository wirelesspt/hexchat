-- Auto starts OTR query

hexchat.register('OTRPM', '2', 'Automatically start otr upon /query nick')

hexchat.hook_print('Open Context', function (args)
        -- We only want queries
        if hexchat.props['type'] ~= 3 then
                return
        end

        -- Ignore empty tabs, znc queries, and scripting consoles
        if not hexchat.get_info('channel'):match('^[%*%(>]') then
                hexchat.command('chanopt -quiet /otr start')
        end
end)

