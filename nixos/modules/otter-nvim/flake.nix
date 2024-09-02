{
  description = "A flake for otter.nvim";

  outputs = { self, nixpkgs }: {
    # Define your packages or configurations
    packages.x86_64-linux = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux ;
    in pkgs.stdenv.mkDerivation {
      pname = "otter-nvim";
      version = "1.0";

      src = pkgs.fetchgit {
        url = "https://github.com/jmbuhr/otter.nvim";
        sha256 = "sha256-euHwoK2WHLF/hrjLY2P4yGrIbYyBN38FL3q4CKNZmLY=";
      };

      installPhase = ''
        mkdir -p $out
        cp -r $src/* $out
      '';

    };
  };
}
