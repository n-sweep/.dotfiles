local P = { "sainnhe/gruvbox-material" }

P.opts = {
    lazy = false,
    priority = 1000
}

function P.init()
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_foreground = 'original'
end

function P.config()
    vim.cmd([[colorscheme gruvbox-material]])

    -- Transparent background
    vim.cmd([[hi normal guibg=NONE]])

end

return P
