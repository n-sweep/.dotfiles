local P = { 'theprimeagen/harpoon' }

function P.init()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>a", mark.add_file)
    vim.keymap.set("n", "<C-f>", ui.toggle_quick_menu)

    for i = 0, 9, 1 do
        vim.keymap.set("n", "<leader>" .. i, function() ui.nav_file(i) end)
    end
end

return P
