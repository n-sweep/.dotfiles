local vim = vim
return {

    'czheo/mojo.vim',
    "Exafunction/codeium.vim",
    "folke/which-key.nvim",
    'jmbuhr/otter.nvim',
    'j-hui/fidget.nvim',
    'preservim/nerdcommenter',
    'quarto-dev/quarto-nvim',
    'tpope/vim-dadbod',
    'Vimjas/vim-python-pep8-indent',

    { 'kylechui/nvim-surround', config=true },
    { 'windwp/nvim-autopairs', config=true },
    {
        'GCBallesteros/jupytext.nvim',
        opts = { output_exten = 'light' }
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
