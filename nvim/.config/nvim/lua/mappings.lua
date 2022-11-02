-- Aliases
local g = vim.g

-- Mapping Functions
function set_keymap(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, {noremap=true})
end

function set_keymap_expr(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, {expr=true, noremap=true})
end

function nmap_expr(shortcut, command)
    set_keymap_expr('n', shortcut, command)
end

function nmap(shortcut, command)
    set_keymap('n', shortcut, command)
end

function imap(shortcut, command)
    set_keymap('i', shortcut, command)
end

function tmap(shortcut, command)
    set_keymap('t', shortcut, command)
end

function vmap(shortcut, command)
    set_keymap('v', shortcut, command)
end

function xmap(shortcut, command)
    set_keymap('x', shortcut, command)
end

function map(shortcut, command)
    set_keymap('', shortcut, command)
end

-- Quick write
nmap('<leader>w', ':w<CR>')

-- Paste over selection w/o yanking
xmap('<leader>p', '"_dP')

-- Copy to system clipboard
nmap('<leader>y', '"+y')
vmap('<leader>y', '"+y')
nmap('<leader>Y', '"+Y')

-- Paste from system clipboard
nmap('<leader>v', '"+p')
vmap('<leader>v', '"+p')
nmap('<leader>V', '"+P')
vmap('<leader>V', '"+P')

-- Delete w/o yanking
nmap('<leader>d', '"_d')
vmap('<leader>d', '"_d')

-- Docstring hover
nmap('<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>')

-- Linting hover
nmap('<leader>ee', '<cmd>lua vim.diagnostic.open_float()<CR>')
nmap('<leader>en', '<cmd>lua vim.diagnostic.goto_next()<CR>')
nmap('<leader>eN', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

-- Insert new line w/o entering insert mode
nmap('<leader>o', 'o<ESC>')
nmap('<leader>O', 'O<ESC>')

-- Remap ctrl+a because tmux uses it
-- I remapped tmux to ctrl+space but I'm still using this for some reason
nmap('<C-c>', '<C-a>')

-- Easier window switching
map('<C-j>', '<C-W>j')
map('<C-k>', '<C-W>k')
map('<C-h>', '<C-W>h')
map('<C-l>', '<C-W>l')

-- Terminal toggling
nmap('<A-t>', '<CMD>lua require("FTerm").toggle()<CR>')
tmap('<A-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- Telescope remapping
nmap('<leader>n', ':Telescope file_browser path=%:p:h <CR>')
nmap('<leader>b', ':Telescope buffers <CR>')
nmap('<leader>ff', ':Telescope find_files <CR>')
nmap('<leader>fg', ':Telescope live_grep <CR>')
nmap('<leader>fh', ':Telescope help_tags <CR>')
nmap('<leader>ld', ':Telescope lsp_definitions <CR>')

-- Jupyter Ascending execute cmd
nmap('<leader>x', '<Plug>JupyterExecute')

-- Settings for magma-nvim
nmap('<leader>mi', ':MagmaInit python<CR>')
nmap('<leader>mr', ':MagmaRestart<CR>')
xmap('<leader>r', ':<C-u>MagmaEvaluateVisual<CR>')
nmap('<leader>rr', ':MagmaEvaluateLine<CR>')
nmap('<leader>rp', 'vip:<C-u>MagmaEvaluateVisual<CR>')
nmap('<leader>rx', ':MagmaReevaluateCell<CR>')
nmap('<leader>ro', ':MagmaShowOutput<CR>')
nmap('<leader>rd', ':MagmaDelete<CR>')
nmap('<leader>rq', ':noautocmd MagmaEnterOutput<CR>')

-- Black formatting
nmap('<c-q>', '<cmd>call Black()<cr>')
imap('<c-q>', '<cmd>call Black()<cr>')
