local vim = vim
-- Only required if you have packer configured as `opt`
vim.cmd.packadd("packer.nvim")

return require('packer').startup(function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim' }

    use {
        'theprimeagen/harpoon',
        'mbbill/undotree',
        'tpope/vim-fugitive',
        'tpope/vim-surround',
        'windwp/nvim-autopairs',
        'Yggdroot/indentLine',
        'numToStr/FTerm.nvim',
        'preservim/nerdcommenter',
        'goerz/jupytext.vim',
        'untitled-ai/jupyter_ascending.vim',
        'averms/black-nvim',
        'Vimjas/vim-python-pep8-indent',
        'aserowy/tmux.nvim',
    }

    -- color schemes
    use {'gruvbox-community/gruvbox', as = 'gruvbox'}
    use {'sainnhe/gruvbox-material', as = 'gruvbox-material'}
    use {'sainnhe/everforest', as = 'everforest'}
    use {'Mofiqul/dracula.nvim', as = 'dracula'}
    use {'jnurmine/Zenburn', as = 'zenburn'}
    use {'shaunsingh/nord.nvim', as = 'nord'}

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = {
            'nvim-telescope/telescope-file-browser.nvim',
            'nvim-lua/plenary.nvim'
        }
    }

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update(
            { with_sync = true }
            ) end
    }

    -- LSP Zero
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
        }
    }

    -- dap
    use {
        'mfussenegger/nvim-dap',
        requires = {
            'rcarriga/nvim-dap-ui',
            'mfussenegger/nvim-dap-python',
            'theHamsta/nvim-dap-virtual-text',
            'nvim-telescope/telescope-dap.nvim'
        }
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

    -- LuaLine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- md previewer
    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }

end)
