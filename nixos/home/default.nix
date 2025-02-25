# $man home-configuration.nix
{ config, inputs, pkgs, ...}:
let

  # directories
  home_dir = "/home/${config.home.username}";
  config_dir = "${home_dir}/.config";
  dotfiles_dir = "${home_dir}/.dotfiles";
  nvim_plug_dir = "${config_dir}/nvim/pack/vendor/start";
  mksl = config.lib.file.mkOutOfStoreSymlink;

in {

  imports = [
    ./programs.nix
  ];

  home = {

    sessionVariables = {
      BW_CLIENTID = builtins.readFile "${config_dir}/bw/client_id";
      BW_CLIENTSECRET = builtins.readFile "${config_dir}/bw/client_secret";
      BW_EMAIL = builtins.readFile "${config_dir}/bw/email";
    };


    # symlink files to home directory
    file = {
      ".bash_aliases".source = mksl "${dotfiles_dir}/bash/.bash_aliases";
      ".config/i3/config".source = mksl "${dotfiles_dir}/i3/.config/i3/config";
      ".config/i3status/config".source = mksl "${dotfiles_dir}/i3/.config/i3status/config";
      ".inputrc".source = mksl "${dotfiles_dir}/bash/.inputrc";
      ".wezterm.lua".source = mksl "${dotfiles_dir}/wezterm/.wezterm.lua";

      # I had to manually `rm -rf ~/.ipython/profile_default/startup` and rebuild for this to work
      ".ipython/profile_default/startup".source = mksl "${dotfiles_dir}/.ipython/profile_default/startup";

      # nvim plugins
      "${nvim_plug_dir}/pvserv".source = mksl "${home_dir}/Repos/pvserv";
      "${nvim_plug_dir}/telemux".source = mksl "${home_dir}/Repos/telemux-nvim";

    };

    packages = with pkgs; [

      autorandr
      awscli
      barrier
      cmus
      cockatrice
      discord
      duckdb
      firebase-tools
      gimp
      gitAndTools.gh
      google-cloud-sdk
      kcl
      mods
      obs-cmd
      parsec-bin
      peek
      quarto
      screenkey
      slop
      sonic-pi
      sqlcmd
      sqlfluff
      sxiv
      tigervnc
      uv
      wezterm
      yazi
      zoom-us

      # zen browser
      inputs.zen-browser.packages.${pkgs.system}.default
      inputs.nixvim.packages.${pkgs.system}.default

      # base python - use devShell for dev
      (python312.withPackages (ps: with ps;[
        black
        flask
        flask-socketio
        jupyter
        jupyter-client
        jupytext
        lxml
        numpy
        plotly
        pynvim
        pyperclip
        sqlparse
        virtualenv
      ]))

    ];

  };

  ##############################################################################

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

}
