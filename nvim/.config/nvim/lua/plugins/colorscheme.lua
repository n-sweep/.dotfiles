local vim = vim
local P = {
    -- colorschemes
    -- "sainnhe/everforest",
    -- "sainnhe/gruvbox-material",
    "rebelot/kanagawa.nvim",
    -- "mellow-theme/mellow.nvim",
    -- "sebasruiz09/fizz.nvim",
    -- "AlexvZyl/nordic.nvim",
    -- "ribru17/bamboo.nvim",
}

function P.config()
    -- default color scheme
    vim.cmd([[colorscheme kanagawa]])
    -- Transparent background
    -- vim.cmd([[hi normal guibg=NONE]])
end

return P
