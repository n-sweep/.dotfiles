{ config, pkgs, ... }:
let
  home_dir = "/home/${config.home.username}";
  dotfiles_dir = "${home_dir}/.dotfiles";
in
{
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

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
      ];
    };

    tmux = {
      enable = true;
      extraConfig = builtins.readFile "${dotfiles_dir}/tmux/.tmux.conf";
    };

  };
}
