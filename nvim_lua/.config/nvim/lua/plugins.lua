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

    -- Alpha welcome screen
    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            local alpha = require'alpha'
            local startify = require'alpha.themes.startify'
            startify.section.header.val = {
                [[        _  _                                                                                             ]],
                [[     .-" || "-.                                                                                          ]],
                [[   .'   _||_   `.    ,-----.,--.                        ,--.,--.                                    ,--. ]],
                [[  |   .'    `.___|  '  .--./|  | ,---.  ,---.  ,---.  ,-|  ||  |    ,---.  ,---.  ,---.      ,--,--.`--' ]],
                [[  |   |       ___   |  |    |  || .-. |(  .-' | .-. :' .-. ||  |   | .-. || .-. || .-. |    ' ,-.  |,--. ]],
                [[  |   `.____.'   |  '  '--'\|  |' '-' '.-'  `)\   --.\ `-' ||  '--.' '-' '' '-' '| '-' '.--.\ '-'  ||  | ]],
                [[   `.          .'    `-----'`--' `---' `----'  `----' `---' `-----' `---'  `---' |  |-' '--' `--`--'`--' ]],
                [[     `-.____.-'                                                                  `--'                    ]]
            }
            alpha.setup(startify.config)
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

require('nvim-autopairs').setup{}
require('toggleterm').setup{}
require('lualine').setup{
    options = {
        theme = 'gruvbox'
    }
}
