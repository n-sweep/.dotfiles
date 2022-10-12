require('plugins')
require('options')
require('mappings')
require('lsp')
require('completion')

-- Set Color Scheme
vim.cmd[[colorscheme gruvbox]]

-- Remove trailing whitespace in py files
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.py',
    command = ':%s/\\s\\+$//e'
})

-- Screen tearing fix (?)
vim.api.nvim_command('autocmd BufEnter * highlight Normal guibg=0')
