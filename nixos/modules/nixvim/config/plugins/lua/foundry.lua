local function func()

    local foundry = require('foundry')
    foundry.setup({})

    -- keymaps ---------------------------------------------------------------------

    vim.api.nvim_set_keymap('n', '<leader>fo', foundry.open_cell, { buffer = 0,
        desc = 'Foundry open output of cell under cursor in a floating window'
    })
    vim.api.nvim_set_keymap('n', '<leader>fy', foundry.yank_cell_output, { buffer = 0,
        desc = 'Foundry yank cell output contents'
    })
    vim.api.nvim_set_keymap('n', '<leader>fY', foundry.yank_cell_input, { buffer = 0,
        desc = 'Foundry yank cell input contents'
    })
    vim.api.nvim_set_keymap('n', '<leader>fc', foundry.delete_cell, { buffer = 0,
        desc = 'Foundry delete virtual text of cell under cursor'
    })
    vim.api.nvim_set_keymap('n', '<leader>fC', foundry.delete_all_cells, { buffer = 0,
        desc = 'Foundry delete virtual text of all cells in notebook'
    })

    -- send keys
    -- ctrl + enter runs a cell
    vim.api.nvim_set_keymap({'n', 'v'}, '<F33>', foundry.execute_cell, { buffer = 0,
        desc = 'Foundry execute the current cell'
    })

    -- shift + enter runs a cell and sends the cursor to the next cell
    vim.api.nvim_set_keymap({'n', 'v'}, '<F34>', function() foundry.execute_cell() foundry.goto_next_cell() end, { buffer = 0,
        desc = 'Foundry execute the current cell and move cursor to the next'
    })

    -- shift + tab
    vim.api.nvim_set_keymap('n', '<F31>', foundry.goto_next_cell, { buffer = 0,
        desc = 'Foundry move cursor to next cell'
    })

    -- alt + tab
    vim.api.nvim_set_keymap('n', '<F32>', foundry.goto_prev_cell, { buffer = 0,
        desc = 'Foundry move cursor to previous cell'
    })

end

-- start foundry-nvim when an .ipynb file is opened
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.ipynb',
    callback = func
})
