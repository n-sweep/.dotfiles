{ pkgs, ... }:
{

  imports = [
    (import ./plugins { inherit pkgs; })
    ./keymaps.nix
  ];

  enableMan = true;

  globals = {
    mapleader = " ";
    loaded_netrw = 1;
    loaded_netrwPlugin = 1;
  };

  opts = {
    number = true;
    relativenumber = true;
    cursorline = true;

    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;
    expandtab = true;
    smartindent = true;

    conceallevel = 1;
    scrolloff = 1919;
    signcolumn = "yes";
    colorcolumn = "100";
    wrap = false;

    incsearch = true;
    inccommand = "split";
    mouse = "";
    errorbells = false;
    termguicolors = true;

    undofile = true;
    swapfile = false;
    backup = false;
  };

  autoCmd = [

    {
      desc = "open telescope when opening a directory rather than a file";
      event = "VimEnter";
      pattern = "*";
      callback = { __raw = ''
        function ()
          if vim.fn.isdirectory(vim.fn.expand("%")) == 1 or vim.fn.argc() == 0 then
            vim.schedule(function () require('telescope.builtin').find_files() end)
          end
        end
      ''; };
    }

    {
      desc = "remove trailing whitespace on save";
      event = "BufWritePre";
      pattern = "*";
      callback = { __raw = ''
        function ()
            if vim.bo.filetype ~= 'markdown' then
                vim.cmd([[%s/\s\+$//e]])
            end
        end
      ''; };
    }

    {
      desc = "mometarily highlight yanked text";
      event = "TextYankPost";
      pattern = "*";
      callback = { __raw = ''
        function ()
            vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 40 })
        end
      ''; };
    }

  ];

  files = {

    "ftplugin/nix.lua" = {
      opts = {
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
      };
    };

    "ftplugin/markdown.lua" = {
      extraConfigLua = ''vim.cmd([[syntax region hideAnswers matchgroup=Conceal start="^# A.*" end="$" concealends conceal]])'';
    };

  };

}
