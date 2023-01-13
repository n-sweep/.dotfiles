local vim = vim
local tmux = require("tmux")

vim.keymap.set("n", "<A-h>", function() tmux.move_left() end)
vim.keymap.set("n", "<A-j>", function() tmux.move_bottom() end)
vim.keymap.set("n", "<A-k>", function() tmux.move_top() end)
vim.keymap.set("n", "<A-l>", function() tmux.move_right() end)

vim.keymap.set("n", "<C-A-h>", function() tmux.resize_left() end)
vim.keymap.set("n", "<C-A-j>", function() tmux.resize_bottom() end)
vim.keymap.set("n", "<C-A-k>", function() tmux.resize_top() end)
vim.keymap.set("n", "<C-A-l>", function() tmux.resize_right() end)

tmux.setup({
    copy_sync = {enable = false},
    navigation = {
        cycle_navigation = true,
        enable_default_keybindings = false,
    },
    resize = {enable_default_keybindings = false},
})
