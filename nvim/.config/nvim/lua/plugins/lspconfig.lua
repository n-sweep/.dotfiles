local P = {"neovim/nvim-lspconfig"}
local user = {}

P.dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
}

function P.init()
    vim.diagnostic.config({ virtual_text = true })
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
        ensure_installed = {
            "pylsp",
            "lua_ls",
        },
        handlers = {
            function(server)
                 lspconfig[server].setup({ capabilities = lsp_capabilities })
            end,
        }
    })

end

return P
