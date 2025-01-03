local goUpModule = require('go-up.go-up')
local keymaps = require('go-up.keymaps')

-- main setup function for Go-Up.nvim
goUpModule.setup = function(opts)
    -- make sure options is not nil
    opts = opts or {}

    goUpModule.opts = opts

    -- set up autocommands
    goUpModule.setUpAutocommands()

    -- set up keymaps
    keymaps.setUpKeymaps(goUpModule)
end

-- export module
return goUpModule
