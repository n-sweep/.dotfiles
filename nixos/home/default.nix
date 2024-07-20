# $man home-configuration.nix
{ config, pkgs, inputs, ...}:
let

  dfPath = "${config.home.homeDirectory}/.dotfiles";

in {

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home ={
    username = "n";
    homeDirectory = "/home/n";

    # source files to home directory
    file = {
      ".bash_aliases".source = "${dfPath}/bash/.bash_aliases";
      ".config/i3/config".source = "${dfPath}/i3/.config/i3/config";
      ".config/i3status/config".source = "${dfPath}/i3/.config/i3status/config";
      ".inputrc".source = "${dfPath}/bash/.inputrc";
      ".wezterm.lua".source = "${dfPath}/wezterm/.wezterm.lua";

      # these plugins crash OBS. missing dependency?
      # ".vst".source = "${pkgs.reaper}/opt/REAPER/Plugins/";

      # jupytext.nvim repo
      ".config/nvim/pack/vendor/start/jupytext".source = (pkgs.fetchgit {
        url = "https://github.com/GCBallesteros/jupytext.nvim";
        hash = "sha256-x5emW+qfUTUDR72B9QdDgVdrb8wGH9D7AdtRrQm80sI=";
      });

      # mojo.vim repo
      ".config/nvim/pack/vendor/start/moji".source = (pkgs.fetchgit {
        url = "https://github.com/czheo/mojo.vim";
        hash = "sha256-gUq2OBA1VuJFgaJCX+9GBFv0jlFL1sKuiDv/DnJl5qo=";
      });

      # obsidian.nvim repo
      ".config/nvim/pack/vendor/start/obsidian".source = (pkgs.fetchgit {
        url = "https://github.com/epwalsh/obsidian.nvim";
        hash = "sha256-t1MSU1ufujdDI6ne6AOtIqnC45JjWXtOkmFloxsrfRU=";
      });

      # otter.nvim repo
      ".config/nvim/pack/vendor/start/otter".source = (pkgs.fetchgit {
        url = "https://github.com/jmbuhr/otter.nvim";
        hash = "sha256-7y+dqDAx3EHL4A4bvWzoDi9aXwQMp4NfLgVp++XTfps=";
      });

      #  telemux repo
      ".config/nvim/pack/vendor/start/telemux".source = "/home/n/Repos/telemux-nvim";
      # ".config/nvim/pack/vendor/start/telemux".source = (pkgs.fetchgit {
      #   url = "https://github.com/n-sweep/telemux-nvim";
      #   hash = "sha256-h7sPEY5loIRVDmpxNEPNntr0jGJkipAdw3rH3o63jW4=";
      # });

      #  pvserv repo
      ".config/nvim/pack/vendor/start/pvserv".source = "/home/n/Repos/pvserv";
      # ".config/nvim/pack/vendor/start/pvserv".source = (pkgs.fetchgit {
      #   url = "https://github.com/n-sweep/pvserv";
      #   hash = "sha256-Q29bSnCJvjI8ZlPSMwUWeR/jdyhv4ZWz9HYnHqQ9n88=";
      # });

    };

    packages = with pkgs; [
      awscli
      barrier
      cmus
      cockatrice
      firebase-tools
      floorp
      gimp
      gitAndTools.gh
      obs-cli
      parsec-bin
      peek
      quarto
      sxiv
      wezterm
      zoom-us

      # base python - use devShell for dev
      (python3.withPackages (ps: with ps;[
        black
        flask
        flask-socketio
        jupyter
        jupyter-client
        jupytext
        numpy
        plotly
        pynvim
        pyperclip
        sqlparse
        virtualenv
      ]))

    ];

  };

  ### programs #################################################################

  programs.git = {
    enable = true;
    userName = "n-sweep";
    userEmail = "34486798+n-sweep@users.noreply.github.com";
    extraConfig = {
      push.autoSetupRemote = "true";
      init.defaultBranch = "main";
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = builtins.readFile "${config.home.homeDirectory}/.dotfiles/bash/.bashrc";
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile "${config.home.homeDirectory}/.dotfiles/tmux/.tmux.conf";
  };

  ### nixvim ###################################################################

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.kanagawa.enable = true;

    keymaps = [

      { # undotree
        action = ":UndotreeToggle<CR>";
        key = "<leader>u";
        options = { silent = true; };
      }

      { # oil
        action = ":Oil<CR>";
        key = "-";
        options = { silent = true; };
      }

    ];

    extraConfigVim = ''
      luafile /home/n/.dotfiles/nvim/.config/nvim/lua/user/cmd.lua
      luafile /home/n/.dotfiles/nvim/.config/nvim/lua/user/set.lua
      luafile /home/n/.dotfiles/nvim/.config/nvim/lua/user/remap.lua
      luafile /home/n/.dotfiles/nixos/nvim/lua/tmux.lua
      luafile /home/n/.dotfiles/nixos/nvim/lua/treesitter.lua
      luafile /home/n/.dotfiles/nixos/nvim/lua/obsidian.lua
      luafile /home/n/.dotfiles/nixos/nvim/lua/vim-dadbod.lua
    '';

    extraConfigLua = ''
      require("jupytext").setup({})
      require("nvim-surround").setup({})
      require("telemux")
      require("pvserv")
    '';

    files = {

      "ftplugin/nix.lua" = {
        options = {
          tabstop = 2;
          softtabstop = 2;
          shiftwidth = 2;
        };
      };

      "ftplugin/markdown.lua" = {
        extraConfigLua = ''vim.cmd([[syntax region hideAnswers matchgroup=Conceal start="^# A.*" end="$" concealends conceal]])'';
      };

    };

    plugins = {
      comment.enable = true;
      fidget.enable = true;
      markdown-preview.enable = true;
      molten.enable = true;
      nvim-autopairs.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      treesitter-textobjects.enable = true;
      which-key.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      nvim-surround
      quarto-nvim
      tmux-nvim
      undotree
      vim-dadbod
      vim-dadbod-ui
      vim-dadbod-completion
      vim-fugitive
      vim-python-pep8-indent
    ];

    plugins.lsp = {
      enable = true;
      servers = {
        lua-ls.enable = true;
        pyright.enable = true;
        nil-ls.enable = true;
      };
      keymaps = {
        lspBuf = { "<leader>k" = "hover"; };
        diagnostic = {
          "<leader>ee" = "open_float";
          "<leader>en" = "goto_next";
          "<leader>eN" = "goto_prev";
        };
      };
    };

    plugins.telescope = {
      enable = true;
      settings.defaults = { sorting_strategy = "ascending"; };
      keymaps = {
        "<leader>ff" = {
            action = "find_files";
            options.desc = "Telescope Find Files";
        };
        "<leader>fb" = {
            action = "buffers";
            options.desc = "Telescope Buffers";
        };
        "<leader>fg" = {
            action = "live_grep";
            options.desc = "Telescope Live grep";
        };
        "<leader>fc" = {
            action = "commands";
            options.desc = "Telescope vim Commands";
        };
        "<leader>fC" = {
            action = "command_history";
            options.desc = "Telescope vim Command History";
        };
        "<leader>fh" = {
            action = "help_tags";
            options.desc = "Telescope vim Help Tags";
        };
        "<leader>gg" = {
            action = "git_files";
            options.desc = "Telescope git Files";
        };
        "<leader>ld" = {
            action = "lsp_definitions";
            options.desc = "Telescope LSP Definitions";
        };
      };
    };

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        mapping = {
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-e>" = "cmp.mapping.close()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
        sources = [
          {name = "buffer";}
          {name = "nvim_lsp";}
          {name = "otter";}
          {name = "path";}
          {name = "treesitter";}
        ];
      };
    };

    plugins.harpoon = {
      enable = true;
      keymaps = {
        addFile = "<leader>a";
        toggleQuickMenu = "<C-f>";
        navFile = {
          "1" = "<leader>1";
          "2" = "<leader>2";
          "3" = "<leader>3";
          "4" = "<leader>4";
          "5" = "<leader>5";
        };
      };
    };

    plugins.lualine = {
      enable = true;
      iconsEnabled = true;
      sections.lualine_c = [{
        name = "filename";
        extraConfig = { path = 1; };
      }];
    };

  };

  ### firefox ##################################################################

  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = {
        "full-screen-api.ignore-widgets" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layout.css.devPixelsPerPx" = "0.9";
        "ui.systemUsesDarkTheme" = true;
      };
      userContent = ''
        @-moz-document url(about:newtab), url(about:privatebrowsing) {
            body::before {
                content: "";
                z-index: 100;
                position: fixed;
                background: no-repeat url('/home/n/.wallpaper');
                background-size: cover;
                background-position: center center;
                width: 100vw;
                height: 100vh;
            }
        }
      '';
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        darkreader
        ublock-origin
        # tridactyl
        vimium
      ];
    };
  };

  ### obs ######################################################################

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-websocket
    ];
  };

  ##############################################################################

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

}
