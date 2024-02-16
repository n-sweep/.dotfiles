local vim = vim

-- Quick write
vim.keymap.set("n", "<leader>w", vim.cmd.w)

-- Quick quitting
vim.keymap.set("n", "<leader>qq", ":q<CR>")
vim.keymap.set("n", "<leader>qQ", ":qa<CR>")
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

-- Toggle linebreak & wrap
vim.keymap.set('n', '<leader>sw', ':set wrap! linebreak!<CR>')

-- esc in normal mode turns of hl
vim.keymap.set('n', '<ESC>', ':nohl<CR>')
