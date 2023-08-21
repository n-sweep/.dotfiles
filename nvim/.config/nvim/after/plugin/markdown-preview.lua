local vim = vim
local g = vim.g

g.vim_markdown_folding_disabled = 1
g.vim_markdown_conceal = 0
g.vim_markdown_conceal_code_blocks = 0
g.vim_markdown_formatter = 1

g.mkdp_auto_start=1
g.mkdp_auto_close=0

vim.keymap.set('n', '<leader>mp', ":MarkdownPreview<CR>")
