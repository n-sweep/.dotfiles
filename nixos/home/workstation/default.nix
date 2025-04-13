# $man home-configuration.nix

# config in this file will be included only in physical workstations

{ config, inputs, pkgs, ...}:
let

  # directories
  home_dir = "/home/${config.home.username}";
  dotfiles_dir = "${home_dir}/.dotfiles";
  mksl = config.lib.file.mkOutOfStoreSymlink;

in {

  # imports = [
  #   ./programs.nix
  # ];

  home = {

    # symlink files to home directory
    file = {
      ".config/i3/config".source = mksl "${dotfiles_dir}/i3/i3_config";
      ".config/i3status/config".source = mksl "${dotfiles_dir}/i3/i3status_config";
      ".wezterm.lua".source = mksl "${dotfiles_dir}/.wezterm.lua";

    };

    packages = with pkgs; [

      autorandr
      barrier
      cmus
      cockatrice
      discord
      dunst
      feh
      gimp
      i3lock
      kcl
      libnotify
      maim
      obs-cmd
      parsec-bin
      pavucontrol
      pcmanfm
      peek
      screenkey
      sxiv
      wezterm
      xclip
      xorg.xauth
      xorg.xinit
      zoom-us

      # zen browser
      inputs.zen-browser.packages.${pkgs.system}.default

    ];

  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
    ];
  };

}
