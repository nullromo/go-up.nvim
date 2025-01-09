local internals = require('go-up.internals')
local options = require('go-up.options')

local M = {}


local function autocmd_setup()
    -- every time the text changes, make sure the virtual lines are not in the
    -- middle of the text
    local events = { 'BufEnter', 'TextChanged', 'TextChangedI' }
    vim.api.nvim_create_autocmd(events, {
        callback = internals.redraw,
        group = vim.api.nvim_create_augroup('go-up', {}),
        desc = 'go-up: redraw virtual toplines',
    })
end


local function keymaps_setup()
      -- adjust the scroll result when using zz to center the screen
      vim.keymap.set('n', 'zz', internals.centerScreen, {
        desc = 'go-up: center screen'
      })
end

local function usercmds_setup()
    vim.api.nvim_create_user_command('GoUpReset', internals.redraw, {
        desc = 'Go-Up reset function'
    })

    vim.api.nvim_create_user_command('GoUpAlignTop', internals.alignTop, {
        desc = 'Go-Up align top function'
    })

    vim.api.nvim_create_user_command('GoUpAlignBottom', internals.alignBottom, {
        desc = 'Go-Up align bottom function'
    })

    vim.api.nvim_create_user_command('GoUpAlign', internals.align, {
        desc = 'Go-Up align function'
    })
end

local function modifySettings()
    if not M.opts.respectSplitkeep then
        vim.opt.splitkeep = 'topline'
    end
    if not M.opts.respectScrolloff then
        vim.opt.scrolloff = 0
    end
end

-- main setup function for Go-Up.nvim
M.setup = function(opts)
    opts = vim.tbl_deep_extend("keep", opts or {}, options.defaultOptions)

    options.validateOptions(opts)

    -- share options
    M.opts = opts

    -- modify settings
    modifySettings()

    autocmd_setup()
    if internals.opts.mapZZ then
      keymaps_setup()
    end
    usercmds_setup()
end

-- public functions
M.centerScreen = internals.centerScreen
M.reset = internals.redraw
M.alignTop = internals.alignTop
M.alignBottom = internals.alignBottom
M.align = internals.align

-- export module
return M
