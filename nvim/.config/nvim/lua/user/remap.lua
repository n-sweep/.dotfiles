local vim = vim
local km = vim.keymap

-- Quick write
km.set("n", "<leader>w", ":w<CR>")

-- Quick quitting
km.set("n", "<leader>qq", ":q<CR>")
km.set("n", "<leader>qQ", ":qa<CR>")
km.set("n", "<leader>QQ", ":qa!<CR>")

-- Insert new line w/o entering insert mode
km.set("n", "<leader>o", "o<ESC>")
km.set("n", "<leader>O", "O<ESC>")

-- Copy to system clipboard
km.set("n", "<leader>y", '"+y')
km.set("v", "<leader>y", '"+y')
km.set("n", "<leader>Y", '"+Y')

-- Paste from system clipboard
km.set("n", "<leader>v", '"+p')
km.set("v", "<leader>v", '"+p')
km.set("n", "<leader>V", '"+P')
km.set("v", "<leader>V", '"+P')

-- Paste over selection w/o yanking
km.set("x", "<leader>p", '"_dP')

-- esc in normal mode turns of hl
km.set('n', '<ESC>', ':nohl<CR>')

-- Toggle linebreak & wrap
km.set('n', '<F6>', ':set wrap! linebreak!<CR>')

-- Toggle spell check
km.set('n', '<F7>', ':set spell!<CR>')

-- ctrl/shift/alt + enter/tab shouldn't do anything in insert mode
-- unless explicitly remapped later
km.set('i', '<F30>', function() end)
km.set('i', '<F31>', function() end)
km.set('i', '<F32>', function() end)
km.set('i', '<F33>', function() end)
km.set('i', '<F34>', function() end)
km.set('i', '<F35>', function() end)
