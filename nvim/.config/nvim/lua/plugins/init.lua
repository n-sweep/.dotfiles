 local vim = vim

return {

    'czheo/mojo.vim',
    'jmbuhr/otter.nvim',
    'quarto-dev/quarto-nvim',
    'tpope/vim-dadbod',
    'Vimjas/vim-python-pep8-indent',

    { 'n-sweep/telemux-nvim', config = function() require("telemux") end },
    { 'n-sweep/pvserv', config = function() require("pvserv") end },

    { 'kylechui/nvim-surround', config=true },
    { 'windwp/nvim-autopairs', config=true },
    { 'j-hui/fidget.nvim', opts={} },

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

}
