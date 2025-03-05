{ pkgs, ... }: {

  imports = [
    ./cmp.nix
    ./harpoon.nix
    ./lsp.nix
    ./oil.nix
    ./obsidian.nix
    ./telescope.nix
    ./treesitter.nix
    ./undotree.nix
  ];

  plugins = {

    comment.enable = true;
    fidget.enable = true;
    fugitive.enable = true;
    jupytext.enable = true;
    markdown-preview.enable = true;
    nvim-autopairs.enable = true;
    nvim-surround.enable = true;
    otter.enable = true;
    web-devicons.enable = true;
    which-key.enable = true;

    # try later
    # codium-nvim.enable = true;
    # gitignore.enable = true;
    # molten.enable = true;
    # qmk.enable = true;

    lualine = {
      enable = true;
      settings = {
        options.icons_enabled = true;
        sections.lualine_c = [{
            name = "filename";
            extraConfig = { path = 1; };
          }];
      };
    };

  };

  extraPlugins = with pkgs.vimPlugins; [

    quarto-nvim
    tmux-nvim
    vim-dadbod
    vim-dadbod-ui
    vim-dadbod-completion
    vim-python-pep8-indent

    # colorschemes
    gruvbox-nvim
    kanagawa-nvim
    tokyonight-nvim

  ];

  extraFiles = {
    # nvim plugins
    "plugin/colorschemes.lua".source = ./lua/colorschemes.lua;
    "plugin/misc.lua".source = ./lua/misc.lua;
    "plugin/tmux.lua".source = ./lua/tmux.lua;
    "plugin/vim-dadbod.lua".source = ./lua/vim-dadbod.lua;
  };

}
