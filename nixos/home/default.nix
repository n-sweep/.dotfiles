# $man home-configuration.nix

# config in this file will be included on every machine

{ config, inputs, pkgs, ...}:
let

  # directories
  home_dir = "/home/${config.home.username}";
  config_dir = "${home_dir}/.config";
  dotfiles_dir = "${home_dir}/.dotfiles";
  nvim_plug_dir = "${config_dir}/nvim/pack/vendor/start";

  mksl = config.lib.file.mkOutOfStoreSymlink;

in {

  # imports = [
  #   ./programs.nix
  # ];

  home = {

    sessionVariables = {
      BW_CLIENTID = builtins.readFile "${config_dir}/bw/client_id";
      BW_CLIENTSECRET = builtins.readFile "${config_dir}/bw/client_secret";
      BW_EMAIL = builtins.readFile "${config_dir}/bw/email";
    };


    # symlink files to home directory
    file = {
      ".bash_aliases".source = mksl "${dotfiles_dir}/bash/.bash_aliases";
      ".inputrc".source = mksl "${dotfiles_dir}/bash/.inputrc";

      # I had to manually `rm -rf ~/.ipython/profile_default/startup` and rebuild for this to work
      ".ipython/profile_default/startup".source = mksl "${dotfiles_dir}/.ipython/profile_default/startup";

      # nvim plugins
      "${nvim_plug_dir}/pvserv".source = mksl "${home_dir}/Repos/pvserv";
      "${nvim_plug_dir}/telemux".source = mksl "${home_dir}/Repos/telemux-nvim";

    };

    packages = with pkgs; [

      bitwarden-cli
      cbonsai
      duckdb
      fastfetch
      ffmpeg-full
      firebase-tools
      gawk
      gcc-unwrapped
      gitAndTools.gh
      google-cloud-sdk
      htop
      inetutils
      jq
      lshw
      mods
      nettools
      nix-prefetch-git
      pciutils
      quarto
      ripgrep
      slop
      sqlcmd
      sqlfluff
      sqlite
      sshfs
      unzip
      uv
      zip

      # nvim
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

  programs = {

    bash = {
      enable = true;
      enableCompletion = true;
      bashrcExtra = builtins.readFile "${dotfiles_dir}/bash/.bashrc";
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
    };

    git = {
      enable = true;
      userName = "n-sweep";
      userEmail = "34486798+n-sweep@users.noreply.github.com";
      extraConfig = {
        push.autoSetupRemote = "true";
        init.defaultBranch = "main";
      };
    };

    tmux = {
      enable = true;
      extraConfig = builtins.readFile "${dotfiles_dir}/tmux/.tmux.conf";
    };

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
