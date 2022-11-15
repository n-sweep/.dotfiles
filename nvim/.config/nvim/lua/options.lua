-- Aliases
local opt = vim.opt
local g = vim.g

-- Options
opt.colorcolumn = '80'
opt.completeopt = 'menu'
opt.conceallevel = 0
opt.errorbells = false
opt.expandtab = true
opt.formatoptions:append('q')
opt.hlsearch = false
opt.mouse = ''
opt.number = true
opt.relativenumber = true
opt.scrolloff = 1999
opt.shiftwidth = 4
opt.signcolumn = 'yes'
opt.softtabstop = 4
opt.swapfile = false
opt.tabstop = 4
opt.wrap = false

-- Set Leader
g.mapleader = ' '

-- Undo file
local dir = "/tmp/.vim-undo-dir"
if not vim.fn.isdirectory(dir)
    then vim.fn.mkdir(dir, '', 0700)
end
opt.undodir = dir
opt.undofile = true

-- jupytext settings
g.jupytext_fmt = 'py:percent'

-- magma-nvim settings
g.magma_automatically_open_output = false
g.magma_image_provider = 'ueberzug'

-- Markdown settings
g.vim_markdown_folding_disabled = 1
g.vim_markdown_conceal = 0
g.vim_markdown_conceal_code_blocks = 0
g.vim_markdown_formatter = 1
