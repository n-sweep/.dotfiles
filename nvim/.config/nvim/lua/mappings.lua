-- Aliases
local g = vim.g

-- Mapping Functions
function set_keymap(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, {noremap=true})
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

function map(shortcut, command)
    set_keymap('', shortcut, command)
end

-- Quick Write
nmap('<leader>w', ':w<CR>')

-- Quick Copy to Clipboard
vmap('<leader>y', '"+y')

-- Docstring Hover
nmap('<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>')

-- Linting Hover
nmap('<leader>ee', '<cmd>lua vim.diagnostic.open_float()<CR>')
nmap('<leader>en', '<cmd>lua vim.diagnostic.goto_next()<CR>')
nmap('<leader>eN', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

-- Insert new line w/o entering insert mode
nmap('<leader>o', 'o<ESC>')
nmap('<leader>O', 'O<ESC>')

-- Remap ctrl+a because tmux uses it
nmap('<C-c>', '<C-a>')

-- Easier window switching
map('<C-j>', '<C-W>j')
map('<C-k>', '<C-W>k')
map('<C-h>', '<C-W>h')
map('<C-l>', '<C-W>l')

-- Terminal Toggling
nmap('<A-t>', '<CMD>lua require("FTerm").toggle()<CR>')
tmap('<A-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
--tmap('<ESC>', '<C-\\><C-n>')
--imap('<A-t>', '<ESC>:ToggleTerm<CR>')

-- Toggle Start Page
nmap('<leader>a', ':Alpha<CR>')

-- Telescope remapping
nmap('<leader>n', ':Telescope file_browser path=%:p:h <CR>')
nmap('<leader>b', ':Telescope buffers <CR>')
nmap('<leader>ff', ':Telescope find_files <CR>')
nmap('<leader>fg', ':Telescope live_grep <CR>')
nmap('<leader>fh', ':Telescope help_tags <CR>')
nmap('<leader>ld', ':Telescope lsp_definitions <CR>')

-- Jupyter Ascending execute cmd
nmap('<leader>x', '<Plug>JupyterExecute')

-- Black formatting
nmap('<c-q>', '<cmd>call Black()<cr>')
imap('<c-q>', '<cmd>call Black()<cr>')
