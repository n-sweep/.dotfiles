{ self, ... }:

{
  imports = [
    (self + "/home")
  ];

  # any host-specific config goes here
  home = {};

}
