{ ... }: {

    plugins.image.enable = true;  # dependency
    plugins.molten = {
      enable = true;

      settings = {
        auto_image_popup = false;
        auto_init_behavior = "init";
        auto_open_html_in_browser = false;
        auto_open_output = true;
        cover_empty_lines = false;
        copy_output = false;
        enter_output_behavior = "open_then_enter";
        image_provider = "image.nvim";
        output_crop_border = true;
        output_virt_lines = false;
        output_win_border = [ "" "━" "" "" ];
        output_win_hide_on_leave = true;
        output_win_max_height = 15;
        output_win_max_width = 80;
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

}
