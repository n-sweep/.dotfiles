{ self, ... }:

{

  imports = [
    (self + "/modules/")

    # results of the hardware scan
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixvm"; # Define your hostname.

  # the "do not change" part goes here

}
