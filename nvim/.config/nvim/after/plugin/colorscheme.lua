local vim = vim

vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_foreground = 'original'

vim.cmd([[:colorscheme gruvbox-material]])
--vim.cmd([[:colorscheme everforest]])

-- Transparent background
vim.cmd([[hi normal guibg=NONE]])
