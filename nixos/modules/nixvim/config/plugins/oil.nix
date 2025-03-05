{ ... }: {

  oil = {
    enable = true;
    settings = {
      view_options.show_hidden = true;
    };
  };

  keymaps = [

    {
      action = ":Oil<CR>";
      key = "-";
      mode = "n";
      options = {
        silent = true;
        desc = "Open Oil";
      };
    }

  ];

}
