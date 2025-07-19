local tmux = require("tmux")

-- vim & tmux split navigation
vim.keymap.set("n", "<M-h>", function() tmux.move_left() end)
vim.keymap.set("n", "<M-j>", function() tmux.move_bottom() end)
vim.keymap.set("n", "<M-k>", function() tmux.move_top() end)
vim.keymap.set("n", "<M-l>", function() tmux.move_right() end)

-- vim & tmux split resizing
vim.keymap.set("n", "<C-M-h>", function() tmux.resize_left() end)
vim.keymap.set("n", "<C-M-j>", function() tmux.resize_bottom() end)
vim.keymap.set("n", "<C-M-k>", function() tmux.resize_top() end)
vim.keymap.set("n", "<C-M-l>", function() tmux.resize_right() end)

-- vim & tmux split swapping
vim.keymap.set("n", "<S-M-h>", function() tmux.swap_left() end)
vim.keymap.set("n", "<S-M-j>", function() tmux.swap_bottom() end)
vim.keymap.set("n", "<S-M-k>", function() tmux.swap_top() end)
vim.keymap.set("n", "<S-M-l>", function() tmux.swap_right() end)

tmux.setup({
    copy_sync = {enable = false},
    navigation = {
        cycle_navigation = true,
        enable_default_keybindings = false,
    },
    resize = {enable_default_keybindings = false},
    swap = {enable_default_keybindings = false},
})
