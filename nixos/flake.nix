{
  description = "Entrypoint Flake";

  inputs = {

    # NixOS official package source, using the nixos-24.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    common = {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.n = import ./home;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };

    nixosConfigurations = {

      nixvm = nixpkgs.lib.nixosSystem (common // {
        modules = [./hosts/nixvm] ++ common.modules or [];
      });

      nixvm = nixpkgs.lib.nixosSystem (common // {
        modules = [./hosts/xps] ++ common.modules or [];
      };

    };

  };
}
