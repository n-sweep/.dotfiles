{ ... }:
let
  rootDir = ./../..;
in
{
  imports = [
    (rootDir + /home)
  ];

  # any host-specific config goes here
  home = {};

}
