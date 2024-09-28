{ config, inputs, pkgs, ... }:
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

    firefox = {
      enable = true;
      profiles.default = {
        id = 0;
        name = "default";
        settings = {
          "full-screen-api.ignore-widgets" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "layout.css.devPixelsPerPx" = "0.9";
          "ui.systemUsesDarkTheme" = true;
        };
        userContent = ''
          @-moz-document url(about:newtab), url(about:privatebrowsing) {
              body::before {
                  content: "";
                  z-index: 100;
                  position: fixed;
                  background: no-repeat url('/home/n/.wallpaper');
                  background-size: cover;
                  background-position: center center;
                  width: 100vw;
                  height: 100vh;
              }
          }
        '';
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          bitwarden
          darkreader
          ublock-origin
          # tridactyl
          vimium
        ];
      };
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
