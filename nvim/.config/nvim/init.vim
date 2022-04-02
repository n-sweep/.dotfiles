# here is a test
set number
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set timeoutlen=1000 ttimeoutlen=0
set smartindent
set autoindent
set nohlsearch
set incsearch
" set hidden
set noerrorbells
set nowrap
set noswapfile
set scrolloff=19
set completeopt=menuone,noinsert,noselect
set termguicolors
set signcolumn=yes
set colorcolumn=85
set foldlevel=99
set foldnestmax=2

" Change python indenting defaults
"let g:pyindent_open_paren = 0
"let g:pyindent_nested_paren = 0

" Install vim-plug
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
call plug#begin('~/.vim/plugged')

    " Telescope requires neovim 0.5+
    " sudo add-apt-repository ppa:neovim-ppa/unstable
    " sudo apt-get update
    " sudo apt-get install neovim
    Plug 'nvim-telescope/telescope.nvim'

    " pip install jedi pynvim
    Plug 'davidhalter/jedi-vim'
    Plug 'deoplete-plugins/deoplete-jedi'
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}

    Plug 'preservim/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tmhedberg/SimpylFold'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'gruvbox-community/gruvbox'

    let g:deoplete#enable_at_startup = 1

call plug#end()

colorscheme gruvbox

let mapleader = " "

" Tab scrolls autocomplete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Remap ctrl+a because tmux uses it
nnoremap <C-c> <C-a>

" Quick Write
nnoremap <leader>w :w<Enter>

" Insert new line without entering insert mode
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

" Tab switching
nnoremap <leader>tt :tabnew<Enter>
nnoremap <leader>tn gt
nnoremap <leader>tl gT

" Vim style window switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" NERDTree maps
nnoremap <leader>no :NERDTree<Space>
nnoremap <leader>nn :NERDTreeToggle<cr>
nnoremap <leader>nf :NERDTreeFocus<cr>
nnoremap <leader>ns :NERDTreeFind<cr>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>
nnoremap <leader>fu <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Shift + J/K moves selected lines down/up in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ESC to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal Function
" thanks u/andreyorst
" https://www.reddit.com/r/vim/comments/8n5bzs/using_neovim_is_there_a_way_to_display_a_terminal/
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

