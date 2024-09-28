[

  { # ESC in normal mode turns off highlighting
    key = "<ESC>";
    action = ":nohl<CR>";
    mode = "n";
    options.silent = true;
  }

  { # toggle spell check
    key = "<F6>";
    action = ":set spell!<CR>";
    options.silent = true;
  }

  { # toggle line break
    key = "<F7>";
    action = ":set wrap! linebreak!<CR>";
    options.silent = true;
  }


  ### saving & quitting ###########################################################################

  {
    key = "<leader>w";
    action = ":w<CR>";
    mode = "n";
    options = {
      silent = true;
      desc = "Write file (:w)";
    };
  }

  {
    key = "<leader>qq";
    action = ":q<CR>";
    mode = "n";
    options = {
      silent = true;
      desc = "Quit this buffer (:q)";
    };
  }

  {
    key = "<leader>qQ";
    action = ":qa<CR>";
    mode = "n";
    options = {
      silent = true;
      desc = "Quit all (:qa)";
    };
  }

  {
    key = "<leader>QQ";
    action = ":qa!<CR>";
    mode = "n";
    options = {
      silent = true;
      desc = "Force quit all (:qa!)";
    };
  }

  ### Newline w/o Insert Mode #####################################################################

  {
    key = "<leader>o";
    action = "o<ESC>";
    mode = "n";
    options = {
      silent = true;
      desc = "Newline below, remain in Normal mode";
    };
  }

  {
    key = "<leader>O";
    action = "O<ESC>";
    mode = "n";
    options = {
      silent = true;
      desc = "Newline above, remain in Normal mode";
    };
  }

  ### Copying & Pasting ###########################################################################

  {
    key = "<leader>y";
    action = ''"+y'';
    mode = ["n" "v"];
    options = {
      silent = true;
      desc = "Yank selection to system clipboard";
    };
  }

  {
    key = "<leader>yy";
    action = ''"+yy'';
    mode = "n";
    options = {
      silent = true;
      desc = "Yank line to system clipboard";
    };
  }

  { # this should yank from the cursor to EOL but it does the full line instead
    key = "<leader>Y";
    action = ''"+Y'';
    mode = "n";
    options = {
      silent = true;
      desc = "Yank line to system clipboard";
    };
  }

  {
    key = "<leader>p";
    action = ''"+p'';
    mode = ["n" "v"];
    options = {
      silent = true;
      desc = "Paste from system clipboard";
    };
  }

  {
    key = "<leader>P";
    action = ''"+P'';
    mode = ["n" "v"];
    options = {
      silent = true;
      desc = "Paste from system clipboard (before cursor)";
    };
  }

  ### Ctrl/Alt/Shift + Tab/Enter ##################################################################
  # these keys should behave normally when not in normal mode

  {
    key = "<F30>";
    action = "<C-Tab>";
    mode = [ "!" "" "c" "i" "l" "o" "s" "t" "v" "x" ];
    options.silent = true;
  }

  {
    key = "<F31>";
    action = "<S-Tab>";
    mode = [ "!" "" "c" "i" "l" "o" "s" "t" "v" "x" ];
    options.silent = true;
  }

  {
    key = "<F32>";
    action = "<M-Tab>";
    mode = [ "!" "" "c" "i" "l" "o" "s" "t" "v" "x" ];
    options.silent = true;
  }

  {
    key = "<F33>";
    action = "<C-Enter>";
    mode = [ "!" "" "c" "i" "l" "o" "s" "t" "v" "x" ];
    options.silent = true;
  }

  {
    key = "<F34>";
    action = "<S-Enter>";
    mode = [ "!" "" "c" "i" "l" "o" "s" "t" "v" "x" ];
    options.silent = true;
  }

  {
    key = "<F35>";
    action = "<M-Enter>";
    mode = [ "!" "" "c" "i" "l" "o" "s" "t" "v" "x" ];
    options.silent = true;
  }

  #################################################################################################

  # {
  #   key = "";
  #   action = "";
  #   mode = "n";
  #   options = {
  #     silent = true;
  #     desc = "";
  #   };
  # }

]
