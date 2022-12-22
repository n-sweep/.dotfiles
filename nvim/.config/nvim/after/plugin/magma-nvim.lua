vim.g.magma_automatically_open_output = false
vim.g.magma_image_provider = 'ueberzug'

vim.keymap.set("n", '<leader>mi', ':MagmaInit python<CR>')
vim.keymap.set("n", '<leader>mr', ':MagmaRestart<CR>')
vim.keymap.set("x", '<leader>r', ':<C-u>MagmaEvaluateVisual<CR>')
vim.keymap.set("n", '<leader>rr', ':MagmaEvaluateLine<CR>')
vim.keymap.set("n", '<leader>rp', 'vip:<C-u>MagmaEvaluateVisual<CR>')
vim.keymap.set("n", '<leader>rx', ':MagmaReevaluateCell<CR>')
vim.keymap.set("n", '<leader>ro', ':MagmaShowOutput<CR>')
vim.keymap.set("n", '<leader>rd', ':MagmaDelete<CR>')
vim.keymap.set("n", '<leader>rq', ':noautocmd MagmaEnterOutput<CR>')
