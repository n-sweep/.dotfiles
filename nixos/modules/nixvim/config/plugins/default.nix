{ pkgs, ... }: {

  keymaps = [

    { # undotree
      action = ":UndotreeToggle<CR>";
      key = "<leader>u";
      mode = "n";
      options = {
        silent = true;
        desc = "Toggle UndoTree";
      };
    }

    { # oil
      action = ":Oil<CR>";
      key = "-";
      mode = "n";
      options = {
        silent = true;
        desc = "Open Oil";
      };
    }

  ];

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

  extraConfigLua = builtins.concatStringsSep "\n" (map builtins.readFile [
    ./colorschemes.lua
    ./tmux.lua
    ./vim-dadbod.lua
  ]);

  plugins = {

    comment.enable = true;
    fidget.enable = true;
    fugitive.enable = true;
    jupytext.enable = true;
    markdown-preview.enable = true;
    nvim-autopairs.enable = true;
    nvim-surround.enable = true;
    oil.enable = true;
    otter.enable = true;
    undotree.enable = true;
    web-devicons.enable = true;
    which-key.enable = true;

    # try later
    # codium-nvim.enable = true;
    # gitignore.enable = true;
    # molten.enable = true;
    # qmk.enable = true;

    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        mapping = {
          "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";

          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-e>" = "cmp.mapping.close()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-y>" = "cmp.mapping.confirm({ select = true })";
        };
        sources = [
          {name = "buffer";}
          {name = "cmp-nvim-lsp";}
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "treesitter";}
        ];
      };
    };

    harpoon = {
      enable = true;
      enableTelescope = true;
      keymaps = {
        addFile = "<leader>a";
        toggleQuickMenu = "<C-h>";
        navFile = {
          "1" = "<leader>1";
          "2" = "<leader>2";
          "3" = "<leader>3";
          "4" = "<leader>4";
          "5" = "<leader>5";
        };
      };
    };

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

    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        dockerls.enable = true;
        jsonls.enable = true;
        marksman.enable = true;
        nil-ls.enable = true;
        pyright.enable = true;
        sqls.enable = true;

        lua-ls = {
          enable = true;
          settings = {
            diagnostics.globals = [ "vim" ];
          };
        };

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

    obsidian = {
      enable = true;
      settings = {
        completion.nvim_cmp = true;
        follow_url_func = { __raw = ''
          function(url)
            vim.fn.jobstart({"zen", url})
          end
        ''; };
        new_notes_location = "notes_subdir";
        templates = {
          date_format = "%Y-%m-%d";
          subdir = "~/Obsidian/slipbox/templates";
          substitutions = {
            title_date = { __raw = ''
              function()
                return os.date("%A, %B %d")
              end
            ''; };
          };
        };
        workspaces = [
          {
            name = "slipbox";
            path = "~/Obsidian/slipbox";
            overrides = {
              notes_subdir = "notes";
              daily_notes = {
                folder = "notes/daily";
                template = "daily.md";
              };
            };
          }
        ];
      };
      luaConfig.post = builtins.readFile ./obsidian.lua;
    };

    telescope = {
      enable = true;

      settings = {
        defaults = { sorting_strategy = "ascending"; };
        pickers = {
          find_files = {
            hidden = true;
            find_command = ''rg --files --hidden --glob !**/.git/*'';
          };
        };
      };

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

    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        auto_install = true;
        ensure_installed = [
          # https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
          "bash" "c" "diff" "gitattributes" "gitcommit" "git_config" "gitignore" "git_rebase" "go"
          "json" "lua" "markdown" "markdown_inline" "nix" "python" "regex" "sql" "ssh_config"
          "tmux" "vhs" "vim" "vimdoc" "yaml"
        ];
      };
    };

    treesitter-textobjects = {
      enable = true;
      select = {
        enable = true;
        lookahead = true;
        keymaps = {
            "af" = {
                query = "@function.outer";
                desc = "Around Function";
            };
            "if" = {
                query = "@function.inner";
                desc = "Inside Function";
            };
            "ac" = {
                query = "@class.outer";
                desc = "Around Class";
            };
            "ic" = {
                query = "@class.inner";
                desc = "Inside Class";
            };
        };
      };
    };

  };
}
