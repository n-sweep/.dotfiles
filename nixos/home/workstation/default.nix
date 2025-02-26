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
      ".config/i3/config".source = mksl "${dotfiles_dir}/i3/.config/i3/config";
      ".config/i3status/config".source = mksl "${dotfiles_dir}/i3/.config/i3status/config";
      ".wezterm.lua".source = mksl "${dotfiles_dir}/wezterm/.wezterm.lua";

    };

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
      ];
    };

    packages = with pkgs; [

      autorandr
      barrier
      cockatrice
      discord
      gimp
      kcl
      obs-cmd
      parsec-bin
      screenkey
      sxiv
      wezterm
      zoom-us

      # zen browser
      inputs.zen-browser.packages.${pkgs.system}.default
      inputs.nixvim.packages.${pkgs.system}.default

    ];

  };

}
