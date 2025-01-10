local internals = require('go-up.internals')

local M = {}

M.setupAutocommands = function()
    -- every time the text changes, make sure the virtual lines are not in the
    -- middle of the text
    vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged', 'TextChangedI' }, {
        callback = internals.redraw,
        group = vim.api.nvim_create_augroup('go-up', {}),
        desc = 'Go-Up.nvim: redraw virtual lines',
    })
end

M.setupKeymaps = function(opts)
    if opts.mapZZ then
        -- adjust the scroll result when using zz to center the screen
        vim.keymap.set('n', 'zz', internals.centerScreen, {
            desc = 'Go-Up.nvim: center the screen',
        })
    end
end

M.setupUserCommands = function()
    -- each top-level function gets its own user command for easy access
    vim.api.nvim_create_user_command('GoUpRedraw', internals.redraw, {
        desc = 'Go-Up.nvim: redraw virtual lines',
    })
    vim.api.nvim_create_user_command('GoUpAlignTop', internals.alignTop, {
        desc = 'Go-Up.nvim: scroll to hide top virtual lines',
    })
    vim.api.nvim_create_user_command('GoUpAlignBottom', internals.alignBottom, {
        desc = 'Go-Up.nvim: scroll to hide bottom virtual lines',
    })
    vim.api.nvim_create_user_command('GoUpAlign', internals.align, {
        desc = 'Go-Up.nvim: scroll to hide virtual lines',
    })
end

M.modifySettings = function(opts)
    if not opts.respectSplitkeep then
        vim.opt.splitkeep = 'topline'
    end
    if not opts.respectScrolloff then
        vim.opt.scrolloff = 0
    end
end

return M
