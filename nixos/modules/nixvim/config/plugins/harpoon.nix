{ ... }:
let

  navFile = builtins.listToAttrs (
    builtins.genList (i: {
        name = toString i;
        value = "<leader>" + (if i < 1 then "10" else toString i);
      }) 10
  );

in
{

  plugins.harpoon = {

    enable = true;
    enableTelescope = true;

    keymaps = {
      addFile = "<leader>a";
      toggleQuickMenu = "<C-h>";
      inherit navFile;
    };

  };

}
