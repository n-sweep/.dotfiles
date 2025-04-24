local vim = vim
local M = {}

function M.setup()
    local to_load = { 'molten_overlay.module' }

    -- load all dependencies in `to_load` into the module
    for _, tbl in ipairs(to_load) do
        local t = require(tbl)
        for k, v in pairs(t) do
            M[k] = v
        end
    end

    require('keymaps').setup(M)
end
