{ config, pkgs, ... }:

{

  imports = [ # Include the results of the hardware scan.
    ../../modules/system.nix

    # results of the hardware scan
    ./hardware-configuration.nix
  ];

  networking.hostName = "oryxpro"; # Define your hostname.

  fileSystems."/mnt/music" = {
    device = "192.168.0.112:/mnt/pool-1/media/music/library";
    fsType = "nfs";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
