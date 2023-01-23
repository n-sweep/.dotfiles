local vim = vim

-- Quick write
vim.keymap.set("n", "<leader>w", vim.cmd.w)

-- Quick quitting
vim.keymap.set("n", "<leader>qq", ":qa<CR>")
vim.keymap.set("n", "<leader>QQ", ":qa!<CR>")

-- Insert new line w/o entering insert mode
vim.keymap.set("n", "<leader>o", "o<ESC>")
vim.keymap.set("n", "<leader>O", "O<ESC>")

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Paste from system clipboard
vim.keymap.set("n", "<leader>v", '"+p')
vim.keymap.set("v", "<leader>v", '"+p')
vim.keymap.set("n", "<leader>V", '"+P')
vim.keymap.set("v", "<leader>V", '"+P')

-- Paste over selection w/o yanking
vim.keymap.set("x", "<leader>p", '"_dP')

-- Delete w/o yanking
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Move highlighted lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
