{
  description = "Entrypoint Flake";

  inputs = {

    # NixOS official package source, using the nixos-24.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs:
  let

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

    generate_host_configs = dirs: builtins.listToAttrs (map (dir: {
      name = dir;
      value = nixpkgs.lib.nixosSystem (common // {
        modules = [
          ./hosts/${dir}
        ] ++ common.modules or [];
      });
    }) dirs);

    host_dirs = builtins.attrNames (builtins.readDir ./hosts);

  in { nixosConfigurations = generate_host_configs host_dirs; };
}
