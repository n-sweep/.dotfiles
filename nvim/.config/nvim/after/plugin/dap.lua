local vim = vim
local dap = require('dap')
local dapui = require('dapui')
local dap_vt = require('nvim-dap-virtual-text')
local dap_python = require('dap-python')

vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F9>', function() dap.step_into() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_out() end)
vim.keymap.set('n', '<F12>', function() dap.terminate() end)
vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint('Breakpoint Condition: ') end)
vim.keymap.set('n', '<leader>du', function() dapui.toggle() end)

-- I need <leader>l
-- maybe this plugin just needs removed, I don't use it.
--vim.keymap.set('n', '<leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log Point Message: ')) end)

dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end

dapui.setup()
dap_vt.setup()
dap_python.setup()
