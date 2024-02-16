local P = { "nvim-treesitter/nvim-treesitter" }

P.dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
}

P.opts = {
    highlight = { enable = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
    },
    ensure_installed = {
        "vimdoc",
        "bash",
        "python",
        "lua",
        "markdown",
    },
    auto_install = true,
}

function P.config(_, opts)
    require('nvim-treesitter.configs').setup(opts)
end

return P
