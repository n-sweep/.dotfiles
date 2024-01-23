local vim = vim
--local P = { "sainnhe/gruvbox-material" }
local P = { "sainnhe/everforest" }

P.opts = {
    lazy = false,
    priority = 1000
}

function P.init()
    --vim.g.gruvbox_material_background = 'hard'
    vim.g.everforest_background = 'hard'
end

function P.config()
    --vim.cmd([[colorscheme gruvbox-material]])
    vim.cmd([[colorscheme everforest]])

    -- Transparent background
    vim.cmd([[hi normal guibg=NONE]])

end

return P
