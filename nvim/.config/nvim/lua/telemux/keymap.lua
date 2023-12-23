local vim = vim
local M = {}

function M.setup(mod)
    vim.keymap.set('n', '<CR>', function() mod.send_keys(false) end)
    vim.keymap.set('v', '<CR>', function() mod.send_keys(true) end)
end

return M
