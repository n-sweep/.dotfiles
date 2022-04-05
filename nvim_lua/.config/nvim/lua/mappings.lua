-- Aliases
local g = vim.g

-- Mapping Functions
function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, {noremap=true})
end

function nmap(shortcut, command)
    map('n', shortcut, command)
end

function imap(shortcut, command)
    map('i', shortcut, command)
end

function tmap(shortcut, command)
    map('t', shortcut, command)
end

-- Quick Write
nmap('<leader>w', ':w<Enter>')

-- Insert new line w/o entering insert mode
nmap('<leader>o', 'o<ESC>')
nmap('<leader>O', 'O<ESC>')

-- Remap ctrl+a because tmux uses it
nmap('<C-c>', '<C-a>')

-- Terminal Toggling
tmap('<ESC>', '<C-\\><C-n>')
tmap('<A-t>', '<C-\\><C-n>:ToggleTerm<CR>')
nmap('<A-t>', ':ToggleTerm<CR>')
imap('<A-t>', '<ESC>:ToggleTerm<CR>')

-- Toggle Start Page
nmap('<leader>a', ':Alpha<CR>')

-- Toggle netrw
nmap('<leader>n', ':Explore<CR>')

-- Telescope remapping
nmap('<leader>ff', ':Telescope find_files <CR>')
nmap('<leader>fg', ':Telescope live_grep <CR>')
nmap('<leader>fb', ':Telescope buffers <CR>')
nmap('<leader>fh', ':Telescope help_tags <CR>')

