{
  description = "A flake for jupytext.nvim";

  outputs = { self, nixpkgs }: {
    # Define your packages or configurations
    packages.x86_64-linux = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux ;
    in pkgs.stdenv.mkDerivation {
      pname = "jupytext-nvim";
      version = "1.0";

      src = pkgs.fetchgit {
        url = "https://github.com/GCBallesteros/jupytext.nvim";
        sha256 = "sha256-LBBRZOSqn70qruSA/vbPMTzS7y05F/z4EqC+5JlU6NM=";
      };

      installPhase = ''
        mkdir -p $out
        cp -r $src/* $out
      '';

    };
  };
}
