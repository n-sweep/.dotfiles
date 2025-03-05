{ ... }: {

  treesitter = {
    enable = true;
    settings = {
      highlight.enable = true;
      auto_install = true;
      ensure_installed = [
        # https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
        "bash"
        "c"
        "diff"
        "gitattributes"
        "gitcommit"
        "git_config"
        "gitignore"
        "git_rebase"
        "go"
        "json"
        "lua"
        "markdown"
        "markdown_inline"
        "nix"
        "python"
        "regex"
        "sql"
        "ssh_config"
        "tmux"
        "vhs"
        "vim"
        "vimdoc"
        "yaml"
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

}
