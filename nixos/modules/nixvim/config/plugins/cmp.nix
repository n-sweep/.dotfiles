{ ... }: {

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

}
