{ ... }: {

  plugins.telescope = {
    enable = true;

    settings = {

      defaults = {
        sorting_strategy = "ascending";
        vimgrep_arguments = [
          "rg"
          "--color=never"
          "--no-heading"
          "--with-filename"
          "--line-number"
          "--column"
          "--smart-case"
          "--hidden"
          "--glob"
          "!**/.git/*"
        ];
      };

      pickers = {
        find_files = {
          hidden = true;
          find_command = [ "rg" "--files" "--hidden" "--glob" "!**/.git/*" ];
        };
      };

    };

    keymaps = {
      "<leader>sr" = {
          action = "resume";
          options.desc = "Telescope Resume";
      };
      "<leader>sf" = {
          action = "find_files";
          options.desc = "Telescope Find Files";
      };
      "<leader>sb" = {
          action = "buffers";
          options.desc = "Telescope Buffers";
      };
      "<leader>sg" = {
          action = "live_grep";
          options.desc = "Telescope Live grep";
      };
      "<leader>sc" = {
          action = "commands";
          options.desc = "Telescope vim Commands";
      };
      "<leader>sC" = {
          action = "command_history";
          options.desc = "Telescope vim Command History";
      };
      "<leader>sh" = {
          action = "help_tags";
          options.desc = "Telescope vim Help Tags";
      };
      "<leader>sG" = {
          action = "git_files";
          options.desc = "Telescope git Files";
      };
      "<leader>ld" = {
          action = "lsp_definitions";
          options.desc = "Telescope LSP Definitions";
      };
    };

  };

}
