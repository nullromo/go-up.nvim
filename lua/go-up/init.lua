local goUpInternals = require('go-up.internals')
local options = require('go-up.options')

local goUpModule = {}

-- main setup function for Go-Up.nvim
goUpModule.setup = function(opts)
    -- make sure options is not nil
    opts = opts or {}

    -- set default options if not already set
    if opts.mapZZ == nil then
        opts.mapZZ = options.defaultOptions.mapZZ
    end

    -- validate options
    options.validateOptions(opts)

    -- set options
    goUpInternals.opts = opts
    goUpModule.opts = opts

    -- set up autocommands
    goUpInternals.setUpAutocommands()

    -- set up keymaps
    goUpInternals.setUpKeymaps()
end

-- public functions
goUpModule.centerScreen = goUpInternals.centerScreen
goUpModule.reset = goUpInternals.reset
goUpModule.alignTop = goUpInternals.alignTop
goUpModule.alignBottom = goUpInternals.alignBottom
goUpModule.align = goUpInternals.align

-- export module
return goUpModule
