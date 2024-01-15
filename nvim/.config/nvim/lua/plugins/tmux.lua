P = { "aserowy/tmux.nvim" }

function P.init()
    tmux = require("tmux")
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
end

function P.config()
    require('tmux').setup({
        copy_sync = {enable = false},
        navigation = {
            cycle_navigation = true,
            enable_default_keybindings = false,
        },
        resize = {enable_default_keybindings = false},
    })
end

return P
