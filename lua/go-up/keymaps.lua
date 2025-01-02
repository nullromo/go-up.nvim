local keymaps = {}

keymaps.setUpKeymaps = function(goUp)
    -- adjust when using zz to center the screen
    vim.keymap.set('n', 'zz', function()
        goUp.centerScreen()
    end, { desc = 'go-up screen center' })
end

return keymaps
