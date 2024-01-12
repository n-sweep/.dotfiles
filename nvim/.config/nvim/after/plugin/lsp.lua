local vim = vim
local lsp = require("lsp-zero")
local cmp = require("cmp")
local cmp_action = lsp.cmp_action()

lsp.on_attach(function(client, bufnr)
    local opts = { buffer=bufnr, remap=false }

    -- Docstring hover
    vim.keymap.set("n", "<leader>k", "<CMD>lua vim.lsp.buf.hover()<CR>")

    -- Linting hover
    vim.keymap.set("n", "<leader>ee", "<CMD>lua vim.diagnostic.open_float()<CR>")
    vim.keymap.set("n", "<leader>en", "<CMD>lua vim.diagnostic.goto_next()<CR>")
    vim.keymap.set("n", "<leader>eN", "<CMD>lua vim.diagnostic.goto_prev()<CR>")
end)

--local cmp_mappings = lsp.defaults.cmp_mappings({
    ---- Scroll docs
    --['<C-u>'] = cmp.mapping.scroll_docs(-4),
    --['<C-d>'] = cmp.mapping.scroll_docs(4),

    ---- Tab scrolls autocomplete options
    --["<Tab>"] = cmp.mapping(function(fallback)
        --if cmp.visible() then
            --cmp.select_next_item()
        --elseif has_words_before() then
            --cmp.complete()
        --else
            ---- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            --fallback()
        --end
    --end, { "i", "s" }),

    --["<S-Tab>"] = cmp.mapping(function()
        --if cmp.visible() then
            --cmp.select_prev_item()
        --elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            --vim.fn.feedkey("<Plug>(vsnip-jump-prev)", "")
        --end
    --end, { "i", "s" })
--})

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = { 'jedi_language_server' },
    handlers = { lsp.default_setup }
})

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "otter" },
        { name = "buffer" },
        { name = "treesitter" },
        { name = "calc" },
        { name = "latex_symbols" },
        { name = "spell" },
        { name = "luasnip" },
    },
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
})

-- not sure what this does
vim.diagnostic.config({ virtual_text = true })
