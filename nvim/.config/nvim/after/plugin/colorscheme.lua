local vim = vim

vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_foreground = 'original'

vim.g.everforest_material_background = 'hard'

vim.cmd([[:colorscheme gruvbox-material]])
--vim.cmd([[:colorscheme everforest]])

-- Transparent background
vim.cmd([[hi normal guibg=NONE]])
