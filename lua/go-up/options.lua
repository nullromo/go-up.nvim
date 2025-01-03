local options = {}

local checkType = function(value, valueName, typeName)
    if type(value) ~= typeName then
        error(valueName .. ' must be a ' .. typeName .. ' for Go-Up.nvim')
    end
end

options.defaultOptions = {
    -- affect the behavior of zz
    mapZZ = true,
}

options.validateOptions = function(opts)
    for key, value in pairs(opts) do
        if key == 'mapZZ' then
            checkType(value, 'opts.mapZZ', 'boolean')
        else
            error('"opts.' .. key .. '" is not a valid option for Go-Up.nvim')
        end
    end
end

return options
