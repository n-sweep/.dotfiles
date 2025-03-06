{ ... }: {

  plugins.lsp = {
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

}
