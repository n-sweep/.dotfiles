require('nsweep.plugin')
require('nsweep.set')
require('nsweep.remap')

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local nsweep_group = augroup('nsweep', {})
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- remove trailing whitespace on save
autocmd({"BufWritePre"}, {
    group = nsweep_group,
    pattern = "*",
    callback = function()
        if vim.bo.filetype ~= 'markdown' then
            vim.cmd([[%s/\s\+$//e]])
        end
    end
})
