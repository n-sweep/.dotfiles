require('packer').startup(function()
    -- General
    use {
        'wbthomason/packer.nvim',
        'windwp/nvim-autopairs',
        'tpope/vim-surround',
        'Vimjas/vim-python-pep8-indent',
        'Yggdroot/indentLine',
        'numToStr/FTerm.nvim',
        'preservim/nerdcommenter',
        'goerz/jupytext.vim',
        'averms/black-nvim'
    }

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update(
            { with_sync = true }
        ) end
    }

    -- magma-nvim
    use {
        'dccsillag/magma-nvim',
        run = ':UpdateRemotePlugins'
    }

    -- FireNvim
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            -- apt-get install ripgrep
            'BurntSushi/ripgrep'
        }
    }
    use { "nvim-telescope/telescope-file-browser.nvim" }

    -- Completion
    use {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer'
    }

    -- LuaLine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- color schemes
    use {
        'gruvbox-community/gruvbox',
        'Mofiqul/dracula.nvim'
    }
end)

require('nvim-treesitter.configs').setup{
  -- A list of parser names, or "all"
  ensure_installed = { "python", "lua" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    --disable = function(lang, buf)
        --local max_filesize = 100 * 1024 -- 100 KB
        --local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --if ok and stats and stats.size > max_filesize then
            --return true
        --end
    --end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require('telescope').setup{
    extensions = {
        file_browser = {
            hijack_netrw = true,
        }
    }
}
require('telescope').load_extension 'file_browser'
require('nvim-autopairs').setup{}
require('lualine').setup{
    options = {
        theme = 'gruvbox'
    }
}
