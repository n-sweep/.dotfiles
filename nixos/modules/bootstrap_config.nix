# this is a bootstrapping config for nixos installation it is the default
# config with comments removed, plus the minimum packages needed to acquire all
# the necessary repositories/authentication to build the full configuration

{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  networking.hostName = "osgiliath";
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  users.users.n = {
    isNormalUser = true;
    description = "n";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  services.getty.autologinUser = "n";
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    bitwarden-cli
    fzf
    gh
    git
    jq
    neovim
    ripgrep
  ];
  services = {
    openssh.enable = true;
    tailscale.enable = true;
  };
  system.stateVersion = "replace.me";
}
