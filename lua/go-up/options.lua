local options = {}

local checkType = function(value, valueName, typeName)
    if type(value) ~= typeName then
        error(valueName .. ' must be a ' .. typeName .. ' for Go-Up.nvim')
    end
end

options.defaultOptions = {
    -- affect the behavior of zz
    mapZZ = true,
    -- respect splitkeep setting
    respectSplitkeep = false,
    -- respect scrolloff setting
    respectScrolloff = false,
    -- respect smoothscroll setting
    respectSmoothscroll = false,
    -- limit number of virtual lines. See options table
    goUpLimit = nil,
    -- number of offset lines to use when aligning
    alignOffsetLines = { top = 0, bottom = 0 },
}

options.validateOptions = function(opts)
    for key, value in pairs(opts) do
        if key == 'mapZZ' then
            checkType(value, 'opts.mapZZ', 'boolean')
        elseif key == 'respectSplitkeep' then
            checkType(value, 'opts.respectSplitkeep', 'boolean')
        elseif key == 'respectScrolloff' then
            checkType(value, 'opts.respectScrolloff', 'boolean')
        elseif key == 'respectSmoothscroll' then
            checkType(value, 'opts.respectSmoothscroll', 'boolean')
        elseif key == 'goUpLimit' then
            if
                value ~= nil
                and type(value) ~= 'number'
                and value ~= 'center'
            then
                error(
                    'goUpLimit must be nil, a number, or "center" for Go-Up.nvim'
                )
            end
        elseif key == 'alignOffsetLines' then
            for key2, value2 in pairs(value) do
                if key2 == 'top' then
                    checkType(value2, 'opts.alignOffsetLines.top', 'number')
                    if value2 < 0 then
                        error(
                            'opts.alignOffsetLines.top must be positive for Go-Up.nvim'
                        )
                    end
                elseif key2 == 'bottom' then
                    checkType(value2, 'opts.alignOffsetLines.bottom', 'number')
                    if value2 < 0 then
                        error(
                            'opts.alignOffsetLines.bottom must be positive for Go-Up.nvim'
                        )
                    end
                else
                    error(
                        '"opts.alignOffsetLines.'
                            .. key2
                            .. '" is not a valid option for Go-Up.nvim'
                    )
                end
            end
        else
            error('"opts.' .. key .. '" is not a valid option for Go-Up.nvim')
        end
    end
end

-- actual options that every file can use
options.opts = vim.tbl_deep_extend('keep', {}, options.defaultOptions)

-- sets the options after merging with defaults and validating
options.setOptions = function(opts)
    opts = vim.tbl_deep_extend('keep', opts or {}, options.defaultOptions)
    options.validateOptions(opts)
    options.opts = opts
end

return options
