# $man home-configuration.nix
{ config, inputs, pkgs, ...}:
let

  # directories
  home_dir = "/home/${config.home.username}";
  config_dir = "${home_dir}/.config";
  dotfiles_dir = "${home_dir}/.dotfiles";
  nvim_plug_dir = "${config_dir}/nvim/pack/vendor/start";

in {

  imports = [
    ./programs.nix
  ];

  home = {

    username = "n";

    sessionVariables = {
      BW_CLIENTID = builtins.readFile "${config_dir}/bw/client_id";
      BW_CLIENTSECRET = builtins.readFile "${config_dir}/bw/client_secret";
      BW_EMAIL = builtins.readFile "${config_dir}/bw/email";
    };


    # source files to home directory
    file = {
      ".bash_aliases".source = "${dotfiles_dir}/bash/.bash_aliases";
      ".config/i3/config".source = "${dotfiles_dir}/i3/.config/i3/config";
      ".config/i3status/config".source = "${dotfiles_dir}/i3/.config/i3status/config";
      ".inputrc".source = "${dotfiles_dir}/bash/.inputrc";
      ".wezterm.lua".source = "${dotfiles_dir}/wezterm/.wezterm.lua";

      # nvim plugins
      "${nvim_plug_dir}/pvserv".source = "/home/n/Repos/pvserv";
      "${nvim_plug_dir}/telemux".source = "/home/n/Repos/telemux-nvim";

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
      sxiv
      tailscale
      tigervnc
      uv
      wezterm
      yazi
      zoom-us

      # zen browser
      inputs.zen-browser.packages.${pkgs.system}.default
      inputs.nixvim.packages.${pkgs.system}.default

      # 2024-09 wezterm has a visual bug; use older version
      # inputs.nixpkgs-stable.legacyPackages.${pkgs.system}.wezterm

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
