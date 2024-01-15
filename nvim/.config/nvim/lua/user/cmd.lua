local autocmd = vim.api.nvim_create_autocmd

-- momentarily highlight yanked text
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
