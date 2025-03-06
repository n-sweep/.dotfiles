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

}
