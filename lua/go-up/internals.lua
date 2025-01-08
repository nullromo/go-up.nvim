local goUpInternals = {}

-- create a namespace for the extmarks for the virtual lines
goUpInternals.goUpNamespace = vim.api.nvim_create_namespace('Go-UpNamespace')

-- this function adds the extmarks to the current buffer
local setUpExtmarks = function()
    for line = 1, 100 do
        vim.api.nvim_buf_set_extmark(0, goUpInternals.goUpNamespace, 0, 0, {
            id = line,
            virt_lines = { { { '', 'NonText' } } },
            virt_lines_above = true,
        })
    end
end

goUpInternals.reset = function()
    -- clear all extmarks in the namespace for the current buffer
    vim.api.nvim_buf_clear_namespace(0, goUpInternals.goUpNamespace, 0, -1)
    -- reset the extmarks
    setUpExtmarks()
end

goUpInternals.setUpAutocommands = function()
    -- every time a buffer is entered, make sure the extmarks are set up
    vim.api.nvim_create_autocmd('BufEnter', {
        callback = function()
            goUpInternals.reset()
        end,
        desc = 'set up extmarks for go-up',
    })
    -- every time the text changes, make sure the virtual lines are not in the
    -- middle of the text
    vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
        callback = function()
            goUpInternals.reset()
        end,
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
    if offset == 0 then
        return
    elseif offset > 0 then
        vim.cmd('execute "normal! ' .. math.abs(offset) .. '"')
    else
        vim.cmd('execute "normal! ' .. math.abs(offset) .. '"')
    end
end

-- if the file is below the top of the window, scrolls down until line 1 is at
-- the top
goUpInternals.alignTop = function()
    local windowID = vim.fn.win_getid()
    local windowScreenPosition = vim.fn.win_screenpos(windowID)[1]
    local firstLineScreenPosition = vim.fn.screenpos(windowID, 1, 1).row
    local offset = firstLineScreenPosition - windowScreenPosition
    if offset <= 0 then
        return
    end
    vim.cmd('execute "normal! ' .. math.abs(offset) .. '"')
end

-- if the last line of the file is above the bottom of the window, scrolls up
-- until the last line is at the bottom
goUpInternals.alignBottom = function()
    local windowID = vim.fn.win_getid()
    local windowScreenPosition = vim.fn.win_screenpos(windowID)[1]
    local windowHeight = vim.fn.getwininfo(windowID)[1].height
    local lastLineNumber = vim.fn.line('$', windowID)
    local lastLineScreenPosition =
        vim.fn.screenpos(windowID, lastLineNumber, 1).row
    local offset = windowScreenPosition
        + windowHeight
        - lastLineScreenPosition
        - 1
    if lastLineScreenPosition == 0 or offset <= 0 then
        return
    end
    vim.cmd('execute "normal! ' .. math.abs(offset) .. '"')
end

goUpInternals.align = function()
    local windowID = vim.fn.win_getid()
    local lastLineNumber = vim.fn.line('$', windowID)
    local firstLineScreenPosition = vim.fn.screenpos(windowID, 1, 1).row
    local lastLineScreenPosition =
        vim.fn.screenpos(windowID, lastLineNumber, 1).row
    local windowScreenPosition = vim.fn.win_screenpos(windowID)[1]

    if firstLineScreenPosition > windowScreenPosition then
        goUpInternals.alignTop()
    elseif lastLineScreenPosition > 0 then
        goUpInternals.alignBottom()
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

goUpInternals.modifySettings = function()
    if not goUpInternals.respectSplitkeep then
        vim.opt.splitkeep = 'topline'
    end
    if not goUpInternals.respectScrolloff then
        vim.opt.scrolloff = 0
    end
end

vim.api.nvim_create_user_command('GoUpReset', function()
    goUpInternals.reset()
end, { desc = 'Go-Up reset function' })

vim.api.nvim_create_user_command('GoUpAlignTop', function()
    goUpInternals.alignTop()
end, { desc = 'Go-Up align top function' })

vim.api.nvim_create_user_command('GoUpAlignBottom', function()
    goUpInternals.alignBottom()
end, { desc = 'Go-Up align bottom function' })

vim.api.nvim_create_user_command('GoUpAlign', function()
    goUpInternals.align()
end, { desc = 'Go-Up align function' })

return goUpInternals
