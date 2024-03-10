local vim = vim
--local P = { "sainnhe/gruvbox-material" }
local P = { "sainnhe/everforest" }

P.opts = {
    lazy = false,
    priority = 1000
}

function P.config()
    --vim.g.gruvbox_material_background = 'hard'
    vim.g.everforest_background = 'soft'

    --vim.cmd([[colorscheme gruvbox-material]])
    vim.cmd([[colorscheme everforest]])

    -- Transparent background
    -- vim.cmd([[hi normal guibg=NONE]])

end

return P
