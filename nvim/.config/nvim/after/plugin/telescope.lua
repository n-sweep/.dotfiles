-- open file_browser when opening neovim / netrw
require('telescope').setup{
    extensions = {
        file_browser = {
            hijack_netrw = true
        }
    }
}

-- load file_browser after telescope.setup
require('telescope').load_extension 'file_browser'

-- keymappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>n', ':Telescope file_browser path=%:p:h <CR>')
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>gg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>dd', builtin.lsp_definitions, {})
