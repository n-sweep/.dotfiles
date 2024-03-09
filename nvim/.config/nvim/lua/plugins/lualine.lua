local P = { 'nvim-lualine/lualine.nvim' }

P.requires = { 'kyazdani42/nvim-web-devicons', opt = true }

P.opts = {
    options = { theme = 'everforest' },
    sections = {
        lualine_c = {{ 'filename', path = 1 }}
    }
}

return P
