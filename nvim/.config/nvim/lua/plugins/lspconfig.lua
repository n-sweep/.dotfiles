local P = {"neovim/nvim-lspconfig"}

P.dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
}

function P.init()
    vim.diagnostic.config({ virtual_text = true })

    -- Docstring hover
    vim.keymap.set("n", "<leader>k", "<CMD>lua vim.lsp.buf.hover()<CR>")

    -- Linting hover
    vim.keymap.set("n", "<leader>ee", "<CMD>lua vim.diagnostic.open_float()<CR>")
    vim.keymap.set("n", "<leader>en", "<CMD>lua vim.diagnostic.goto_next()<CR>")
    vim.keymap.set("n", "<leader>eN", "<CMD>lua vim.diagnostic.goto_prev()<CR>")
end

function P.config()
    local lspconfig = require("lspconfig")
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason").setup({
        lazy = false,
        config = function()
            require("mason").setup({})
        end,
    })

    require("mason-lspconfig").setup({
        -- Replace the language servers listed here
        -- with the ones you want to install
        handlers = {
            function(server)
                 lspconfig[server].setup({ capabilities = lsp_capabilities })
            end,
        }
    })

end

return P
