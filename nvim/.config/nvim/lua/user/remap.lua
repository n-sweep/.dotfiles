local vim = vim
local keymap = vim.keymap

-- Quick write
keymap.set("n", "<leader>w", ":w<CR>")

-- Quick quitting
keymap.set("n", "<leader>qq", ":q<CR>")
keymap.set("n", "<leader>qQ", ":qa<CR>")
keymap.set("n", "<leader>QQ", ":qa!<CR>")

-- Insert new line w/o entering insert mode
keymap.set("n", "<leader>o", "o<ESC>")
keymap.set("n", "<leader>O", "O<ESC>")

-- Copy to system clipboard
keymap.set("n", "<leader>y", '"+y')
keymap.set("v", "<leader>y", '"+y')
keymap.set("n", "<leader>Y", '"+Y')

-- Paste from system clipboard
keymap.set("n", "<leader>v", '"+p')
keymap.set("v", "<leader>v", '"+p')
keymap.set("n", "<leader>V", '"+P')
keymap.set("v", "<leader>V", '"+P')

-- Paste over selection w/o yanking
keymap.set("x", "<leader>p", '"_dP')

-- Toggle linebreak & wrap
keymap.set('n', '<leader>sw', ':set wrap! linebreak!<CR>')

-- esc in normal mode turns of hl
keymap.set('n', '<ESC>', ':nohl<CR>')

-- ctrl/shift + enter
keymap.set('n', '\\E[20;5~', ':echo hello<CR>')
keymap.set('n', '\\E[21;5~', ':echo goodbyeCR>')
