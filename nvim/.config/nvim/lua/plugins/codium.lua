local vim = vim
local P = { "Exafunction/codeium.vim" }

function P.init()
    vim.g.codeium_enabled = false
    vim.g.codeium_no_map_tab = 1
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
