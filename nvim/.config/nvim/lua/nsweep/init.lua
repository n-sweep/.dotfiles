require('nsweep.plugin')
require('nsweep.set')
require('nsweep.remap')

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local nsweep_group = augroup('nsweep', {})
local center_group = augroup('center', {})
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

-- keep cursor centered at bottom of file
-- removed for now - doesn't retain the column position of cursor due to the
-- zz command call

--autocmd({"CursorMoved", "CursorMovedI", "WinScrolled"}, {
    --group = center_group,
    --pattern = "*",
    --callback = function()
        --local pos = vim.api.nvim_win_get_cursor(0)
        --vim.cmd([[:normal zz]])
        --vim.api.nvim_win_set_cursor(0,pos)
    --end
--})
