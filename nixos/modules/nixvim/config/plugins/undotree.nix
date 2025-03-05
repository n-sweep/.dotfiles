{ ... }: {

  undotree.enable = true;

  keymaps = [

    {
      action = ":UndotreeToggle<CR>";
      key = "<leader>u";
      mode = "n";
      options = {
        silent = true;
        desc = "Toggle UndoTree";
      };
    }

  ];

}
