return {
        'barrett-ruth/live-server.nvim',
        config = function()
            require('live-server').setup({
                settings = {
                    log = false,
                    open = false,
                    wait = 1000,
                    ignore = 'scss,less,config.js,md,txt',
                },
            })
        end,
    }
