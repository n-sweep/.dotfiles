{ pkgs, ... }:
let
  rootDir = ./../..;
in
{
  imports = [
    (rootDir + /home)
    (rootDir + /home/workstation)
  ];

  # any host-specific config goes here
  home = {
    # packages = with pkgs; [ reaper ];
  };

}
