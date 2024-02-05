local vim = vim
local P = {'nvim-telescope/telescope.nvim'}

P.dependencies = {
    'nvim-lua/plenary.nvim',
    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
}

P.cmd = {'Telescope'}

P.defaults = { sorting_strategy = 'ascending'}

function P.init()
    vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>")
    vim.keymap.set('n', '<leader>ft', ":Telescope find_files hidden=true<CR>")
    vim.keymap.set('n', '<leader>fb', ":Telescope buffers<CR>")
    vim.keymap.set('n', '<leader>fg', ":Telescope live_grep<CR>")
    vim.keymap.set('n', '<leader>fc', ":Telescope commands<CR>")
    vim.keymap.set('n', '<leader>fC', ":Telescope command_history<CR>")
    vim.keymap.set('n', '<leader>fh', ":Telescope help_tags<CR>")
    vim.keymap.set('n', '<leader>gg', ":Telescope git_files<CR>")
    vim.keymap.set('n', '<leader>ld', ":Telescope lsp_definitions<CR>")
end

function P.config()
    -- load file_browser after telescope.setup
    require('telescope').load_extension('fzf')
end

return P
