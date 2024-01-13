local vim = vim
-- Only required if you have packer configured as `opt`
vim.cmd.packadd("packer.nvim")

-- Example for configuring Neovim to load user-installed installed Lua rocks:
-- don't know what this was for. disabling to see if anything breaks [TODO]: remove
--package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
--package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

return require('packer').startup(function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim' }

    use {
        'theprimeagen/harpoon',
        'mbbill/undotree',
        'tpope/vim-dadbod',
        --'tpope/vim-fugitive',
        'tpope/vim-surround',
        'windwp/nvim-autopairs',
        'preservim/nerdcommenter',
        'goerz/jupytext.vim',
        'Vimjas/vim-python-pep8-indent',
        'aserowy/tmux.nvim',
        'czheo/mojo.vim',
        'quarto-dev/quarto-nvim',
        'jmbuhr/otter.nvim',
    }

    -- color schemes
    use {'sainnhe/gruvbox-material', as = 'gruvbox-material'}

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
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

    -- jupynium
    --use {
        --'kiyoon/jupynium.nvim',
        --run = 'pip3 install --user .'
    --}

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
