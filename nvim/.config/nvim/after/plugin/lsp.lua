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

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = { 'pylsp' },
    handlers = {
        lsp.default_setup,
        pylsp = function()
            require('lspconfig').pylsp.setup({
                capabilities = require('cmp_nvim_lsp').default_capabilities(
                    vim.lsp.protocol.make_client_capabilities()
                )
            })
        end
    }
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
    formatting = lsp.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        -- supa tab
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),


        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
})
lsp.setup()

vim.diagnostic.config({ virtual_text = true })
