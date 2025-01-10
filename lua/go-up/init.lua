local internals = require('go-up.internals')
local options = require('go-up.options')
local setup = require('go-up.setup')

local M = {}

-- main setup function for Go-Up.nvim
M.setup = function(opts)
    -- merge default options into user-defined options
    M.opts = vim.tbl_deep_extend('keep', opts or {}, options.defaultOptions)
    options.validateOptions(M.opts)

    -- set up the plugin
    setup.modifySettings(opts)
    setup.setupAutocommands()
    setup.setupKeymaps(opts)
    setup.setupUserCommands()
end

-- export public functions
M.centerScreen = internals.centerScreen
M.redraw = internals.redraw
M.alignTop = internals.alignTop
M.alignBottom = internals.alignBottom
M.align = internals.align

-- export module
return M
