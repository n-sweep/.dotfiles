local vim = vim
local dap = require('dap')
local dapui = require('dapui')
local dap_vt = require('nvim-dap-virtual-text')
local dap_python = require('dap-python')

vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F3>', function() dap.step_into() end)
vim.keymap.set('n', '<F4>', function() dap.step_over() end)
vim.keymap.set('n', '<F6>', function() dap.step_out() end)
vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint('Breakpoint Condition: ') end)
vim.keymap.set('n', '<leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log Point Message: ')) end)
vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end)

dapui.setup()
dap_vt.setup()
dap_python.setup()
