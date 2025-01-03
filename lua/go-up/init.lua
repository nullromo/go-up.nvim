local goUpInternals = require('go-up.internals')

local goUpModule = {}

-- main setup function for Go-Up.nvim
goUpModule.setup = function(opts)
    -- make sure options is not nil
    opts = opts or {}

    -- set up autocommands
    goUpInternals.setUpAutocommands()

    -- set up keymaps
    goUpInternals.setUpKeymaps()
end

-- public functions
goUpModule.centerScreen = goUpInternals.centerScreen

-- export module
return goUpModule
