local goUpInternals = require('go-up.internals')

local goUpModule = {}

-- main setup function for Go-Up.nvim
goUpModule.setup = function(opts)
    -- make sure options is not nil
    opts = opts or {}

    -- set up autocommands
    goUpInternals.setUpAutocommands()

    -- set up keymaps
    goUpInternals.setUpKeymaps(goUpModule)
end

-- centers the screen normally, then adjusts so that the current line is
-- actually centered
goUpModule.centerScreen = function()
    -- center the screen first, then adjust
    vim.cmd('normal! zz')

    -- get the line the cursor is on
    local currentLine = vim.fn.line('.')

    -- get information about the current window
    local wininfo = vim.fn.getwininfo(vim.fn.win_getid())[1]
    local halfHeight = math.floor(wininfo.height / 2)
    local targetTopLine = currentLine - halfHeight
    local offset = wininfo.topline - targetTopLine

    -- scroll accordingly
    if offset > 0 then
        vim.cmd('execute "normal ' .. math.abs(offset) .. '"')
    else
        vim.cmd('execute "normal ' .. math.abs(offset) .. '"')
    end
end

-- export module
return goUpModule
