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
    -- limit number of virtual lines. See options table
    goUpLimit = nil,
}

options.validateOptions = function(opts)
    for key, value in pairs(opts) do
        if key == 'mapZZ' then
            checkType(value, 'opts.mapZZ', 'boolean')
        elseif key == 'respectSplitkeep' then
            checkType(value, 'opts.respectSplitkeep', 'boolean')
        elseif key == 'respectScrolloff' then
            checkType(value, 'opts.respectScrolloff', 'boolean')
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
        else
            error('"opts.' .. key .. '" is not a valid option for Go-Up.nvim')
        end
    end
end

options.opts = {}

return options
