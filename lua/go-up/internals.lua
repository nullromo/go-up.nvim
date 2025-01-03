local goUpInternals = {}

-- create a namespace for the extmarks for the virtual lines
goUpInternals.goUpNamespace = vim.api.nvim_create_namespace('Go-UpNamespace')

-- this function adds the extmarks to the current buffer
goUpInternals.setUpExtmarks = function()
    for line = 1, 100 do
        vim.api.nvim_buf_set_extmark(0, goUpInternals.goUpNamespace, 0, 0, {
            id = line,
            virt_lines = { { { '', 'NonText' } } },
            virt_lines_above = true,
        })
    end
end

goUpInternals.setUpAutocommands = function()
    -- every time a buffer is entered, make sure the extmarks are set up
    vim.api.nvim_create_autocmd('BufEnter', {
        callback = function()
            goUpInternals.setUpExtmarks()
        end,
        desc = 'set up extmarks for go-up',
    })
end

-- centers the screen normally, then adjusts so that the current line is
-- actually centered
goUpInternals.centerScreen = function()
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

goUpInternals.setUpKeymaps = function()
    if goUpInternals.opts.mapZZ then
        -- adjust the scroll result when using zz to center the screen
        vim.keymap.set('n', 'zz', function()
            goUpInternals.centerScreen()
        end, { desc = 'go-up screen center' })
    end
end

return goUpInternals
