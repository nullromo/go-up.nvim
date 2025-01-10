local internals = require('go-up.internals')
local options = require('go-up.options')
local setup = require('go-up.setup')

local M = {}

-- main setup function for Go-Up.nvim
M.setup = function(opts)
    -- set options so that other files can use them
    options.setOptions(opts)

    -- set up the plugin
    setup.modifySettings()
    setup.setupAutocommands()
    setup.setupKeymaps()
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
