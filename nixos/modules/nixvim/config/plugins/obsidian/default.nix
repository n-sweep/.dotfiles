{ ... }: {

  obsidian = {

    enable = true;

    settings = {

      completion.nvim_cmp = true;
      new_notes_location = "notes_subdir";

      follow_url_func = { __raw = ''
        function(url)
          vim.fn.jobstart({"zen", url})
        end
      ''; };

      templates = {

        date_format = "%Y-%m-%d";
        subdir = "~/Obsidian/slipbox/templates";

        substitutions.title_date = { __raw = ''
          function()
            return os.date("%A, %B %d")
          end
        '';};

      };

      workspaces = [

        {
          name = "slipbox";
          path = "~/Obsidian/slipbox";
          overrides = {
            notes_subdir = "notes";
            daily_notes = {
              folder = "notes/daily";
              template = "daily.md";
            };
          };
        }

      ];

    };

    luaConfig.post = builtins.readFile ./config.lua;

  };

}
