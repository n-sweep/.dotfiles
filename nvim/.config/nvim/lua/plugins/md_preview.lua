P = { "iamcco/markdown-preview.nvim" }

function P.run()
    vim.fn["mkdp#util#install"]()
end

function P.config()
    vim.g.vim_markdown_folding_disabled = 1
    vim.g.vim_markdown_conceal = 0
    vim.g.vim_markdown_conceal_code_blocks = 0
    vim.g.vim_markdown_formatter = 1

    vim.g.mkdp_auto_start=1
    vim.g.mkdp_auto_close=0

    vim.keymap.set('n', '<leader>mp', ":MarkdownPreview<CR>")
end

return P
