local vim = vim

require('telescope').setup{
    defaults = { sorting_strategy = 'ascending'},
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
local function ffh() builtin.find_files({hidden=true}) end

vim.keymap.set('n', '<leader>ff', ffh, {})  -- I hate that you have to do this
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>gg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>dd', builtin.lsp_definitions, {})

vim.keymap.set('n', '<leader>n', ':Telescope file_browser path=%:p:h <CR>')
vim.keymap.set('n', '<leader>ft', ":Telescope find_files hidden=true<CR>")
