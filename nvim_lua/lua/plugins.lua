require('packer').startup(function()
    -- General
    use {
        'wbthomason/packer.nvim',
        'windwp/nvim-autopairs',
        'tpope/vim-surround',
        'Yggdroot/indentLine',
        'akinsho/toggleterm.nvim',
        'preservim/nerdcommenter'
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

    -- Alpha welcome screen
    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require('alpha').setup(require('alpha.themes.startify').config)
        end
    }

    -- Completion
    use {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/nvim-cmp',
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer'
    }

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

require('nvim-autopairs').setup{}
require('lualine').setup{
    options = {
        theme = 'gruvbox'
    }
}
