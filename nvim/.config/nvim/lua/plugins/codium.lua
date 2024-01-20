local vim = vim
local P = { "Exafunction/codeium.vim" }

function P.init()
    vim.g.codium_enabled = false
    vim.g.codium_no_map_tab = 1
end

function P.config()
    vim.keymap.set(
        'i',
        '<M-Bslash>',
        function()
            return vim.fn['codeium#Accept']()
        end,
        { expr = true , silent = true }
    )
end

return P
