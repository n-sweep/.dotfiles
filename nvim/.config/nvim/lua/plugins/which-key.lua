local vim = vim
local P = { "folke/which-key.nvim" }

P.event = "VeryLazy"
P.opts = {}

function P.init()
    vim.o.timeout = true
    vim.o.timeoutlen = 1200
end

return P
