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

goUpInternals.setUpKeymaps = function(goUp)
    -- adjust when using zz to center the screen
    vim.keymap.set('n', 'zz', function()
        goUpInternals.centerScreen()
    end, { desc = 'go-up screen center' })
end

return goUpInternals
