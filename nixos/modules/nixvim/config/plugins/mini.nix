{ ... }: {

    plugins.mini = {
      enable = true;
      modules = {
        diff.enable = true;
        git.enable = true;
        icons.enable = true;
        statusline.enable = true;
      };
    };

    autoCmd = [

      {
        desc = "mini.diff: ignore ipynb files";
        event = "FileType";
        pattern = "ipynb";
        callback = { __raw = ''
          function (args)
            vim.b[args.buf].minidiff_disable = true
          end
        ''; };
      }

    ];

}
