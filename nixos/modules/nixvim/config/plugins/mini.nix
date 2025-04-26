{ ... }: {

    plugins.mini = {
      enable = true;
      mockDevIcons = true;
      modules = {
        diff.enable = true;
        git.enable = true;
        icons.enable = true;
        statusline.enable = true;
      };
    };

}
