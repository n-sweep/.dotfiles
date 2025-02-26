{ self, ... }:

{
  imports = [
    (self + "/home")
    (self + "/home/workstation")
  ];

  # any host-specific config goes here
  home = {};

}
