local vim = vim
return {

    'czheo/mojo.vim',
    "folke/which-key.nvim",
    'jmbuhr/otter.nvim',
    'j-hui/fidget.nvim',
    'preservim/nerdcommenter',
    'quarto-dev/quarto-nvim',
    'tpope/vim-dadbod',
    'tpope/vim-surround',
    'Vimjas/vim-python-pep8-indent',

    { 'windwp/nvim-autopairs', config=true },

    {
        'goerz/jupytext.vim',
        init = function()
            vim.g.jupytext_fmt = 'py:percent'
        end
    },

    {
        'mbbill/undotree',
        init = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },

    {
        'tpope/vim-fugitive',
        init = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        opts={ options = {theme = 'gruvbox'} },
    },

}
