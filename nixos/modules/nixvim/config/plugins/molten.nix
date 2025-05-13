{ ... }: {

    plugins.image.enable = true;  # dependency
    plugins.molten = {

      enable = true;

      settings = {
        auto_open_output = false;
        enter_output_behavior = "open_and_enter";
        image_provider = "image.nvim";

        virt_text_output = true;
        virt_text_max_lines = 15;

        output_crop_border = true;
        output_virt_lines = false;
        output_win_border = [ "" "━" "" "" ];
        output_win_hide_on_leave = true;
        output_win_max_height = 15;

        save_path.__raw = "vim.fn.stdpath('data')..'/molten'";
        tick_rate = 500;
        use_border_highlights = false;
        limit_output_chars = 10000;
        wrap_output = false;
      };

      python3Dependencies = p: with p; [
        cairosvg
        ipykernel
        ipython
        jupyter-client
        kaleido
        nbformat
        plotly
        pnglatex
        pynvim
        pyperclip
      ];

    };

    keymaps = [

      {
        action = ":luafile ${./lua/molten_init.lua}<CR>";
        key = "<leader>mI";
        mode = "n";
        options = {
          silent = true;
          desc = "Molten Init";
        };
      }

      {
        action = ":MoltenDeinit<CR>";
        key = "<leader>mD";
        mode = "n";
        options = {
          silent = true;
          desc = "Molten Deinit";
        };
      }

    ];

    extraFiles."lua/molten_overlay.lua".source = ./lua/molten_overlay.lua;

    autoCmd = [

      {
        event = "User";
        pattern = "MoltenInitPost";
        desc = "Molten notebook setup for ipynb files";
        callback.__raw = ''
          function(args)
            local filename = vim.api.nvim_buf_get_name(args.buf)
            if filename:match("%.ipynb$") then
              require("molten_overlay").setup()
            end
          end
        '';
      }

    ];

}
