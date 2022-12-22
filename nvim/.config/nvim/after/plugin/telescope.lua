require('telescope').load_extension 'file_browser'
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>n', ':Telescope file_browser path=%:p:h <CR>')
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>gg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, {})
