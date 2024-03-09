local vim = vim
local select_opts = select_opts
local P = { "hrsh7th/nvim-cmp" }

P.dependencies = {
    -- sources
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",

    -- Snippets
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
}

P.event = "InsertEnter"

function P.config()
    vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

    local cmp = require('cmp')
    local luasnip = require('luasnip')

    cmp.setup({

        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end
        },

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

        mapping = {
            ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
            ['<Down>'] = cmp.mapping.select_next_item(select_opts),

            ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
            ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),

            ['<C-e>'] = cmp.mapping.abort(),
            ['<C-y>'] = cmp.mapping.confirm({select = true}),
            ['<CR>'] = cmp.mapping.confirm({select = false}),

            ['<C-f>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, {'i', 's'}),

            ['<C-b>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {'i', 's'}),

            ['<Tab>'] = cmp.mapping(function(fallback)
                local col = vim.fn.col('.') - 1

                if cmp.visible() then
                    cmp.select_next_item(select_opts)
                elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                    fallback()
                else
                    cmp.complete()
                end
            end, {'i', 's'}),

            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item(select_opts)
                else
                    fallback()
                end
            end, {'i', 's'}),
        },

    })

end

return P
