local lsp = require("lsp-zero")

-- Docstring hover
vim.keymap.set("n", "<leader>k", "<CMD>lua vim.lsp.buf.hover()<CR>")

-- Linting hover
vim.keymap.set("n", "<leader>ee", "<CMD>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "<leader>en", "<CMD>lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "<leader>eN", "<CMD>lua vim.diagnostic.goto_prev()<CR>")

lsp.preset("recommended")
lsp.setup()
