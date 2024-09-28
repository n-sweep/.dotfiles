local vim = vim
local keymap = vim.keymap

keymap.set('n', '<leader>dd', ':DBUIToggle<CR>', { desc = 'DBUI Toggle Drawer' })
keymap.set('n', '<leader>da', ':DBUIAddConnection<CR>', { desc = 'DBUI Add New Connection' })
keymap.set('n', '<leader>di', ':DBUILastQueryInfo<CR>', { desc = 'DBUI Last Query Info' })
keymap.set('n', '<leader>dx', ':DBUIClose<CR>', { desc = 'DBUI Close Connection' })
keymap.set('n', '<leader>ds', "<Plug>(DBUI_SaveQuery)", { desc = 'DBUI Save Query' })
keymap.set('n', '<leader>de', "<Plug>(DBUI_EditBindParameters)", { desc = 'DBUI Edit Bind Parameters' })
