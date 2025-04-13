# the config in this file will be applied only to physical workstations

{ pkgs, ... }:
let
  uname = "n";
  home_dir = "/home/${uname}";
in {

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.wireless = {
    userControlled.enable = true;
    secretsFile = "${home_dir}/.config/wifi/wireless.env";
    networks = {
      "Waffle House".pskRaw = "ext:PSK_HOME";
      "Kindred Hippie".pskRaw = "ext:PSK_KH";
    };
  };

  services = {

    # xserver + i3
    displayManager.defaultSession = "none+i3";
    logind.lidSwitch = "ignore";

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      desktopManager = {
        xterm.enable = false;
        session = [{
          name = "i3";
          start = ''${pkgs.i3}/bin/i3'';
        }];
      };
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
        ];
      };
    };

  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

}
