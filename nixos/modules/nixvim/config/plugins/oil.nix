{ ... }: {

  plugins.oil = {
    enable = true;
    settings = {
      view_options.show_hidden = true;
      default_file_explorer = false;
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
