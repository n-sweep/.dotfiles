{
  description = "A flake for scnvim";

  outputs = { self, nixpkgs }: {
    # Define your packages or configurations
    packages.x86_64-linux = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux ;
    in pkgs.stdenv.mkDerivation {
      pname = "scnvim";
      version = "1.0";

      src = pkgs.fetchgit {
        url = "https://github.com/davidgranstrom/scnvim";
        sha256 = "sha256-N1lfoIT8bHQhgIQzwv34dDY7O7yFvsn9pGYCHIB4Mvw=";
      };

      installPhase = ''
        mkdir -p "$out"
        cp -r "$src"/* "$out"
      '';

    };
  };
}