local M = {}

-- create a namespace for the extmarks for the virtual lines
local ns = vim.api.nvim_create_namespace('go-up')

M.redraw = function()
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

    -- loop makes every line a single extmark and not one big block
    for _ = 1, vim.api.nvim_win_get_height(0) do
        vim.api.nvim_buf_set_extmark(0, ns, 0, 0, {
            virt_lines = { { { '', 'NonText' } } },
            virt_lines_above = true,
        })
    end
end

-- centers the screen normally, then adjusts so that the current line is
-- actually centered
M.centerScreen = function()
    -- center the screen first, then adjust
    vim.cmd('normal! zz')

    -- get the line the cursor is on
    local currentLine = vim.fn.line('.')
    local topLine = vim.fn.line('w0')

    -- get information about the current window
    local height = vim.api.nvim_win_get_height(0)
    local halfHeight = math.floor(height / 2)
    local targetTopLine = currentLine - halfHeight
    local offset = topLine - targetTopLine

    if offset == 0 then
        return
    end

    local cmd = offset > 0 and '' or ''
    vim.cmd(([[execute "normal! %d%s"]]):format(math.abs(offset), cmd))
end

-- if the file is below the top of the window, scrolls down until line 1 is at
-- the top
M.alignTop = function()
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
M.alignBottom = function()
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

M.align = function()
    local windowID = vim.fn.win_getid()
    local lastLineNumber = vim.fn.line('$', windowID)
    local firstLineScreenPosition = vim.fn.screenpos(windowID, 1, 1).row
    local lastLineScreenPosition =
        vim.fn.screenpos(windowID, lastLineNumber, 1).row
    local windowScreenPosition = vim.fn.win_screenpos(windowID)[1]

    if firstLineScreenPosition > windowScreenPosition then
        M.alignTop()
    elseif lastLineScreenPosition > 0 then
        M.alignBottom()
    end
end

return M
