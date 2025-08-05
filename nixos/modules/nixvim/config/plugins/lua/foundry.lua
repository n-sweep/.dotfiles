local function foundry_startup()

    local foundry = require('foundry')
    foundry.setup({})

    -- keymaps ---------------------------------------------------------------------

    vim.keymap.set({'n', 'v'}, '<leader>fe', foundry.float_cell_output, { buffer = 0 })
    vim.keymap.set({'n', 'v'}, '<leader>fy', foundry.yank_cell_output, { buffer = 0 })
    vim.keymap.set({'n', 'v'}, '<leader>fc', foundry.delete_cell, { buffer = 0 })
    vim.keymap.set({'n', 'v'}, '<leader>fC', foundry.delete_all_cells, { buffer = 0 })

    -- send keys
    -- ctrl + enter runs a cell
    vim.keymap.set({'n', 'v'}, '<F33>', foundry.execute_cell, { buffer = 0 })

    -- shift + enter runs a cell and sends the cursor to the next cell
    vim.keymap.set({'n', 'v'}, '<F34>', function() foundry.execute_cell() foundry.goto_next_cell() end, { buffer = 0 })

    -- shift + tab
    vim.keymap.set('n', '<F31>', foundry.goto_next_cell, { buffer = 0 })

    -- alt + tab
    vim.keymap.set('n', '<F32>', foundry.goto_prev_cell, { buffer = 0 })

end

-- start foundry-nvim when an .ipynb file is opened
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.ipynb',
    callback = foundry_startup
})
