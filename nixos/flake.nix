{
  description = "Entrypoint Flake";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "./modules/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";

    # generate config for a single host
    mkHostConfig = host: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [

        # host-specific module
        ./hosts/${host}

        # host-specific home config
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.n = ./hosts/${host}/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }

      ];
    };

    # get list of host directories
    hostDirs = builtins.attrNames (builtins.readDir ./hosts);

    # generate configs for all hosts
    nixosConfigurations = builtins.listToAttrs (map
      (host: { name = host; value = mkHostConfig host; })
      hostDirs
    );

  in { inherit nixosConfigurations; };
}
