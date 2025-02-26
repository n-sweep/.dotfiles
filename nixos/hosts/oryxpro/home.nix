{ self, ... }:

{
  imports = [
    (self + "/home")
  ];

  # host-specific config goes here
  home = {};

}
