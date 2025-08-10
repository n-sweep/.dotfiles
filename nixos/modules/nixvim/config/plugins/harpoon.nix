{ ... }:
let

  fileNav = builtins.genList (i:
    let
      istr = toString i;
      izero = toString (if i < 1 then "10" else i);
    in {
        key = "<leader>" + istr;
        action.__raw = "function() require'harpoon':list():select(" + izero + ") end";
        mode = "n";
        options.desc = "Harpoon goto file " + istr;
      }) 10;

in
{

  plugins.harpoon = {
    enable = true;
    enableTelescope = true;
  };

  keymaps = [

    {
      key = "<leader>a";
      action.__raw = "function() require'harpoon':list():add() end";
      mode = "n";
      options = {
        silent = true;
        desc = "Harpoon the current file";
      };
    }

    {
      key = "<C-h>";
      action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
      mode = "n";
      options = {
        silent = true;
        desc = "Harpoon show list";
      };
    }

  ] ++ fileNav;

}
